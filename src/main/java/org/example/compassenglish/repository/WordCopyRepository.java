package org.example.compassenglish.repository;

import org.example.compassenglish.model.WordCopy;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface WordCopyRepository extends JpaRepository<WordCopy, Integer> {
    List<WordCopy> findByWordSpaIgnoreCase(String wordSpa);
    Optional<WordCopy> findByWordSpaIgnoreCaseAndWordEngIgnoreCase(String spa, String eng);
    boolean existsByWordSpaIgnoreCaseAndWordEngIgnoreCase(String spa, String eng);
}
