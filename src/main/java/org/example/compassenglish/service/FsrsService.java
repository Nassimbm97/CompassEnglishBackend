package org.example.compassenglish.service;

import org.example.compassenglish.model.*;
import org.example.compassenglish.model.enums.*;
import org.example.compassenglish.repository.*;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Optional;

/**
 * Servicio que encapsula el algoritmo FSRS-4.5 (Free Spaced Repetition Scheduler).
 *
 * Separa la lógica de repaso espaciado de ExerciseService para que pueda
 * aplicarse tanto a palabras de la BD (UserWord) como a apuntes personales
 * del usuario (UserCustomWord).
 *
 * Referencia del algoritmo: github.com/open-spaced-repetition/fsrs4anki
 * Parámetros w0-w16 entrenados por Jarrett Ye sobre 500M repasos reales de Anki.
 *
 * @author Nassim Bouderbane Marrero
 */
@Service
public class FsrsService {

    private final UserWordRepository       userWordRepository;
    private final UserCustomWordRepository userCustomWordRepository;

    // Tiempo de respuesta en ms que distingue Easy / Good / Hard
    private static final int MS_EASY = 3000;
    private static final int MS_GOOD = 8000;

    // Parámetros FSRS-4.5 por defecto (Jarrett Ye, 2024)
    private static final double[] W = {
        0.4072, 1.1829, 3.1262, 15.4722,
        7.2102, 0.5316, 1.0651, 0.0589,
        1.5330, 0.1544, 1.0070, 1.9395,
        0.1100, 0.2900, 2.2700, 0.2500,
        2.9898
    };

    private static final double DECAY    = -0.5;
    private static final double FACTOR   = Math.pow(0.9, 1.0 / DECAY) - 1; // ≈ 0.2317
    private static final double R_TARGET = 0.9;

    public FsrsService(UserWordRepository userWordRepository,
                       UserCustomWordRepository userCustomWordRepository) {
        this.userWordRepository       = userWordRepository;
        this.userCustomWordRepository = userCustomWordRepository;
    }

    // ----------------------------------------------------------------
    // API PÚBLICA — palabras de BD
    // ----------------------------------------------------------------

    /**
     * Aplica FSRS a una palabra de la BD (UserWord).
     * Si no existe registro para ese par (usuario, palabra) lo crea como NEW.
     *
     * @param user       usuario que respondió
     * @param word       palabra sobre la que se ejercitó
     * @param correct    si la respuesta fue correcta
     * @param responseMs tiempo de respuesta en milisegundos
     */
    public void apply(User user, Word word, boolean correct, Integer responseMs) {
        LocalDateTime now = LocalDateTime.now();
        UserWord uw = userWordRepository
                .findByUserIdAndWordId(user.getId(), word.getId())
                .orElse(new UserWord(user, word));
        applyFsrsLogic(uw, correct, responseMs, now);
        userWordRepository.save(uw);
    }

    /**
     * Aplica FSRS a un apunte personal del usuario (UserCustomWord).
     * Si no existe registro para ese par (usuario, apunte) lo crea como NEW.
     *
     * @param user       usuario que respondió
     * @param card       apunte personal sobre el que se ejercitó
     * @param correct    si la respuesta fue correcta
     * @param responseMs tiempo de respuesta en milisegundos
     */
    public void applyToCustomCard(User user, CustomCard card, boolean correct, Integer responseMs) {
        LocalDateTime now = LocalDateTime.now();
        UserCustomWord ucw = userCustomWordRepository
                .findByUserIdAndCustomCardId(user.getId(), card.getId())
                .orElse(new UserCustomWord(user, card));
        applyFsrsLogic(ucw, correct, responseMs, now);
        userCustomWordRepository.save(ucw);
    }

    /**
     * Devuelve el tipo de ejercicio óptimo para una palabra de BD
     * según su estado FSRS actual para ese usuario.
     *
     * @param userId identificador del usuario
     * @param wordId identificador de la palabra
     * @return tipo de ejercicio recomendado por FSRS
     */
    public ExerciseType resolveTypeForWord(int userId, int wordId) {
        Optional<UserWord> uw = userWordRepository.findByUserIdAndWordId(userId, wordId);
        return resolveType(uw.map(UserWord::getState).orElse(CardState.NEW));
    }

    /**
     * Devuelve el tipo de ejercicio óptimo para un apunte personal
     * según su estado FSRS actual para ese usuario.
     *
     * @param userId identificador del usuario
     * @param cardId identificador del apunte personal
     * @return tipo de ejercicio recomendado por FSRS
     */
    public ExerciseType resolveTypeForCustomCard(int userId, int cardId) {
        Optional<UserCustomWord> ucw = userCustomWordRepository.findByUserIdAndCustomCardId(userId, cardId);
        return resolveType(ucw.map(UserCustomWord::getState).orElse(CardState.NEW));
    }

    // ----------------------------------------------------------------
    // LÓGICA FSRS — compartida por Word y CustomCard mediante FsrsTarget
    // ----------------------------------------------------------------

