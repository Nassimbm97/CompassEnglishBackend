package org.example.compassenglish.controller;

import org.example.compassenglish.model.*;
import org.example.compassenglish.model.enums.*;
import org.example.compassenglish.repository.*;
import org.example.compassenglish.service.ExerciseService;
import org.example.compassenglish.service.FsrsService;
import org.example.compassenglish.service.ProgressService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;
import java.util.Arrays;
import java.util.stream.Collectors;

/**
 * Controlador REST para el flujo de ejercicios de Compass English.
 *
 * <p>Expone los endpoints para obtener sesiones, validar respuestas
 * y finalizar sesiones guardando el progreso.</p>
 *
 * @author Nassim Bouderbane Marrero
 */
@RestController
@RequestMapping("/api/exercises")
public class ExerciseController {

    private final ExerciseService           exerciseService;
    private final ProgressService           progressService;
    private final FsrsService               fsrsService;
    private final UserRepository            userRepository;
    private final WordRepository            wordRepository;
    private final FillGapExerciseRepository fillGapRepository;
    private final CustomCardRepository      customCardRepository;

    public ExerciseController(ExerciseService exerciseService,
                              ProgressService progressService,
                              FsrsService fsrsService,
                              UserRepository userRepository,
                              WordRepository wordRepository,
                              FillGapExerciseRepository fillGapRepository,
                              CustomCardRepository customCardRepository) {
        this.exerciseService      = exerciseService;
        this.progressService      = progressService;
        this.fsrsService          = fsrsService;
        this.userRepository       = userRepository;
        this.wordRepository       = wordRepository;
        this.fillGapRepository    = fillGapRepository;
        this.customCardRepository = customCardRepository;
    }

