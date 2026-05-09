package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.Level;
import java.time.LocalDateTime;

@Entity
@Table(name = "CustomCard")
public class CustomCard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    @Column(name = "WordSpa", nullable = false)
    private String wordSpa;

    @Column(name = "WordEng", nullable = false)
    private String wordEng;

    // Apuntes del usuario — campo nuevo
    @Column(name = "Notes", length = 500)
    private String notes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ThemeId")
    private Theme theme;

    @Enumerated(EnumType.STRING)
    @Column(name = "Level")
    private Level level = Level.BEGINNER;

    @Column(name = "CreatedAt")
    private LocalDateTime createdAt = LocalDateTime.now();

    public CustomCard() {}

    public int getId()                          { return id; }
    public User getUser()                       { return user; }
    public void setUser(User user)              { this.user = user; }
    public String getWordSpa()                  { return wordSpa; }
    public void setWordSpa(String w)            { this.wordSpa = w; }
    public String getWordEng()                  { return wordEng; }
    public void setWordEng(String w)            { this.wordEng = w; }
    public String getNotes()                    { return notes; }
    public void setNotes(String notes)          { this.notes = notes; }
    public Theme getTheme()                     { return theme; }
    public void setTheme(Theme theme)           { this.theme = theme; }
    public Level getLevel()                     { return level; }
    public void setLevel(Level level)           { this.level = level; }
    public LocalDateTime getCreatedAt()         { return createdAt; }
}
