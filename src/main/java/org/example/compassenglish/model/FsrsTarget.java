package org.example.compassenglish.model;

import org.example.compassenglish.model.enums.CardState;
import java.time.LocalDateTime;

/**
 * Interfaz que abstrae el estado FSRS de una tarjeta.
 * La implementan UserWord (palabras de BD) y UserCustomWord (apuntes personales).
 * Permite que FsrsService aplique el mismo algoritmo a ambos tipos sin duplicar código.
 *
 * @author Nassim Bouderbane Marrero
 */
public interface FsrsTarget {
    CardState     getState();
    void          setState(CardState state);
    double        getStability();
    void          setStability(double s);
    double        getDifficulty();
    void          setDifficulty(double d);
    int           getReps();
    void          setReps(int reps);
    int           getLapses();
    void          setLapses(int lapses);
    LocalDateTime getLastReview();
    void          setLastReview(LocalDateTime lr);
    LocalDateTime getDueDate();
    void          setDueDate(LocalDateTime due);
}
