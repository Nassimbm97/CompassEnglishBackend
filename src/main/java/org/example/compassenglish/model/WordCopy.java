package org.example.compassenglish.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "WordCopy")
public class WordCopy {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "WordSpa", nullable = false)
    private String wordSpa;

    @Column(name = "WordEng", nullable = false)
    private String wordEng;

    @Column(name = "CreationDate")
    private LocalDateTime creationDate = LocalDateTime.now();

    public WordCopy() {}

    public WordCopy(String wordSpa, String wordEng) {
        this.wordSpa = wordSpa;
        this.wordEng = wordEng;
    }

    public int getId()                          { return id; }
    public String getWordSpa()                  { return wordSpa; }
    public void setWordSpa(String wordSpa)      { this.wordSpa = wordSpa; }
    public String getWordEng()                  { return wordEng; }
    public void setWordEng(String wordEng)      { this.wordEng = wordEng; }
    public LocalDateTime getCreationDate()      { return creationDate; }
}
