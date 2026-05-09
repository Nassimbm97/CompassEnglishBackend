package org.example.compassenglish.service;

import org.example.compassenglish.model.*;
import org.example.compassenglish.model.enums.*;
import org.example.compassenglish.repository.*;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

/**
 * Servicio central de ejercicios de Compass English.
 *
 * <p>Gestiona el ciclo completo de una sesión de aprendizaje:</p>
 * <ul>
 *   <li>Selección de palabras según el modo ({@link LearningMode})</li>
 *   <li>Validación de respuestas con soporte de sinónimos vía Merriam</li>
 *   <li>Clasificación de errores según la taxonomía de Selinker (interlengua, 1972)</li>
 *   <li>Feedback diferenciado por tipo de error — noticing (Schmidt, 1990)</li>
 *   <li>Delegación del algoritmo FSRS-4.5 a {@link FsrsService}</li>
 * </ul>
 *
 * <p>La progresión de tipos de ejercicio implementa la hipótesis del output
 * comprensible de Swain (1985): de reconocimiento pasivo (NEW) a producción
 * activa (LEARNING) y uso contextualizado (REVIEW).</p>
 *
 * @author Nassim Bouderbane Marrero
 */
@Service
public class ExerciseService {

    private final WordRepository            wordRepository;
    private final WordCopyRepository        wordCopyRepository;
    private final UserWordRepository        userWordRepository;
    private final SessionLogRepository      sessionLogRepository;
    private final FillGapExerciseRepository fillGapRepository;
    private final MerriamSpanishService     merriamSpanish;
    private final UserRepository            userRepository;
    private final FsrsService               fsrsService;

    /** Umbral de respuesta rápida — por debajo se considera producción fluida (Easy, rating 4). */
    private static final int MS_EASY = 3000;

    /** Umbral de respuesta media — por encima se considera producción forzada (Hard, rating 2). */
    private static final int MS_GOOD = 8000;

    /**
     * Rachas activas por userId en memoria.
     * Limitación conocida: se pierden al reiniciar el servidor.
     */
    private final Map<Integer, Integer> streaks = new HashMap<>();

    public ExerciseService(WordRepository wordRepository,
                           WordCopyRepository wordCopyRepository,
                           UserWordRepository userWordRepository,
                           SessionLogRepository sessionLogRepository,
                           FillGapExerciseRepository fillGapRepository,
                           MerriamSpanishService merriamSpanish,
                           UserRepository userRepository,
                           FsrsService fsrsService) {
        this.wordRepository       = wordRepository;
        this.wordCopyRepository   = wordCopyRepository;
        this.userWordRepository   = userWordRepository;
        this.sessionLogRepository = sessionLogRepository;
        this.fillGapRepository    = fillGapRepository;
        this.merriamSpanish       = merriamSpanish;
        this.userRepository       = userRepository;
        this.fsrsService          = fsrsService;
    }

    // ----------------------------------------------------------------
    // SESIÓN
    // ----------------------------------------------------------------

    /**
     * Devuelve las palabras que forman la sesión del usuario.
     * EVALUATION: palabras con dueDate vencido según FSRS.
     * FREE: palabras del nivel estimado en orden aleatorio (i+1 Krashen).
     *
     * @param user usuario autenticado
     * @return lista de palabras para la sesión
     */
    public List<Word> getSessionWords(User user) {
        if (user.getLearningMode() == LearningMode.EVALUATION) {
            return userWordRepository
                    .findDueByUser(user.getId(), LocalDateTime.now())
                    .stream().map(UserWord::getWord).toList();
        } else {
            Level level = user.getLevelEstimated() != null
                    ? user.getLevelEstimated() : Level.BEGINNER;
            List<Word> words = new ArrayList<>(wordRepository.findByLevel(level));
            if (words.isEmpty()) words = new ArrayList<>(wordRepository.findAll());
            Collections.shuffle(words);
            return words;
        }
    }

