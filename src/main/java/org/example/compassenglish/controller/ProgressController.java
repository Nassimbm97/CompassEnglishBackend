package org.example.compassenglish.controller;

import org.example.compassenglish.model.UserProgress;
import org.example.compassenglish.model.enums.ErrorType;
import org.example.compassenglish.service.ProgressService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Controlador REST para el progreso del alumno en Compass English.
 *
 * <p>Expone el perfil de aprendizaje acumulado por tema, los temas débiles
 * y el análisis de errores por tipo de interlengua (Selinker, 1972).</p>
 *
 * @author Nassim Bouderbane Marrero
 */
@RestController
@RequestMapping("/api/progress")
public class ProgressController {

    private final ProgressService progressService;

    public ProgressController(ProgressService progressService) {
        this.progressService = progressService;
    }

    /**
     * Devuelve el perfil acumulativo del alumno por tema.
     * Incluye intentos, aciertos, ratio de producción/reconocimiento y tendencia.
     *
     * @param userId id del usuario
     * @return lista de métricas por tema
     */
    @GetMapping("/{userId}")
    public ResponseEntity<?> getProgress(@PathVariable int userId) {
        List<UserProgress> progress = progressService.getProgressByUser(userId);
        return ResponseEntity.ok(progress.stream().map(p -> Map.of(
                "theme",               p.getTheme().getName(),
                "totalAttempts",       p.getTotalAttempts(),
                "correctAttempts",     p.getCorrectAttempts(),
                "accuracyPct",         Math.round(p.getAccuracyRate() * 100),
                "productionAttempts",  p.getProductionAttempts(),
                "recognitionAttempts", p.getRecognitionAttempts(),
                "productionRatio",     Math.round(p.getProductionRatio() * 100),
                "avgResponseMs",       p.getAvgResponseMs(),
                "trend",               p.getTrend(),
                "lastUpdated",         p.getLastUpdated() != null ? p.getLastUpdated().toString() : ""
        )).toList());
    }

    /**
     * Devuelve los temas débiles del alumno: tendencia DECLINING o tasa de acierto menor del 60%.
     *
     * @param userId id del usuario
     * @return lista de temas con bajo rendimiento
     */
    @GetMapping("/{userId}/weak")
    public ResponseEntity<?> getWeakThemes(@PathVariable int userId) {
        return ResponseEntity.ok(
                progressService.getWeakThemes(userId)
                        .stream()
                        .map(t -> Map.of("themeId", t.getId(), "name", t.getName()))
                        .toList()
        );
    }

    /**
     * Devuelve el recuento de errores por tipo de interlengua (Selinker, 1972).
     *
     * <p>Permite al frontend mostrar el perfil de interlengua del alumno:
     * qué mecanismos de error predominan (falsos amigos, sobregeneralización,
     * errores de contexto o vocabulario general).</p>
     *
     * @param userId id del usuario
     * @return mapa ErrorType -> cantidad de errores
     */
    @GetMapping("/{userId}/errors")
    public ResponseEntity<?> getErrorSummary(@PathVariable int userId) {
        Map<ErrorType, Long> summary = progressService.getErrorSummary(userId);
        return ResponseEntity.ok(summary);
    }
}