    /**
     * Devuelve la sesión de ejercicios para un usuario.
     * Soporta filtrado por tema, tipo, nivel y fuente (BD / CUSTOM / ALL).
     *
     * @param userId id del usuario
     * @param theme  nombre del tema (opcional)
     * @param type   tipo de ejercicio forzado (opcional)
     * @param source fuente de palabras: BD, CUSTOM o ALL (por defecto BD)
     * @param level  nivel CEFR o ALL (opcional)
     * @return lista de DTOs de ejercicio
     */
    @GetMapping("/session/{userId}")
    public ResponseEntity<?> getSession(
            @PathVariable int userId,
            @RequestParam(required = false) String theme,
            @RequestParam(required = false) String type,
            @RequestParam(required = false, defaultValue = "BD") String source,
            @RequestParam(required = false) String level) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));

        List<Map<String, Object>> result = new ArrayList<>();

        if (source.equals("BD") || source.equals("ALL")) {
            List<Word> words = getFilteredWords(user, theme, level);
            if ("FILL_GAP".equals(type)) {
                words = filterWordsWithFillGap(words);
                if (words.isEmpty()) words = filterWordsWithFillGap(new ArrayList<>(wordRepository.findAll()));
            }
            for (Word w : words) {
                ExerciseType exType = resolveType(type, user, w);
                result.add(buildWordDto(w, exType, user));
            }
        }

        if (source.equals("CUSTOM") || source.equals("ALL")) {
            List<CustomCard> cards = getFilteredCustomCards(userId, theme, level);
            for (CustomCard c : cards) {
                ExerciseType exType = (type != null && !type.equals("FILL_GAP"))
                        ? ExerciseType.valueOf(type)
                        : (new Random().nextBoolean()
                            ? ExerciseType.TRANSLATE
                            : ExerciseType.MULTIPLE_CHOICE);
                result.add(buildCustomCardDto(c, exType, user));
            }
        }

        Collections.shuffle(result);
        if (result.size() > 20) result = result.subList(0, 20);

        return ResponseEntity.ok(result);
    }

    /**
     * Valida la respuesta del alumno y aplica FSRS.
     * Soporta palabras de BD, palabras de tipo fill-gap y apuntes personales (isCustom).
     *
     * @param body mapa con userId, wordId, answer, exerciseType, responseMs e isCustom
     * @return resultado con corrección, feedback, puntos y aviso de Merriam
     */
    @PostMapping("/answer")
    public ResponseEntity<?> submitAnswer(@RequestBody Map<String, Object> body) {
        int userId       = (int) body.get("userId");
        int wordId       = (int) body.get("wordId");
        String answer    = (String) body.get("answer");
        String typeStr   = (String) body.get("exerciseType");
        Integer respMs   = body.containsKey("responseMs") ? (Integer) body.get("responseMs") : null;
        boolean isCustom = body.containsKey("isCustom") && (boolean) body.get("isCustom");

        User user = userRepository.findById(userId).orElseThrow();
        ExerciseType type = ExerciseType.valueOf(typeStr);

        Map<String, Object> response = new HashMap<>();

        if (isCustom) {
            // Apunte personal — FSRS aplicado a UserCustomWord via FsrsService
            CustomCard card = customCardRepository.findById(wordId).orElseThrow();
            boolean correct = card.getWordEng().equalsIgnoreCase(answer.trim());
            fsrsService.applyToCustomCard(user, card, correct, respMs);
            userRepository.updatePoints(userId, user.getPoints() + (correct ? 5 : 0));

            response.put("correct",       correct);
            response.put("feedback",      correct ? null : "La respuesta es \"" + card.getWordEng() + "\".");
            response.put("correctAnswer", card.getWordEng());
            response.put("notes",         card.getNotes() != null ? card.getNotes() : "");
            response.put("points",        user.getPoints() + (correct ? 5 : 0));
            response.put("notice",        "NONE");

        } else if (type == ExerciseType.FILL_GAP && body.containsKey("fillGapId")) {
            // Fill-the-gap con frase específica — validación propia
            int fillGapId = (int) body.get("fillGapId");
            FillGapExercise gap = fillGapRepository.findById(fillGapId).orElse(null);
            Word word = wordRepository.findById(wordId).orElseThrow();

            boolean correct = false;
            String correctAnswer = word.getWordEng();

            if (gap != null) {
                correctAnswer = gap.getAnswer();
                String trimmed = answer.trim();
                correct = gap.getAnswer().equalsIgnoreCase(trimmed);
                if (!correct && gap.getAlternativeAnswers() != null) {
                    correct = Arrays.stream(gap.getAlternativeAnswers().split("[|]"))
                            .map(String::trim)
                            .anyMatch(alt -> alt.equalsIgnoreCase(trimmed));
                }
            } else {
                correct = word.getWordEng().equalsIgnoreCase(answer.trim());
            }

            exerciseService.applyFsrsPublic(user, word, correct, respMs);
            if (correct) userRepository.updatePoints(userId, user.getPoints() + 10);

            User updated = userRepository.findById(userId).orElse(user);
            response.put("correct",       correct);
            response.put("feedback",      correct ? null : "La respuesta era \"" + correctAnswer + "\".");
            response.put("correctAnswer", correctAnswer);
            response.put("points",        updated.getPoints());
            response.put("notice",        "NONE");

        } else {
            // Palabra estándar — flujo completo con Merriam y noticing
            Word word = wordRepository.findById(wordId).orElseThrow();
            ExerciseService.CheckResult result =
                    exerciseService.checkAnswer(user, word, answer, type, respMs);
            User updated = userRepository.findById(userId).orElse(user);

            response.put("correct",       result.correct());
            response.put("feedback",      result.feedback() != null ? result.feedback() : "");
            response.put("correctAnswer", word.getWordEng());
            response.put("points",        updated.getPoints());
            response.put("notice",        result.notice().name());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Finaliza la sesión y actualiza el progreso del alumno por tema.
     *
     * @param userId id del usuario
     * @return confirmación
     */
    @PostMapping("/session/finish/{userId}")
    public ResponseEntity<?> finishSession(@PathVariable int userId) {
        progressService.updateProgress(userId, LocalDate.now());
        return ResponseEntity.ok(Map.of("message", "Sesion guardada"));
    }

    // ----------------------------------------------------------------
    // HELPERS
    // ----------------------------------------------------------------

    private List<Word> getFilteredWords(User user, String theme, String level) {
        boolean allLevels = "ALL".equals(level);
        Level lvl = (!allLevels && level != null) ? Level.valueOf(level)
                : (user.getLevelEstimated() != null ? user.getLevelEstimated() : Level.BEGINNER);

        org.example.compassenglish.model.enums.ThemeName themeName = null;
        if (theme != null && !theme.isBlank()) {
            try {
                themeName = org.example.compassenglish.model.enums.ThemeName.valueOf(theme);
            } catch (IllegalArgumentException ignored) {
                // tema desconocido -> se ignora el filtro de tema
            }
        }

        List<Word> words;
        if (allLevels) {
            words = themeName != null
                    ? wordRepository.findByThemeName(themeName)
                    : new ArrayList<>(wordRepository.findAll());
        } else if (themeName != null) {
            words = wordRepository.findByThemeAndLevel(themeName, lvl);
            if (words.isEmpty()) words = wordRepository.findByThemeName(themeName);
        } else {
            words = wordRepository.findByLevel(lvl);
        }

        if (words.isEmpty()) words = new ArrayList<>(wordRepository.findAll());
        Collections.shuffle(words);
        return words;
    }

    /** Filtra solo palabras que tienen frases fill-gap disponibles. */
    private List<Word> filterWordsWithFillGap(List<Word> words) {
        Set<Integer> wordIdsWithGap = fillGapRepository.findAll()
                .stream().map(fg -> fg.getWord().getId())
                .collect(Collectors.toSet());
        return words.stream()
                .filter(w -> wordIdsWithGap.contains(w.getId()))
                .collect(Collectors.toList());
    }

    private List<CustomCard> getFilteredCustomCards(int userId, String theme, String level) {
        List<CustomCard> cards = customCardRepository.findByUserId(userId);
        if (theme != null && !theme.isBlank()) {
            cards = cards.stream()
                    .filter(c -> c.getTheme() != null && c.getTheme().getName().name().equals(theme))
                    .collect(Collectors.toList());
        }
        if (level != null && !level.isBlank()) {
            Level lvl = Level.valueOf(level);
            cards = cards.stream().filter(c -> c.getLevel() == lvl).collect(Collectors.toList());
        }
        Collections.shuffle(cards);
        return cards;
    }

    private ExerciseType resolveType(String typeParam, User user, Word word) {
        if (typeParam != null && !typeParam.isBlank()) return ExerciseType.valueOf(typeParam);
        if (user.getLearningMode() == LearningMode.EVALUATION) {
            return exerciseService.resolveExerciseTypeForUser(user.getId(), word.getId());
        }
        return exerciseService.randomExerciseType();
    }

    private Map<String, Object> buildWordDto(Word w, ExerciseType type, User user) {
        Map<String, Object> dto = new HashMap<>();
        dto.put("wordId",   w.getId());
        dto.put("wordSpa",  w.getWordSpa());
        dto.put("wordEng",  w.getWordEng());
        dto.put("level",    w.getLevel() != null ? w.getLevel().name() : "BEGINNER");
        dto.put("type",     type.name());
        dto.put("isCustom", false);

        Level lvl = user.getLevelEstimated() != null ? user.getLevelEstimated() : Level.BEGINNER;

        if (type == ExerciseType.MULTIPLE_CHOICE) {
            dto.put("options", exerciseService.generateOptions(w, lvl));
        } else if (type == ExerciseType.FILL_GAP) {
            List<FillGapExercise> gaps = fillGapRepository.findByWordId(w.getId());
            if (!gaps.isEmpty()) {
                FillGapExercise gap = gaps.get(new Random().nextInt(gaps.size()));
                dto.put("wordSpa",   gap.getPhraseEng());
                dto.put("phraseSpa", gap.getPhraseSpa() != null ? gap.getPhraseSpa() : "");
                dto.put("fillGapId", gap.getId());
                dto.put("options",   exerciseService.generateOptions(w, lvl));
            } else {
                dto.put("type",    ExerciseType.MULTIPLE_CHOICE.name());
                dto.put("options", exerciseService.generateOptions(w, lvl));
            }
        } else {
            dto.put("options", List.of());
        }

        if (w.getFeedbackHint() != null) dto.put("hint", w.getFeedbackHint());
        return dto;
    }

    private Map<String, Object> buildCustomCardDto(CustomCard c, ExerciseType type, User user) {
        Map<String, Object> dto = new HashMap<>();
        dto.put("wordId",   c.getId());
        dto.put("wordSpa",  c.getWordSpa());
        dto.put("wordEng",  c.getWordEng());
        dto.put("level",    c.getLevel() != null ? c.getLevel().name() : "BEGINNER");
        dto.put("type",     type.name());
        dto.put("isCustom", true);
        dto.put("notes",    c.getNotes() != null ? c.getNotes() : "");

        if (type == ExerciseType.MULTIPLE_CHOICE) {
            Level lvl = user.getLevelEstimated() != null ? user.getLevelEstimated() : Level.BEGINNER;
            List<Word> pool = new ArrayList<>(wordRepository.findByLevel(lvl));
            Collections.shuffle(pool);
            List<String> options = new ArrayList<>();
            options.add(c.getWordEng());
            pool.stream().limit(3).forEach(w -> options.add(w.getWordEng()));
            Collections.shuffle(options);
            dto.put("options", options);
        } else {
            dto.put("options", List.of());
        }
        return dto;
    }
}
