package org.example.compassenglish.repository;

import org.example.compassenglish.model.UserWord;
import org.example.compassenglish.model.enums.CardState;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface UserWordRepository extends JpaRepository<UserWord, Integer> {

    Optional<UserWord> findByUserIdAndWordId(int userId, int wordId);

    // Palabras que toca repasar hoy (FSRS)
    @Query("SELECT uw FROM UserWord uw WHERE uw.user.id = :uid AND uw.dueDate <= :now")
    List<UserWord> findDueByUser(@Param("uid") int userId, @Param("now") LocalDateTime now);

    // Palabras consolidadas (para calcular nivel del alumno)
    @Query("SELECT uw FROM UserWord uw JOIN uw.word w WHERE uw.user.id = :uid AND uw.state = :state AND w.level = :level")
    List<UserWord> findByUserAndStateAndLevel(@Param("uid") int userId,
                                              @Param("state") CardState state,
                                              @Param("level") org.example.compassenglish.model.enums.Level level);

    long countByUserIdAndState(int userId, CardState state);
}
