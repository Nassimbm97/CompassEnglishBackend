package org.example.compassenglish.repository;

import org.example.compassenglish.model.ReadingText;
import org.example.compassenglish.model.enums.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReadingTextRepository extends JpaRepository<ReadingText, Integer> {
    List<ReadingText> findByLevel(Level level);
    List<ReadingText> findByThemeId(int themeId);
}
