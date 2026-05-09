package org.example.compassenglish.service;

import org.example.compassenglish.model.*;
import org.example.compassenglish.model.enums.*;
import org.example.compassenglish.repository.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Servicio de progreso del alumno en Compass English.
 *
 * <p>Analiza los registros de sesión ({@link SessionLog}) para construir
 * y mantener el perfil de aprendizaje del alumno por tema ({@link UserProgress}).</p>
 *
 * <p>Las métricas calculadas se fundamentan en:</p>
 * <ul>
 *   <li><b>Swain (1985)</b>: distinción entre intentos de producción activa
 *       (TRANSLATE, FILL_GAP) y reconocimiento pasivo (MULTIPLE_CHOICE).</li>
 *   <li><b>Selinker (1972) / Corder (1967)</b>: análisis del perfil de errores
 *       por tipo ({@link ErrorType}) como indicador de interlengua del alumno.</li>
 *   <li><b>Krashen (1982)</b>: recálculo del nivel estimado (i+1) cuando el alumno
 *       consolida el 70% del vocabulario de su nivel actual.</li>
 * </ul>
 *
 * @author Nassim Bouderbane Marrero
 */
@Service
@Transactional
public class ProgressService {

    private final SessionLogRepository   sessionLogRepository;
    private final UserProgressRepository userProgressRepository;
    private final ThemeRepository        themeRepository;
    private final WordRepository         wordRepository;
    private final UserRepository         userRepository;

    public ProgressService(SessionLogRepository sessionLogRepository,
                           UserProgressRepository userProgressRepository,
                           ThemeRepository themeRepository,
                           WordRepository wordRepository,
                           UserRepository userRepository) {
        this.sessionLogRepository  = sessionLogRepository;
        this.userProgressRepository = userProgressRepository;
        this.themeRepository       = themeRepository;
        this.wordRepository        = wordRepository;
        this.userRepository        = userRepository;
    }

    // ----------------------------------------------------------------
    // Se llama al finalizar cada sesión
    // Actualiza UserProgress y recalcula el nivel estimado del alumno
    // ----------------------------------------------------------------

    /**
     * Actualiza el perfil de progreso del alumno al finalizar una sesión.
     *
     * <p>Agrupa los logs de la sesión por tema y actualiza para cada uno:</p>
     * <ul>
     *   <li>Intentos totales, correctos, de producción y de reconocimiento.</li>
     *   <li>Tiempo de respuesta medio (indicador de fluencia).</li>
     *   <li>Tendencia respecto a la sesión anterior (IMPROVING / STABLE / DECLINING).</li>
     * </ul>
     * <p>Al finalizar recalcula el nivel CEFR estimado del alumno.</p>
     *
     * @param userId      identificador del usuario
     * @param sessionDate fecha de la sesión a procesar
     */
    public void updateProgress(int userId, LocalDate sessionDate) {

        List<SessionLog> logs = sessionLogRepository
                .findByUserIdAndSessionDate(userId, sessionDate);

        if (logs.isEmpty()) return;

        // Agrupar logs por tema de la palabra
        Map<Integer, List<SessionLog>> byTheme = new HashMap<>();
        for (SessionLog log : logs) {
            if (log.getWord() == null) continue;
            for (Theme theme : log.getWord().getThemes()) {
                byTheme.computeIfAbsent(theme.getId(), k -> new ArrayList<>()).add(log);
            }
        }

        for (Map.Entry<Integer, List<SessionLog>> entry : byTheme.entrySet()) {
            int themeId   = entry.getKey();
            List<SessionLog> themeLogs = entry.getValue();

            Theme theme = themeRepository.findById(themeId).orElse(null);
            if (theme == null) continue;

            UserProgress progress = userProgressRepository
                    .findByUserIdAndThemeId(userId, themeId)
                    .orElse(new UserProgress(
                            userRepository.findById(userId).orElseThrow(),
                            theme));

            // Tasa de acierto anterior (para calcular trend)
            double oldRate = progress.getTotalAttempts() == 0 ? 0
                    : (double) progress.getCorrectAttempts() / progress.getTotalAttempts();

            long correct   = themeLogs.stream().filter(SessionLog::isCorrect).count();
            long total     = themeLogs.size();
            double newRate = (double) correct / total;

            // Producción vs reconocimiento (Swain Output Hypothesis, 1985)
            long production  = themeLogs.stream()
                    .filter(l -> l.getExerciseType() == ExerciseType.TRANSLATE
                              || l.getExerciseType() == ExerciseType.FILL_GAP)
                    .count();
            long recognition = themeLogs.stream()
                    .filter(l -> l.getExerciseType() == ExerciseType.MULTIPLE_CHOICE)
                    .count();

            // Tiempo de respuesta medio (fluencia real — Accuracy vs Fluency)
            OptionalDouble avgMs = themeLogs.stream()
                    .filter(l -> l.getResponseMs() != null)
                    .mapToInt(SessionLog::getResponseMs)
                    .average();

            // Actualizar acumulados
            progress.setTotalAttempts(progress.getTotalAttempts() + (int) total);
            progress.setCorrectAttempts(progress.getCorrectAttempts() + (int) correct);
            progress.setProductionAttempts(progress.getProductionAttempts() + (int) production);
            progress.setRecognitionAttempts(progress.getRecognitionAttempts() + (int) recognition);
            if (avgMs.isPresent())
                progress.setAvgResponseMs((int) avgMs.getAsDouble());
            progress.setLastUpdated(sessionDate);

            // Calcular tendencia respecto a la sesión anterior
            if      (newRate > oldRate + 0.1) progress.setTrend(Trend.IMPROVING);
            else if (newRate < oldRate - 0.1) progress.setTrend(Trend.DECLINING);
            else                              progress.setTrend(Trend.STABLE);

            userProgressRepository.save(progress);
        }

        // Recalcular nivel estimado del alumno (i+1 — Krashen, 1982)
        recalculateLevel(userId);
    }

