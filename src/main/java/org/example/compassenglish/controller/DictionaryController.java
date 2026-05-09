package org.example.compassenglish.controller;

import org.example.compassenglish.model.Word;
import org.example.compassenglish.model.enums.ThemeName;
import org.example.compassenglish.model.enums.WordType;
import org.example.compassenglish.service.MerriamSpanishService;
import org.example.compassenglish.service.MerriamWebsterService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/dictionary")
public class DictionaryController {

    private final MerriamWebsterService merriamCollegiate;
    private final MerriamSpanishService merriamSpanish;

    @PersistenceContext
    private EntityManager em;

    public DictionaryController(MerriamWebsterService merriamCollegiate,
                                MerriamSpanishService merriamSpanish) {
        this.merriamCollegiate = merriamCollegiate;
        this.merriamSpanish    = merriamSpanish;
    }

    // GET /api/dictionary
    @GetMapping
    public ResponseEntity<?> getAllWords() {
        List<Word> words = em.createQuery(
            "SELECT DISTINCT w FROM Word w LEFT JOIN FETCH w.themes", Word.class
        ).getResultList();
        return ResponseEntity.ok(words.stream().map(this::toDto).toList());
    }

    // GET /api/dictionary/search?q=perro&type=Noun&theme=Food
    @GetMapping("/search")
    public ResponseEntity<?> search(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String theme) {

        String jpql = "SELECT DISTINCT w FROM Word w LEFT JOIN FETCH w.themes t WHERE 1=1";
        Map<String, Object> params = new LinkedHashMap<>();

        if (q != null && !q.isBlank()) {
            jpql += " AND (LOWER(w.wordSpa) LIKE :q OR LOWER(w.wordEng) LIKE :q)";
            params.put("q", "%" + q.toLowerCase() + "%");
        }
        if (type != null && !type.isBlank()) {
            try { jpql += " AND w.type = :type"; params.put("type", WordType.valueOf(type)); }
            catch (IllegalArgumentException ignored) {}
        }
        if (theme != null && !theme.isBlank()) {
            try { jpql += " AND t.name = :theme"; params.put("theme", ThemeName.valueOf(theme)); }
            catch (IllegalArgumentException ignored) {}
        }

        var query = em.createQuery(jpql, Word.class);
        params.forEach(query::setParameter);
        return ResponseEntity.ok(query.getResultList().stream().map(this::toDto).toList());
    }

    // GET /api/dictionary/types
    @GetMapping("/types")
    public ResponseEntity<?> getTypes() {
        return ResponseEntity.ok(
            Arrays.stream(WordType.values()).map(Enum::name).toList());
    }

    // GET /api/dictionary/themes
    @GetMapping("/themes")
    public ResponseEntity<?> getThemes() {
        return ResponseEntity.ok(
            Arrays.stream(ThemeName.values()).map(Enum::name).toList());
    }

    // GET /api/dictionary/definition/{wordEng}
    // Collegiate → definicion en ingles + audio
    // Spanish    → traduccion al espanol
    @GetMapping("/definition/{wordEng}")
    public ResponseEntity<?> getDefinition(@PathVariable String wordEng) {

        // Definicion en ingles y audio (Collegiate)
        MerriamWebsterService.MerriamResponse collegiate =
                merriamCollegiate.getDefinition(wordEng);

        // Traducciones al espanol (Spanish-English)
        List<String> translations = merriamSpanish.translate(wordEng);
        String spanishMeaning = translations.isEmpty()
                ? "Traduccion no disponible"
                : String.join(", ", translations);

        return ResponseEntity.ok(Map.of(
                "word",           wordEng,
                "definition",     collegiate.definition()  != null
                                      ? collegiate.definition() : "Definition not available",
                "spanishMeaning", spanishMeaning,
                "audioUrl",       collegiate.audioUrl()    != null
                                      ? collegiate.audioUrl()    : ""
        ));
    }

    // ----------------------------------------------------------------
    // DTO
    // ----------------------------------------------------------------
    private Map<String, Object> toDto(Word w) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",            w.getId());
        dto.put("wordSpa",       w.getWordSpa());
        dto.put("wordEng",       w.getWordEng());
        dto.put("level",         w.getLevel()  != null ? w.getLevel().name()  : "BEGINNER");
        dto.put("type",          w.getType()   != null ? w.getType().name()   : "");
        dto.put("themes",        w.getThemes().stream()
                                   .map(t -> t.getName().name())
                                   .collect(Collectors.toList()));
        dto.put("isFalseFriend", w.isFalseFriend());
        dto.put("feedbackHint",  w.getFeedbackHint() != null ? w.getFeedbackHint() : "");
        return dto;
    }
}
