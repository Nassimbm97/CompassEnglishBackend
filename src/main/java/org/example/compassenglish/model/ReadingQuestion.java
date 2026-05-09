package org.example.compassenglish.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ReadingQuestion")
public class ReadingQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ReadingId", nullable = false)
    private ReadingText reading;

    @Column(name = "QuestionText", nullable = false)
    private String questionText;

    @Column(name = "CorrectAnswer", nullable = false)
    private String correctAnswer;

    @Column(name = "OptionB")
    private String optionB;

    @Column(name = "OptionC")
    private String optionC;

    @Column(name = "OptionD")
    private String optionD;

    @Column(name = "QuestionType")
    private String questionType = "MULTIPLE_CHOICE";

    public ReadingQuestion() {}

    public int getId()                              { return id; }
    public ReadingText getReading()                 { return reading; }
    public void setReading(ReadingText r)           { this.reading = r; }
    public String getQuestionText()                 { return questionText; }
    public void setQuestionText(String q)           { this.questionText = q; }
    public String getCorrectAnswer()                { return correctAnswer; }
    public void setCorrectAnswer(String a)          { this.correctAnswer = a; }
    public String getOptionB()                      { return optionB; }
    public void setOptionB(String b)                { this.optionB = b; }
    public String getOptionC()                      { return optionC; }
    public void setOptionC(String c)                { this.optionC = c; }
    public String getOptionD()                      { return optionD; }
    public void setOptionD(String d)                { this.optionD = d; }
    public String getQuestionType()                 { return questionType; }
    public void setQuestionType(String t)           { this.questionType = t; }
}
