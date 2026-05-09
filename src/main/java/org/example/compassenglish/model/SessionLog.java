package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.ErrorType;
import org.example.compassenglish.model.enums.ExerciseType;

import java.time.LocalDate;

// Registro de cada respuesta individual
// Base de toda la analítica entre sesiones
@Entity
@Table(name = "SessionLog")
public class SessionLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    // Puede ser Word, FillGap o Reading (no los tres a la vez)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WordId")
    private Word word;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FillGapId")
    private FillGapExercise fillGap;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ReadingId")
    private ReadingText reading;

    @Enumerated(EnumType.STRING)
    @Column(name = "ExerciseType", nullable = false)
    private ExerciseType exerciseType;

    @Column(name = "Correct", nullable = false)
    private boolean correct;

    // Tiempo de respuesta en ms — fluencia real (Accuracy vs Fluency)
    @Column(name = "ResponseMs")
    private Integer responseMs;

    // Clasificación automática del tipo de error (Selinker — interlengua)
    @Enumerated(EnumType.STRING)
    @Column(name = "ErrorType")
    private ErrorType errorType;

    // Lo que escribió el alumno (para noticing en el feedback — Schmidt 1990)
    @Column(name = "UserAnswer")
    private String userAnswer;

    @Column(name = "SessionDate", nullable = false)
    private LocalDate sessionDate = LocalDate.now();

    public SessionLog() {}

    public int getId()                              { return id; }
    public User getUser()                           { return user; }
    public void setUser(User user)                  { this.user = user; }
    public Word getWord()                           { return word; }
    public void setWord(Word word)                  { this.word = word; }
    public FillGapExercise getFillGap()             { return fillGap; }
    public void setFillGap(FillGapExercise f)       { this.fillGap = f; }
    public ReadingText getReading()                 { return reading; }
    public void setReading(ReadingText r)           { this.reading = r; }
    public ExerciseType getExerciseType()           { return exerciseType; }
    public void setExerciseType(ExerciseType t)     { this.exerciseType = t; }
    public boolean isCorrect()                      { return correct; }
    public void setCorrect(boolean correct)         { this.correct = correct; }
    public Integer getResponseMs()                  { return responseMs; }
    public void setResponseMs(Integer ms)           { this.responseMs = ms; }
    public ErrorType getErrorType()                 { return errorType; }
    public void setErrorType(ErrorType e)           { this.errorType = e; }
    public String getUserAnswer()                   { return userAnswer; }
    public void setUserAnswer(String a)             { this.userAnswer = a; }
    public LocalDate getSessionDate()               { return sessionDate; }
}
