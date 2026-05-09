package org.example.compassenglish.controller;

import org.example.compassenglish.model.CustomCard;
import org.example.compassenglish.model.Theme;
import org.example.compassenglish.model.User;
import org.example.compassenglish.model.enums.Level;
import org.example.compassenglish.model.enums.ThemeName;
import org.example.compassenglish.repository.CustomCardRepository;
import org.example.compassenglish.repository.ThemeRepository;
import org.example.compassenglish.repository.UserRepository;
import org.example.compassenglish.service.FsrsService;
import org.example.compassenglish.service.MerriamSpanishService;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Controlador REST para la gestión de apuntes personales (CustomCards).
 *
 * <p>Permite al usuario crear, editar, eliminar y consultar sus propias
 * tarjetas de vocabulario, que participan en el sistema FSRS de la misma
 * forma que las palabras de la base de datos oficial.</p>
 *
 * @author Nassim Bouderbane Marrero
 */
@RestController
@RequestMapping("/api/custom-cards")
public class CustomCardController {

    private final CustomCardRepository  customCardRepository;
    private final UserRepository        userRepository;
    private final ThemeRepository       themeRepository;
    private final MerriamSpanishService merriamSpanish;
    private final FsrsService           fsrsService;

    public CustomCardController(CustomCardRepository customCardRepository,
                                UserRepository userRepository,
                                ThemeRepository themeRepository,
                                MerriamSpanishService merriamSpanish,
                                FsrsService fsrsService) {
        this.customCardRepository = customCardRepository;
        this.userRepository       = userRepository;
        this.themeRepository      = themeRepository;
        this.merriamSpanish       = merriamSpanish;
        this.fsrsService          = fsrsService;
    }

    /**
     * Devuelve todas las tarjetas personales de un usuario.
     *
     * @param userId id del usuario
     * @return lista de DTOs de tarjeta
     */
    @Transactional(readOnly = true)
    @GetMapping("/{userId}")
    public ResponseEntity<?> getCards(@PathVariable int userId) {
        return ResponseEntity.ok(
            customCardRepository.findByUserId(userId)
                .stream().map(this::toDto).toList()
        );
    }

    /**
     * Crea una nueva tarjeta personal.
     * Body: { userId, wordSpa, wordEng, notes, level, theme }
     *
     * @param body mapa con los campos de la tarjeta
     * @return DTO de la tarjeta creada
     */
    @Transactional
    @PostMapping
    public ResponseEntity<?> createCard(@RequestBody Map<String, Object> body) {
        int userId      = (int) body.get("userId");
        String wordSpa  = (String) body.get("wordSpa");
        String wordEng  = (String) body.get("wordEng");
        String notes    = body.containsKey("notes")  ? (String) body.get("notes")  : null;
        String levelStr = body.containsKey("level")  ? (String) body.get("level")  : "BEGINNER";
        String themeStr = body.containsKey("theme")  ? (String) body.get("theme")  : null;

        if (wordSpa == null || wordSpa.isBlank() || wordEng == null || wordEng.isBlank())
            return ResponseEntity.badRequest().body(Map.of("error", "Palabra y traduccion son obligatorias"));

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));

        CustomCard card = new CustomCard();
        card.setUser(user);
        card.setWordSpa(wordSpa.trim());
        card.setWordEng(wordEng.trim());
        card.setNotes(notes);
        card.setLevel(Level.valueOf(levelStr));

        if (themeStr != null && !themeStr.isBlank()) {
            try {
                themeRepository.findByName(ThemeName.valueOf(themeStr))
                    .ifPresent(card::setTheme);
            } catch (IllegalArgumentException ignored) {}
        }

        customCardRepository.save(card);
        return ResponseEntity.ok(toDto(card));
    }

    /**
     * Elimina una tarjeta personal por id.
     *
     * @param cardId id de la tarjeta
     * @return confirmación o 404
     */
    @DeleteMapping("/{cardId}")
    public ResponseEntity<?> deleteCard(@PathVariable int cardId) {
        if (!customCardRepository.existsById(cardId))
            return ResponseEntity.notFound().build();
        customCardRepository.deleteById(cardId);
        return ResponseEntity.ok(Map.of("message", "Tarjeta eliminada"));
    }

    /**
     * Actualiza una tarjeta personal existente.
     * Body: { wordSpa, wordEng, notes, level } (todos opcionales)
     *
     * @param cardId id de la tarjeta
     * @param body   campos a actualizar
     * @return DTO actualizado
     */
    @Transactional
    @PutMapping("/{cardId}")
    public ResponseEntity<?> updateCard(@PathVariable int cardId,
                                        @RequestBody Map<String, Object> body) {
        CustomCard card = customCardRepository.findById(cardId)
                .orElseThrow(() -> new IllegalArgumentException("Tarjeta no encontrada"));

        if (body.containsKey("wordSpa")) card.setWordSpa((String) body.get("wordSpa"));
        if (body.containsKey("wordEng")) card.setWordEng((String) body.get("wordEng"));
        if (body.containsKey("notes"))   card.setNotes((String) body.get("notes"));
        if (body.containsKey("level"))   card.setLevel(Level.valueOf((String) body.get("level")));

        customCardRepository.save(card);
        return ResponseEntity.ok(toDto(card));
    }

    /**
     * Devuelve sugerencias de traducción de Merriam Spanish-English.
     * Se llama al crear una tarjeta, no en cada ejercicio.
     *
     * @param wordSpa palabra en español
     * @return lista de sugerencias y flag hasData
     */
    @GetMapping("/suggestions/{wordSpa}")
    public ResponseEntity<?> getSuggestions(@PathVariable String wordSpa) {
        List<String> suggestions = merriamSpanish.translate(wordSpa);
        return ResponseEntity.ok(Map.of(
            "wordSpa",     wordSpa,
            "suggestions", suggestions,
            "hasData",     !suggestions.isEmpty()
        ));
    }

    private Map<String, Object> toDto(CustomCard c) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",      c.getId());
        dto.put("wordSpa", c.getWordSpa());
        dto.put("wordEng", c.getWordEng());
        dto.put("notes",   c.getNotes() != null ? c.getNotes() : "");
        dto.put("level",   c.getLevel() != null ? c.getLevel().name() : "BEGINNER");
        dto.put("theme",   c.getTheme() != null ? c.getTheme().getName().name() : "");
        return dto;
    }
}
