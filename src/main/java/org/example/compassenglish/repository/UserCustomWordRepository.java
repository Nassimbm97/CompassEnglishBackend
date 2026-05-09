package org.example.compassenglish.repository;

import org.example.compassenglish.model.UserCustomWord;
import org.example.compassenglish.model.enums.CardState;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Repositorio JPA para el estado FSRS de los apuntes personales.
 * Análogo a UserWordRepository pero para UserCustomWord.
 *
 * @author Nassim Bouderbane Marrero
 */
public interface UserCustomWordRepository extends JpaRepository<UserCustomWord, Integer> {

    Optional<UserCustomWord> findByUserIdAndCustomCardId(int userId, int customCardId);

    List<UserCustomWord> findByUserId(int userId);

    @Query("SELECT ucw FROM UserCustomWord ucw WHERE ucw.user.id = :userId AND ucw.dueDate <= :now")
    List<UserCustomWord> findDueByUser(@Param("userId") int userId, @Param("now") LocalDateTime now);

    long countByUserIdAndState(int userId, CardState state);
}
