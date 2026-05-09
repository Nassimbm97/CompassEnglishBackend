package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.Trend;

import java.time.LocalDate;


// Se recalcula al final de cada sesión en ProgressService
@Entity
@Table(name = "UserProgress",
       uniqueConstraints = @UniqueConstraint(columnNames = {"UserId", "ThemeId"}))
public class UserProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ThemeId", nullable = false)
    private Theme theme;

    @Column(name = "TotalAttempts")
    private int totalAttempts = 0;

    @Column(name = "CorrectAttempts")
    private int correctAttempts = 0;

    // Ejercicios de producción (TRANSLATE + FILL_GAP) — Swain Output Hypothesis
    @Column(name = "ProductionAttempts")
    private int productionAttempts = 0;

    // Ejercicios de reconocimiento (MULTIPLE_CHOICE)
    @Column(name = "RecognitionAttempts")
    private int recognitionAttempts = 0;

    @Column(name = "AvgResponseMs")
    private int avgResponseMs = 0;

    // Comparando última sesión con la anterior
    @Enumerated(EnumType.STRING)
    @Column(name = "Trend")
    private Trend trend = Trend.STABLE;

    @Column(name = "LastUpdated")
    private LocalDate lastUpdated;

    public UserProgress() {}

    public UserProgress(User user, Theme theme) {
        this.user  = user;
        this.theme = theme;
    }

    public int getId()                              { return id; }
    public User getUser()                           { return user; }
    public Theme getTheme()                         { return theme; }
    public int getTotalAttempts()                   { return totalAttempts; }
    public void setTotalAttempts(int t)             { this.totalAttempts = t; }
    public int getCorrectAttempts()                 { return correctAttempts; }
    public void setCorrectAttempts(int c)           { this.correctAttempts = c; }
    public int getProductionAttempts()              { return productionAttempts; }
    public void setProductionAttempts(int p)        { this.productionAttempts = p; }
    public int getRecognitionAttempts()             { return recognitionAttempts; }
    public void setRecognitionAttempts(int r)       { this.recognitionAttempts = r; }
    public int getAvgResponseMs()                   { return avgResponseMs; }
    public void setAvgResponseMs(int ms)            { this.avgResponseMs = ms; }
    public Trend getTrend()                         { return trend; }
    public void setTrend(Trend trend)               { this.trend = trend; }
    public LocalDate getLastUpdated()               { return lastUpdated; }
    public void setLastUpdated(LocalDate d)         { this.lastUpdated = d; }

    // Tasa de acierto calculada
    public double getAccuracyRate() {
        if (totalAttempts == 0) return 0;
        return (double) correctAttempts / totalAttempts;
    }

    // Ratio producción/reconocimiento (Swain)
    public double getProductionRatio() {
        int total = productionAttempts + recognitionAttempts;
        if (total == 0) return 0;
        return (double) productionAttempts / total;
    }
}