    /**
     * Aplica las fórmulas FSRS-4.5 a cualquier objeto que implemente FsrsTarget.
     * La misma lógica sirve para UserWord y UserCustomWord.
     *
     * @param target     objeto que almacena el estado FSRS (UserWord o UserCustomWord)
     * @param correct    si la respuesta fue correcta
     * @param responseMs tiempo de respuesta en ms
     * @param now        momento actual
     */
    private void applyFsrsLogic(FsrsTarget target, boolean correct, Integer responseMs, LocalDateTime now) {
        int rating = toRating(correct, responseMs);

        switch (target.getState()) {
            case NEW -> {
                double s = initStability(rating);
                double d = initDifficulty(rating);
                target.setStability(s);
                target.setDifficulty(d);
                if (rating == 1) {
                    target.setState(CardState.RELEARNING);
                    target.setLapses(target.getLapses() + 1);
                    target.setDueDate(now.plusMinutes(10));
                } else {
                    target.setState(CardState.LEARNING);
                    target.setReps(target.getReps() + 1);
                    target.setDueDate(now.plusDays(Math.max(1L, Math.round(s))));
                }
            }
            case LEARNING -> {
                double s = target.getStability();
                double d = target.getDifficulty();
                long daysSince = target.getLastReview() != null
                        ? ChronoUnit.DAYS.between(target.getLastReview().toLocalDate(), now.toLocalDate()) : 1;
                double r    = retrievability(s, daysSince);
                double newD = nextDifficulty(d, rating);
                target.setDifficulty(newD);
                if (rating == 1) {
                    target.setState(CardState.RELEARNING);
                    target.setLapses(target.getLapses() + 1);
                    target.setStability(Math.max(0.1, nextStabilityForgot(newD, s, r)));
                    target.setDueDate(now.plusMinutes(10));
                } else {
                    double newS = nextStabilityRecall(newD, s, r, rating);
                    target.setStability(Math.max(0.1, newS));
                    target.setState(CardState.REVIEW);
                    target.setReps(target.getReps() + 1);
                    target.setDueDate(now.plusDays(nextInterval(newS)));
                }
            }
            case REVIEW -> {
                double s = target.getStability();
                double d = target.getDifficulty();
                long daysSince = target.getLastReview() != null
                        ? ChronoUnit.DAYS.between(target.getLastReview().toLocalDate(), now.toLocalDate())
                        : Math.round(s);
                double r    = retrievability(s, daysSince);
                double newD = nextDifficulty(d, rating);
                target.setDifficulty(newD);
                if (rating == 1) {
                    target.setState(CardState.RELEARNING);
                    target.setLapses(target.getLapses() + 1);
                    target.setStability(Math.max(0.1, nextStabilityForgot(newD, s, r)));
                    target.setDueDate(now.plusMinutes(10));
                } else {
                    double newS = nextStabilityRecall(newD, s, r, rating);
                    target.setStability(Math.max(0.1, newS));
                    target.setReps(target.getReps() + 1);
                    target.setDueDate(now.plusDays(nextInterval(newS)));
                }
            }
            case RELEARNING -> {
                double newD = nextDifficulty(target.getDifficulty(), rating);
                target.setDifficulty(newD);
                if (rating == 1) {
                    target.setLapses(target.getLapses() + 1);
                    target.setDueDate(now.plusMinutes(10));
                } else {
                    double newS = initStability(rating) * Math.exp(W[11] * (target.getLapses() + 1));
                    target.setStability(Math.max(0.1, newS));
                    target.setState(CardState.REVIEW);
                    target.setReps(target.getReps() + 1);
                    target.setDueDate(now.plusDays(nextInterval(newS)));
                }
            }
        }
        target.setLastReview(now);
    }

    // ----------------------------------------------------------------
    // FÓRMULAS FSRS-4.5
    // ----------------------------------------------------------------

    private int toRating(boolean correct, Integer responseMs) {
        if (!correct) return 1;
        if (responseMs == null) return 3;
        if (responseMs < MS_EASY) return 4;
        if (responseMs < MS_GOOD) return 3;
        return 2;
    }

    private double initStability(int rating)  { return W[rating - 1]; }
    private double initDifficulty(int rating) { return W[4] - Math.exp(W[5] * (rating - 1)) + 1; }

    private double retrievability(double s, long t) {
        return s <= 0 ? 0 : Math.pow(1.0 + FACTOR * t / s, DECAY);
    }

    private double nextStabilityRecall(double d, double s, double r, int rating) {
        double hardPenalty = (rating == 2) ? W[15] : 1.0;
        double easyBonus   = (rating == 4) ? W[16] : 1.0;
        return s * (Math.exp(W[8]) * (11 - d) * Math.pow(s, -W[9])
                * (Math.exp(W[10] * (1 - r)) - 1) * hardPenalty * easyBonus + 1);
    }

    private double nextStabilityForgot(double d, double s, double r) {
        return W[11] * Math.pow(d, -W[12]) * (Math.pow(s + 1, W[13]) - 1) * Math.exp(W[14] * (1 - r));
    }

    private double nextDifficulty(double d, int rating) {
        double newD = d - W[6] * (rating - 3) + W[7] * (W[4] - d);
        return Math.max(1.0, Math.min(10.0, newD));
    }

    private long nextInterval(double s) {
        return Math.max(1L, Math.round(s / FACTOR * (Math.pow(R_TARGET, 1.0 / DECAY) - 1)));
    }

    private ExerciseType resolveType(CardState state) {
        return switch (state) {
            case NEW        -> ExerciseType.MULTIPLE_CHOICE;
            case LEARNING   -> ExerciseType.TRANSLATE;
            case REVIEW     -> ExerciseType.FILL_GAP;
            case RELEARNING -> ExerciseType.MULTIPLE_CHOICE;
        };
    }
}
