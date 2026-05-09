package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.Level;
import org.example.compassenglish.model.enums.WordType;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "Word")
public class Word {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "WordSpa", nullable = false)
    private String wordSpa;

    @Column(name = "WordEng", nullable = false)
    private String wordEng;

    @Enumerated(EnumType.STRING)
    @Column(name = "Type")
    private WordType type;

    @Column(name = "Image")
    private String image;


    @Enumerated(EnumType.STRING)
    @Column(name = "Level")
    private Level level = Level.BEGINNER;


    @Column(name = "IsFalseFriend")
    private Boolean isFalseFriend = false;

    @Column(name = "IsIrregular")
    private Boolean isIrregular = false;


    @Column(name = "FeedbackHint")
    private String feedbackHint;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "WordTheme",
            joinColumns = @JoinColumn(name = "WordId"),
            inverseJoinColumns = @JoinColumn(name = "ThemeId")
    )
    private Set<Theme> themes = new HashSet<>();

    public Word() {}

    // Getters & Setters
    public int getId()                          { return id; }
    public String getWordSpa()                  { return wordSpa; }
    public void setWordSpa(String wordSpa)      { this.wordSpa = wordSpa; }
    public String getWordEng()                  { return wordEng; }
    public void setWordEng(String wordEng)      { this.wordEng = wordEng; }
    public WordType getType()                   { return type; }
    public void setType(WordType type)          { this.type = type; }
    public String getImage()                    { return image; }
    public void setImage(String image)          { this.image = image; }
    public Level getLevel()                     { return level; }
    public void setLevel(Level level)           { this.level = level; }
    public boolean isFalseFriend()              { return isFalseFriend; }
    public void setFalseFriend(boolean f)       { this.isFalseFriend = f; }
    public boolean isIrregular()                { return isIrregular; }
    public void setIrregular(boolean i)         { this.isIrregular = i; }
    public String getFeedbackHint()             { return feedbackHint; }
    public void setFeedbackHint(String hint)    { this.feedbackHint = hint; }
    public Set<Theme> getThemes()               { return themes; }
}