    // ----------------------------------------------------------------
    // Temas débiles — los usa la sesión para priorizar contenido
    // ----------------------------------------------------------------

    /**
     * Devuelve los temas débiles del alumno: aquellos con tendencia DECLINING
     * o tasa de acierto inferior al 60%.
     *
     * <p>Usado por el frontend para mostrar advertencias y priorizar
     * el contenido de las próximas sesiones.</p>
     *
     * @param userId identificador del usuario
     * @return lista de temas con bajo rendimiento
     */
    public List<Theme> getWeakThemes(int userId) {
        List<UserProgress> all = userProgressRepository.findByUserId(userId);
        List<Theme> weak = new ArrayList<>();
        for (UserProgress p : all) {
            double rate = p.getTotalAttempts() == 0 ? 0
                    : (double) p.getCorrectAttempts() / p.getTotalAttempts();
            if (p.getTrend() == Trend.DECLINING || rate < 0.6) {
                weak.add(p.getTheme());
            }
        }
        return weak;
    }

    // ----------------------------------------------------------------
    // Análisis de errores por tipo (Selinker, 1972)
    // ----------------------------------------------------------------

    /**
     * Devuelve el recuento de errores cometidos por el alumno agrupados
     * por tipo de error según la taxonomía de interlengua de Selinker (1972).
     *
     * <p>Permite al frontend mostrar el perfil de interlengua del alumno:
     * qué mecanismos de error predominan (falsos amigos, sobregeneralización,
     * errores de contexto o vocabulario general), facilitando la
     * retroalimentación metacognitiva sobre los patrones de error.</p>
     *
     * <p>Solo contabiliza respuestas incorrectas con {@link ErrorType} clasificado.
     * Los aciertos se ignoran.</p>
     *
     * @param userId identificador del usuario
     * @return mapa {@code ErrorType → cantidad de errores}
     */
    public Map<ErrorType, Long> getErrorSummary(int userId) {
        return sessionLogRepository.findByUserId(userId).stream()
                .filter(l -> !l.isCorrect() && l.getErrorType() != null)
                .collect(Collectors.groupingBy(SessionLog::getErrorType, Collectors.counting()));
    }

    // ----------------------------------------------------------------
    // Recálculo del nivel CEFR estimado (i+1 — Krashen, 1982)
    // ----------------------------------------------------------------

    /**
     * Recalcula el nivel CEFR estimado del alumno al final de cada sesión.
     *
     * <p>Si el alumno ha consolidado el 70% o más del vocabulario de su
     * nivel actual (palabras vistas correctamente de forma única), sube
     * al siguiente nivel. Implementa el concepto de i+1 de Krashen (1982):
     * el input debe ser ligeramente superior al nivel actual para producir
     * adquisición real.</p>
     *
     * @param userId identificador del usuario
     */
    private void recalculateLevel(int userId) {
        User user = userRepository.findById(userId).orElseThrow();
        Level current = user.getLevelEstimated();

        long totalInLevel = wordRepository.findByLevel(current).size();
        if (totalInLevel == 0) return;

        // Palabras vistas correctamente al menos una vez en este nivel
        long consolidatedInLevel = sessionLogRepository
                .findByUserId(userId).stream()
                .filter(l -> l.isCorrect()
                          && l.getWord() != null
                          && l.getWord().getLevel() == current)
                .map(l -> l.getWord().getId())
                .distinct()
                .count();

        double ratio = (double) consolidatedInLevel / totalInLevel;

        if (ratio >= 0.7) {
            Level next = nextLevel(current);
            if (next != current) {
                user.setLevelEstimated(next);
                userRepository.save(user);
            }
        }
    }

    /**
     * Devuelve el siguiente nivel CEFR al proporcionado.
     * Si ya es el nivel máximo ({@link Level#ADVANCED}), lo devuelve sin cambio.
     *
     * @param level nivel actual
     * @return siguiente nivel en la progresión CEFR
     */
    private Level nextLevel(Level level) {
        return switch (level) {
            case BEGINNER     -> Level.INTERMEDIATE;
            case INTERMEDIATE -> Level.ADVANCED;
            case ADVANCED     -> Level.ADVANCED;
        };
    }

    // ----------------------------------------------------------------
    // Dashboard
    // ----------------------------------------------------------------

    /**
     * Devuelve el perfil completo de progreso del alumno por tema.
     * Usado por el dashboard del frontend para mostrar métricas acumuladas.
     *
     * @param userId identificador del usuario
     * @return lista de {@link UserProgress} con todos los temas trabajados
     */
    public List<UserProgress> getProgressByUser(int userId) {
        return userProgressRepository.findByUserId(userId);
    }
}
