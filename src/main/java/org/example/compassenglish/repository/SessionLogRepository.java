package org.example.compassenglish.repository;

import org.example.compassenglish.model.SessionLog;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface SessionLogRepository extends JpaRepository<SessionLog, Integer> {
    List<SessionLog> findByUserIdAndSessionDate(int userId, LocalDate date);
    List<SessionLog> findByUserIdAndSessionDateBetween(int userId, LocalDate from, LocalDate to);
    List<SessionLog> findByUserId(int userId);
}
