package org.example.compassenglish.repository;

import org.example.compassenglish.model.CustomCard;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CustomCardRepository extends JpaRepository<CustomCard, Integer> {
    List<CustomCard> findByUserId(int userId);
}
