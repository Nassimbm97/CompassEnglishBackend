package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.CardState;

import java.time.LocalDateTime;

// Un registro por cada par (Usuario, Palabra)
// Campos gestionados por la librería fsrs4j
@Entity
@Table(name = "UserWord",
       uniqueConstraints = @UniqueConstraint(columnNames = {"UserId", "WordId"}))
public class UserWord implements FsrsTarget {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WordId", nullable = false)
    private Word word;

    // Campos FSRS
    @Column(name = "Stability")
    private double stability = 0;

    @Column(name = "Difficulty")
    private double difficulty = 0;

    @Column(name = "Lapses")
    private int lapses = 0;

    @Column(name = "Reps")
    private int reps = 0;

    @Column(name = "LastReview")
    private LocalDateTime lastReview;

    @Column(name = "DueDate")
    private LocalDateTime dueDate = LocalDateTime.now();

    @Enumerated(EnumType.STRING)
    @Column(name = "State")
    private CardState state = CardState.NEW;

    public UserWord() {}

    public UserWord(User user, Word word) {
        this.user = user;
        this.word = word;
    }

    public int getId()                          { return id; }
    public User getUser()                       { return user; }
    public void setUser(User user)              { this.user = user; }
    public Word getWord()                       { return word; }
    public void setWord(Word word)              { this.word = word; }
    public double getStability()                { return stability; }
    public void setStability(double s)          { this.stability = s; }
    public double getDifficulty()               { return difficulty; }
    public void setDifficulty(double d)         { this.difficulty = d; }
    public int getLapses()                      { return lapses; }
    public void setLapses(int lapses)           { this.lapses = lapses; }
    public int getReps()                        { return reps; }
    public void setReps(int reps)               { this.reps = reps; }
    public LocalDateTime getLastReview()        { return lastReview; }
    public void setLastReview(LocalDateTime lr)  { this.lastReview = lr; }
    public LocalDateTime getDueDate()           { return dueDate; }
    public void setDueDate(LocalDateTime d)     { this.dueDate = d; }
    public CardState getState()                 { return state; }
    public void setState(CardState state)       { this.state = state; }
}