    /**
     * Devuelve un tipo de ejercicio aleatorio entre los disponibles.
     *
     * @return tipo de ejercicio seleccionado al azar
     */
    public ExerciseType randomExerciseType() {
        ExerciseType[] types = {
            ExerciseType.TRANSLATE,
            ExerciseType.MULTIPLE_CHOICE,
            ExerciseType.FILL_GAP
        };
        return types[new Random().nextInt(types.length)];
    }

    /**
     * Genera las opciones para un ejercicio de opción múltiple.
     * Incluye la respuesta correcta y hasta 3 distractores del mismo nivel.
     *
     * @param correct palabra correcta
     * @param level   nivel del alumno para filtrar distractores
     * @return lista de opciones mezcladas
     */
    public List<String> generateOptions(Word correct, Level level) {
        List<Word> pool = new ArrayList<>(wordRepository.findByLevel(level));
        if (pool.isEmpty()) pool = new ArrayList<>(wordRepository.findAll());
        pool.removeIf(w -> w.getId() == correct.getId());
        Collections.shuffle(pool);

        List<String> options = new ArrayList<>();
        options.add(correct.getWordEng());
        for (int i = 0; i < Math.min(3, pool.size()); i++) options.add(pool.get(i).getWordEng());
        Collections.shuffle(options);
        return options;
    }

    // ----------------------------------------------------------------
    // COMPROBAR RESPUESTA
    // Flujo:
    //   1. Comprueba en Word (traducción canónica)
    //   2. Comprueba en WordCopy (sinónimos ya cacheados)
    //   3. Llama a Merriam Spanish-English para validar
    //      -> Si es válida: cachea en WordCopy + aviso NEW_TRANSLATION_ACCEPTED
    //      -> Si no es válida: incorrecto
    //      -> Si Merriam no tiene datos: aviso MERRIAM_NO_DATA
    // ----------------------------------------------------------------

    /**
     * Valida la respuesta del alumno para una palabra dada.
     * Aplica FSRS (delegado a FsrsService) y genera feedback con noticing (Schmidt, 1990).
     *
     * @param user       usuario que responde
     * @param word       palabra evaluada
     * @param userAnswer texto introducido por el alumno
     * @param type       tipo de ejercicio
     * @param responseMs tiempo de respuesta en milisegundos (inferencia del rating FSRS)
     * @return resultado con corrección, feedback y aviso de Merriam
     */
    public CheckResult checkAnswer(User user, Word word, String userAnswer,
                                   ExerciseType type, Integer responseMs) {
        if (word == null || userAnswer == null || userAnswer.isBlank()) {
            saveLog(user, word, null, null, type, false, responseMs, ErrorType.VOCABULARY, userAnswer);
            updatePoints(user, false);
            return new CheckResult(false, null, CheckResult.Notice.NONE);
        }

        String answer = userAnswer.trim();
        boolean correct = false;
        CheckResult.Notice notice = CheckResult.Notice.NONE;

        if (word.getWordEng().equalsIgnoreCase(answer)) correct = true;

        if (!correct) {
            List<WordCopy> copies = wordCopyRepository.findByWordSpaIgnoreCase(word.getWordSpa());
            correct = copies.stream().anyMatch(wc -> wc.getWordEng().equalsIgnoreCase(answer));
        }

        if (!correct) {
            MerriamSpanishService.ValidationResult validation =
                    merriamSpanish.validate(word.getWordSpa(), answer);
            if (validation.noData()) {
                notice = CheckResult.Notice.MERRIAM_NO_DATA;
            } else if (validation.isValid()) {
                correct = true;
                notice = CheckResult.Notice.NEW_TRANSLATION_ACCEPTED;
                for (String t : validation.validTranslations()) {
                    if (!wordCopyRepository.existsByWordSpaIgnoreCaseAndWordEngIgnoreCase(
                            word.getWordSpa(), t)) {
                        wordCopyRepository.save(new WordCopy(word.getWordSpa(), t));
                    }
                }
            }
        }

        ErrorType errorType = correct ? null : classifyError(word);
        saveLog(user, word, null, null, type, correct, responseMs, errorType, answer);
        updatePoints(user, correct);
        fsrsService.apply(user, word, correct, responseMs);

        return new CheckResult(correct, generateFeedback(word, answer, correct), notice);
    }

