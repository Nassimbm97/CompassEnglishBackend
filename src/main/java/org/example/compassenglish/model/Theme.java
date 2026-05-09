package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.ThemeName;

@Entity
@Table(name = "Theme")
public class Theme {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Enumerated(EnumType.STRING)
    @Column(name = "Name", nullable = false, unique = true)
    private ThemeName name;

    public Theme() {}

    public int getId()             { return id; }
    public ThemeName getName()     { return name; }
    public void setName(ThemeName n) { this.name = n; }
}
