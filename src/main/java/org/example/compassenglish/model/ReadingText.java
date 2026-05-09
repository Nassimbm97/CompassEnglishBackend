package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.Level;

import java.util.List;

@Entity
@Table(name = "ReadingText")
public class ReadingText {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Title", nullable = false)
    private String title;

    @Column(name = "Content", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Enumerated(EnumType.STRING)
    @Column(name = "Level")
    private Level level = Level.BEGINNER;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ThemeId")
    private Theme theme;

    @OneToMany(mappedBy = "reading", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ReadingQuestion> questions;

    public ReadingText() {}

    public int getId()                          { return id; }
    public String getTitle()                    { return title; }
    public void setTitle(String title)          { this.title = title; }
    public String getContent()                  { return content; }
    public void setContent(String content)      { this.content = content; }
    public Level getLevel()                     { return level; }
    public void setLevel(Level level)           { this.level = level; }
    public Theme getTheme()                     { return theme; }
    public void setTheme(Theme theme)           { this.theme = theme; }
    public List<ReadingQuestion> getQuestions() { return questions; }
}