    // ----------------------------------------------------------------
    // RESULTADO DE COMPROBACIÓN
    // ----------------------------------------------------------------

    /**
     * Resultado de la validación de una respuesta.
     *
     * @param correct  si la respuesta es correcta
     * @param feedback mensaje de feedback con noticing (null si correcto)
     * @param notice   aviso adicional de Merriam
     */
    public record CheckResult(boolean correct, String feedback, Notice notice) {
        /** Avisos adicionales generados durante la validación con Merriam. */
        public enum Notice {
            NONE,
            NEW_TRANSLATION_ACCEPTED,
            MERRIAM_NO_DATA
        }
    }

    // ----------------------------------------------------------------
    // PUNTOS — 5 normal, 10 racha de 5, 25 racha de 10
    // ----------------------------------------------------------------

    /**
     * Actualiza los puntos del usuario según la respuesta y la racha activa.
     * Limitación conocida: las rachas se pierden al reiniciar el servidor.
     *
     * @param user    usuario a actualizar
     * @param correct si la respuesta fue correcta
     */
    private void updatePoints(User user, boolean correct) {
        if (user == null) return;
        int userId = user.getId();
        int streak = streaks.getOrDefault(userId, 0);
        if (correct) {
            streak++;
            streaks.put(userId, streak);
            int pts = streak >= 10 ? 25 : streak >= 5 ? 10 : 5;
            userRepository.updatePoints(userId, user.getPoints() + pts);
            user.setPoints(user.getPoints() + pts);
        } else {
            streaks.put(userId, 0);
        }
    }

    // ----------------------------------------------------------------
    // FEEDBACK con noticing (Schmidt, 1990)
    //
    // El feedback dirige la atención del alumno al rasgo lingüístico
    // concreto donde se produce el error. Los tipos siguen la taxonomía
    // de interlengua de Selinker (1972) y Corder (1967):
    //   FALSE_FRIEND      -> interferencia L1/L2 por similitud formal
    //   OVERGENERALIZATION -> regla regular aplicada a forma irregular
    //   CONTEXT           -> error pragmático o colocacional
    //   VOCABULARY        -> error léxico sin categoría específica
    //   GRAMMAR           -> error morfosintáctico
    // ----------------------------------------------------------------

    /**
     * Genera el mensaje de feedback diferenciado según el tipo de error.
     * Implementa el noticing de Schmidt (1990) con taxonomía de Selinker (1972).
     *
     * @param word       palabra evaluada
     * @param userAnswer respuesta introducida por el alumno
     * @param correct    si la respuesta fue correcta
     * @return mensaje de feedback, o null si la respuesta es correcta
     */
    public String generateFeedback(Word word, String userAnswer, boolean correct) {
        if (correct) return null;
        return switch (classifyError(word)) {
            case FALSE_FRIEND ->
                word.getFeedbackHint() != null
                    ? word.getFeedbackHint()
                    : "\"" + word.getWordSpa() + "\" es un falso amigo. No significa lo que parece en inglés.";
            case OVERGENERALIZATION ->
                "\"" + word.getWordEng() + "\" es irregular. No sigas la regla general, memorízalo directamente.";
            case CONTEXT ->
                "\"" + word.getWordEng() + "\" varía según el contexto. No tiene una traducción fija.";
            case VOCABULARY ->
                "Escribiste \"" + userAnswer + "\" — la respuesta correcta es \"" + word.getWordEng() + "\".";
            case GRAMMAR ->
                "Revisa la forma gramatical. La respuesta correcta es \"" + word.getWordEng() + "\".";
        };
    }

    // ----------------------------------------------------------------
    // CLASIFICACIÓN DE ERRORES (Selinker, 1972)
    // ----------------------------------------------------------------

