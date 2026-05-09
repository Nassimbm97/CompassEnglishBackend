package org.example.compassenglish.repository;

import org.example.compassenglish.model.Theme;
import org.example.compassenglish.model.enums.ThemeName;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface ThemeRepository extends JpaRepository<Theme, Integer> {
    Optional<Theme> findByName(ThemeName name);
}
