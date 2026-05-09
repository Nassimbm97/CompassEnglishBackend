package org.example.compassenglish.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

/**
 * Servicio Merriam-Webster Spanish-English Dictionary
 * Sustituye a MyMemoryTranslator para validar traducciones
 *
 * API: https://www.dictionaryapi.com/api/v3/references/spanish/json/{word}?key={key}
 * Documentación: https://dictionaryapi.com/products/api-spanish-dictionary
 */
@Service
public class MerriamSpanishService {

    @Value("${merriam.spanish.api.key}")
    private String apiKey;

    private static final String BASE_URL = "https://www.dictionaryapi.com/api/v3/references/spanish/json/";

    private final WebClient webClient;

    public MerriamSpanishService(WebClient.Builder builder) {
        this.webClient = builder.baseUrl(BASE_URL).build();
    }

    /**
     * Busca las traducciones al inglés de una palabra española.
     * Devuelve lista de traducciones válidas o lista vacía si no encuentra nada.
     *
     * Ejemplo: translate("triste") → ["sad", "unhappy", "sorrowful"]
     */
    public List<String> translate(String spanishWord) {
        try {
            List<?> raw = webClient.get()
                    .uri(spanishWord + "?key=" + apiKey)
                    .retrieve()
                    .bodyToMono(List.class)
                    .block();

            if (raw == null || raw.isEmpty()) return List.of();

            // Si el primer elemento es String, son sugerencias (palabra no encontrada)
            if (raw.get(0) instanceof String) return List.of();

            // Extraer todas las traducciones al inglés
            List<String> translations = new java.util.ArrayList<>();

            for (Object entry : raw) {
                if (!(entry instanceof Map)) continue;
                Map<?, ?> entryMap = (Map<?, ?>) entry;

                // shortdef contiene las traducciones directas en formato limpio
                Object shortdef = entryMap.get("shortdef");
                if (shortdef instanceof List<?> defs) {
                    for (Object def : defs) {
                        if (def instanceof String s && !s.isBlank()) {
                            // Limpiar formato: "sad; unhappy" → ["sad", "unhappy"]
                            String[] parts = s.split("[;,]");
                            for (String part : parts) {
                                String clean = part.trim().toLowerCase();
                                if (!clean.isEmpty() && !translations.contains(clean)) {
                                    translations.add(clean);
                                }
                            }
                        }
                    }
                }
            }

            return translations;

        } catch (Exception e) {
            System.err.println("Error Merriam Spanish-English: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * Comprueba si una respuesta del alumno es una traducción válida
     * según Merriam-Webster Spanish-English.
     *
     * @return ValidationResult con isValid y lista de traducciones encontradas
     */
    public ValidationResult validate(String spanishWord, String userAnswer) {
        List<String> translations = translate(spanishWord);

        if (translations.isEmpty()) {
            return new ValidationResult(false, List.of(), true); // noData = true
        }

        boolean valid = translations.stream()
                .anyMatch(t -> t.equalsIgnoreCase(userAnswer.trim()));

        return new ValidationResult(valid, translations, false);
    }

    public record ValidationResult(
            boolean isValid,
            List<String> validTranslations,
            boolean noData  // true si Merriam no tiene esta palabra
    ) {}
}
