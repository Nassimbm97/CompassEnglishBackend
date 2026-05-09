package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.CardState;
import java.time.LocalDateTime;

/**
 * Registro FSRS para un apunte personal del usuario.
 * Equivalente a UserWord pero para CustomCard en lugar de Word.
 *
 * Cada par (usuario, apunte) tiene su propio estado FSRS independiente:
 * stability, difficulty, dueDate, state, reps y lapses.
 *
 * @author Nassim Bouderbane Marrero
 */
@Entity
@Table(name = "UserCustomWord",
       uniqueConstraints = @UniqueConstraint(columnNames = {"UserId", "CustomCardId"}))
public class UserCustomWord implements FsrsTarget {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CustomCardId", nullable = false)
    private CustomCard customCard;

    @Column(name = "Stability")
    private double stability = 0.0;

    @Column(name = "Difficulty")
    private double difficulty = 0.0;

    @Column(name = "Reps")
    private int reps = 0;

    @Column(name = "Lapses")
    private int lapses = 0;

    @Enumerated(EnumType.STRING)
    @Column(name = "State")
    private CardState state = CardState.NEW;

    @Column(name = "LastReview")
    private LocalDateTime lastReview;

    @Column(name = "DueDate")
    private LocalDateTime dueDate = LocalDateTime.now();

    public UserCustomWord() {}

    public UserCustomWord(User user, CustomCard customCard) {
        this.user       = user;
        this.customCard = customCard;
    }

    public int            getId()                         { return id; }
    public User           getUser()                       { return user; }
    public CustomCard     getCustomCard()                 { return customCard; }

    @Override public CardState     getState()             { return state; }
    @Override public void         setState(CardState s)   { this.state = s; }
    @Override public double       getStability()          { return stability; }
    @Override public void         setStability(double s)  { this.stability = s; }
    @Override public double       getDifficulty()         { return difficulty; }
    @Override public void         setDifficulty(double d) { this.difficulty = d; }
    @Override public int          getReps()               { return reps; }
    @Override public void         setReps(int r)          { this.reps = r; }
    @Override public int          getLapses()             { return lapses; }
    @Override public void         setLapses(int l)        { this.lapses = l; }
    @Override public LocalDateTime getLastReview()        { return lastReview; }
    @Override public void         setLastReview(LocalDateTime lr) { this.lastReview = lr; }
    @Override public LocalDateTime getDueDate()           { return dueDate; }
    @Override public void         setDueDate(LocalDateTime d)     { this.dueDate = d; }
}
