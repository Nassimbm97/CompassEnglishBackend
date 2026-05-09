package org.example.compassenglish.repository;

import org.example.compassenglish.model.FillGapExercise;
import org.example.compassenglish.model.enums.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FillGapExerciseRepository extends JpaRepository<FillGapExercise, Integer> {
    List<FillGapExercise> findByWordId(int wordId);
    List<FillGapExercise> findByLevel(Level level);
}
