package org.example.compassenglish.repository;

import org.example.compassenglish.model.UserProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface UserProgressRepository extends JpaRepository<UserProgress, Integer> {
    List<UserProgress> findByUserId(int userId);
    Optional<UserProgress> findByUserIdAndThemeId(int userId, int themeId);
}