    /**
     * Clasifica el tipo de error producido al fallar una palabra.
     * Taxonomía de Selinker (1972) y Corder (1967).
     * El resultado se persiste en SessionLog y es consultable mediante
     * ProgressService.getErrorSummary().
     *
     * @param word palabra en la que se ha producido el error
     * @return tipo de error según la taxonomía de interlengua
     */
    private ErrorType classifyError(Word word) {
        if (word.isFalseFriend())  return ErrorType.FALSE_FRIEND;
        if (word.isIrregular() && word.getType() == WordType.Verb) return ErrorType.OVERGENERALIZATION;
        if (word.getType() == WordType.Preposition || word.getType() == WordType.Adverb) return ErrorType.CONTEXT;
        return ErrorType.VOCABULARY;
    }

    // ----------------------------------------------------------------
    // FSRS — delegado a FsrsService
    // ----------------------------------------------------------------

    /**
     * Punto de entrada público para FSRS desde ExerciseController
     * en ejercicios FILL_GAP con validación propia.
     *
     * @param user       usuario
     * @param word       palabra evaluada
     * @param correct    si la respuesta fue correcta
     * @param responseMs tiempo de respuesta en milisegundos
     */
    public void applyFsrsPublic(User user, Word word, boolean correct, Integer responseMs) {
        fsrsService.apply(user, word, correct, responseMs);
    }

    // ----------------------------------------------------------------
    // TIPO DE EJERCICIO según estado FSRS (Swain, 1985)
    // NEW/RELEARNING -> MULTIPLE_CHOICE (reconocimiento — i+1 Krashen)
    // LEARNING       -> TRANSLATE       (producción activa — Swain)
    // REVIEW         -> FILL_GAP        (uso contextualizado)
    // ----------------------------------------------------------------

    /**
     * Determina el tipo de ejercicio según el estado FSRS de la tarjeta.
     * Progresión pedagógica basada en Swain (1985).
     *
     * @param uw estado FSRS de la tarjeta, o null si es nueva
     * @return tipo de ejercicio correspondiente al estado
     */
    public ExerciseType resolveExerciseType(UserWord uw) {
        if (uw == null) return ExerciseType.MULTIPLE_CHOICE;
        return switch (uw.getState()) {
            case NEW        -> ExerciseType.MULTIPLE_CHOICE;
            case LEARNING   -> ExerciseType.TRANSLATE;
            case REVIEW     -> ExerciseType.FILL_GAP;
            case RELEARNING -> ExerciseType.MULTIPLE_CHOICE;
        };
    }

    /**
     * Busca el estado FSRS del usuario para una palabra y resuelve el tipo de ejercicio.
     * Delega en FsrsService.
     *
     * @param userId identificador del usuario
     * @param wordId identificador de la palabra
     * @return tipo de ejercicio apropiado
     */
    public ExerciseType resolveExerciseTypeForUser(int userId, int wordId) {
        return fsrsService.resolveTypeForWord(userId, wordId);
    }

    // ----------------------------------------------------------------
    // LOG
    // ----------------------------------------------------------------

    /**
     * Persiste un registro de sesión — base de datos de interlengua del alumno.
     *
     * @param user       usuario
     * @param word       palabra evaluada (puede ser null)
     * @param fillGap    ejercicio fill-gap (puede ser null)
     * @param reading    texto de lectura (puede ser null)
     * @param type       tipo de ejercicio
     * @param correct    si la respuesta fue correcta
     * @param responseMs tiempo de respuesta en ms
     * @param errorType  tipo de error según Selinker (null si correcto)
     * @param userAnswer texto introducido por el alumno
     */
    private void saveLog(User user, Word word, FillGapExercise fillGap,
                         ReadingText reading, ExerciseType type,
                         boolean correct, Integer responseMs,
                         ErrorType errorType, String userAnswer) {
        SessionLog log = new SessionLog();
        log.setUser(user); log.setWord(word); log.setFillGap(fillGap);
        log.setReading(reading); log.setExerciseType(type);
        log.setCorrect(correct); log.setResponseMs(responseMs);
        log.setErrorType(errorType); log.setUserAnswer(userAnswer);
        sessionLogRepository.save(log);
    }
}
