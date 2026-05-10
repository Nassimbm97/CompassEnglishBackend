package org.example.compassenglish.repository;

import org.example.compassenglish.model.Word;
import org.example.compassenglish.model.enums.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface WordRepository extends JpaRepository<Word, Integer> {

    // Búsqueda exacta (para validar respuestas)
    List<Word> findByWordSpaIgnoreCase(String wordSpa);
    List<Word> findByWordEngIgnoreCase(String wordEng);

    // Búsqueda parcial (para el diccionario)
    List<Word> findByWordSpaContainingIgnoreCase(String wordSpa);

    // Filtrar por nivel — Krashen i+1
    List<Word> findByLevel(Level level);

    // Palabras de un tema concreto con nivel
    @Query("SELECT DISTINCT w FROM Word w JOIN w.themes t WHERE t.name = :theme AND w.level = :level")
    List<Word> findByThemeAndLevel(@Param("theme") org.example.compassenglish.model.enums.ThemeName theme, @Param("level") Level level);

    @Query("SELECT DISTINCT w FROM Word w JOIN w.themes t WHERE t.name = :theme")
    List<Word> findByThemeName(@Param("theme") org.example.compassenglish.model.enums.ThemeName theme);

    // Falsos amigos
    List<Word> findByIsFalseFriendTrue();
}