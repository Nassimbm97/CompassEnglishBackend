package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.LearningMode;
import org.example.compassenglish.model.enums.Level;
import org.example.compassenglish.model.enums.Role;

import java.time.LocalDateTime;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Username", nullable = false, unique = true)
    private String username;

    @Column(name = "Password", nullable = false)
    private String password;

    @Column(name = "Email", nullable = false, unique = true)
    private String email;

    @Column(name = "AvatarUrl", length = 500)
    private String avatarUrl;

    @Column(name = "Points")
    private int points = 0;

    @Column(name = "Premium")
    private boolean premium = false;

    // NUEVO: FREE = aleatorio (comportamiento original)
    //        EVALUATION = FSRS activo
    @Enumerated(EnumType.STRING)
    @Column(name = "LearningMode")
    private LearningMode learningMode = LearningMode.FREE;

    // NUEVO: nivel estimado recalculado cada sesión
    @Enumerated(EnumType.STRING)
    @Column(name = "LevelEstimated")
    private Level levelEstimated = Level.BEGINNER;

    // NUEVO: rol para vista de profesor/admin
    @Enumerated(EnumType.STRING)
    @Column(name = "Role")
    private Role role = Role.USER;

    @Column(name = "CreatedAt")
    private LocalDateTime createdAt = LocalDateTime.now();

    public User() {}

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email    = email;
    }

    // Getters & Setters
    public int getId()                        { return id; }
    public String getUsername()               { return username; }
    public void setUsername(String username)  { this.username = username; }
    public String getPassword()               { return password; }
    public void setPassword(String password)  { this.password = password; }
    public String getEmail()                  { return email; }
    public void setEmail(String email)        { this.email = email; }
    public String getAvatarUrl()              { return avatarUrl; }
    public void setAvatarUrl(String url)      { this.avatarUrl = url; }
    public int getPoints()                    { return points; }
    public void setPoints(int points)         { this.points = points; }
    public boolean isPremium()                { return premium; }
    public void setPremium(boolean premium)   { this.premium = premium; }
    public LearningMode getLearningMode()     { return learningMode; }
    public void setLearningMode(LearningMode m) { this.learningMode = m; }
    public Level getLevelEstimated()          { return levelEstimated; }
    public void setLevelEstimated(Level l)    { this.levelEstimated = l; }
    public Role getRole()                     { return role; }
    public void setRole(Role role)            { this.role = role; }
    public LocalDateTime getCreatedAt()       { return createdAt; }
}