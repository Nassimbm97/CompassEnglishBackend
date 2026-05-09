package org.example.compassenglish.controller;

import org.example.compassenglish.model.UserProgress;
import org.example.compassenglish.model.enums.CardState;
import org.example.compassenglish.repository.UserProgressRepository;
import org.example.compassenglish.repository.UserWordRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/home-stats")
public class HomeStatsController {

    private final UserWordRepository     userWordRepository;
    private final UserProgressRepository userProgressRepository;

    public HomeStatsController(UserWordRepository userWordRepository,
                               UserProgressRepository userProgressRepository) {
        this.userWordRepository     = userWordRepository;
        this.userProgressRepository = userProgressRepository;
    }

    // GET /api/home-stats/{userId}
    // Una sola llamada con todo lo que necesita el HomeScreen:
    //   - palabras pendientes de repaso hoy (FSRS dueDate <= now)
    //   - contadores por estado (NEW, LEARNING, REVIEW, RELEARNING)
    //   - mejor y peor tema según accuracyPct
    //   - stability media de las tarjetas en REVIEW (salud de memoria)
    @Transactional(readOnly = true)
    @GetMapping("/{userId}")
    public ResponseEntity<?> getHomeStats(@PathVariable int userId) {

        LocalDateTime now = LocalDateTime.now();

        // Pendientes hoy
        int dueTodayCount = userWordRepository.findDueByUser(userId, now).size();

        // Contadores por estado
        long countNew        = userWordRepository.countByUserIdAndState(userId, CardState.NEW);
        long countLearning   = userWordRepository.countByUserIdAndState(userId, CardState.LEARNING);
        long countReview     = userWordRepository.countByUserIdAndState(userId, CardState.REVIEW);
        long countRelearning = userWordRepository.countByUserIdAndState(userId, CardState.RELEARNING);

        // Stability media de tarjetas consolidadas (REVIEW) — indica salud de memoria
        OptionalDouble avgStability = userWordRepository
                .findDueByUser(userId, now.plusYears(99)) // todas las tarjetas
                .stream()
                .filter(uw -> uw.getState() == CardState.REVIEW)
                .mapToDouble(uw -> uw.getStability())
                .average();

        // Mejor y peor tema
        List<UserProgress> progressList = userProgressRepository.findByUserId(userId);

        String bestTheme    = "";
        String worstTheme   = "";
        int    bestAccuracy  = 0;
        int    worstAccuracy = 100;

        for (UserProgress p : progressList) {
            if (p.getTotalAttempts() < 5) continue; // ignorar temas con pocos datos
            int acc = (int) Math.round(p.getAccuracyRate() * 100);
            String themeName = p.getTheme().getName().name();
            if (acc > bestAccuracy)  { bestAccuracy  = acc; bestTheme  = themeName; }
            if (acc < worstAccuracy) { worstAccuracy = acc; worstTheme = themeName; }
        }

        Map<String, Object> stats = new LinkedHashMap<>();
        stats.put("dueToday",      dueTodayCount);
        stats.put("countNew",      countNew);
        stats.put("countLearning", countLearning);
        stats.put("countReview",   countReview);
        stats.put("countRelearning", countRelearning);
        stats.put("avgStabilityDays", avgStability.isPresent()
                ? Math.round(avgStability.getAsDouble()) : 0);
        stats.put("bestTheme",     bestTheme);
        stats.put("bestAccuracy",  bestTheme.isEmpty()  ? 0 : bestAccuracy);
        stats.put("worstTheme",    worstTheme);
        stats.put("worstAccuracy", worstTheme.isEmpty() ? 0 : worstAccuracy);

        return ResponseEntity.ok(stats);
    }

    // GET /api/home-stats/{userId}/words?state=REVIEW
    // Devuelve las palabras de un estado FSRS concreto
    @Transactional(readOnly = true)
    @GetMapping("/{userId}/words")
    public ResponseEntity<?> getWordsByState(
            @PathVariable int userId,
            @RequestParam(defaultValue = "REVIEW") String state) {

        final CardState cardState;
        CardState parsed;
        try { parsed = CardState.valueOf(state); }
        catch (IllegalArgumentException e) { parsed = CardState.REVIEW; }
        cardState = parsed;

        List<Map<String, Object>> words = userWordRepository
                .findAll().stream()
                .filter(uw -> uw.getUser().getId() == userId && uw.getState() == cardState)
                .map(uw -> {
                    Map<String, Object> m = new LinkedHashMap<>();
                    m.put("wordEng",    uw.getWord().getWordEng());
                    m.put("wordSpa",    uw.getWord().getWordSpa());
                    m.put("stability",  Math.round(uw.getStability()));
                    m.put("difficulty", Math.round(uw.getDifficulty() * 10.0) / 10.0);
                    m.put("reps",       uw.getReps());
                    m.put("lapses",     uw.getLapses());
                    m.put("dueDate",    uw.getDueDate() != null ? uw.getDueDate().toLocalDate().toString() : "");
                    return m;
                })
                .collect(Collectors.toList());

        return ResponseEntity.ok(words);
    }
}