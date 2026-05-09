package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.ExerciseCategory;
import org.example.compassenglish.model.enums.Level;

@Entity
@Table(name = "FillGapExercise")
public class FillGapExercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WordId", nullable = false)
    private Word word;


    @Column(name = "PhraseEng", nullable = false, length = 400)
    private String phraseEng;


    @Column(name = "PhraseSpa", length = 400)
    private String phraseSpa;

    @Column(name = "Answer", nullable = false)
    private String answer;

    // Respuestas alternativas válidas separadas por | (ej: "red|orange")
    @Column(name = "AlternativeAnswers", length = 500)
    private String alternativeAnswers;

    @Enumerated(EnumType.STRING)
    @Column(name = "Level")
    private Level level = Level.BEGINNER;

    @Enumerated(EnumType.STRING)
    @Column(name = "Category")
    private ExerciseCategory category = ExerciseCategory.Vocabulary;

    public FillGapExercise() {}

    public int getId()                              { return id; }
    public Word getWord()                           { return word; }
    public void setWord(Word word)                  { this.word = word; }
    public String getPhraseEng()                    { return phraseEng; }
    public void setPhraseEng(String p)              { this.phraseEng = p; }
    public String getPhraseSpa()                    { return phraseSpa; }
    public void setPhraseSpa(String p)              { this.phraseSpa = p; }
    public String getAnswer()                       { return answer; }
    public void setAnswer(String answer)            { this.answer = answer; }
    public String getAlternativeAnswers()           { return alternativeAnswers; }
    public void setAlternativeAnswers(String a)     { this.alternativeAnswers = a; }
    public Level getLevel()                         { return level; }
    public void setLevel(Level level)               { this.level = level; }
    public ExerciseCategory getCategory()           { return category; }
    public void setCategory(ExerciseCategory c)     { this.category = c; }
}
