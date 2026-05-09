package org.example.compassenglish.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

// Sustituye a MyMemoryTranslator
// Se llama UNA SOLA VEZ por palabra y el resultado se cachea en WordCopy
@Service
public class AnthropicService {

    @Value("${anthropic.api.key}")
    private String apiKey;

    @Value("${anthropic.api.url}")
    private String apiUrl;

    @Value("${anthropic.model}")
    private String model;

    private final WebClient webClient;

    public AnthropicService(WebClient.Builder builder) {
        this.webClient = builder.build();
    }

    // ----------------------------------------------------------------
    // Traducción — misma función que MyMemory pero con Claude
    // Solo se llama si la palabra no está en Word ni en WordCopy
    // ----------------------------------------------------------------

    public String translate(String word, String fromLang, String toLang) {
        String prompt = "Translate the word \"" + word + "\" from " + fromLang
                + " to " + toLang + ". Reply with ONLY the translated word, "
                + "no explanation, no punctuation, no alternatives.";
        try {
            Map<?, ?> response = webClient.post()
                    .uri(apiUrl)
                    .header("x-api-key", apiKey)
                    .header("anthropic-version", "2023-06-01")
                    .header("content-type", "application/json")
                    .bodyValue(Map.of(
                            "model", model,
                            "max_tokens", 20,
                            "messages", List.of(Map.of("role", "user", "content", prompt))
                    ))
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            if (response == null) return null;

            List<?> content = (List<?>) response.get("content");
            if (content == null || content.isEmpty()) return null;

            Map<?, ?> first = (Map<?, ?>) content.get(0);
            String result = (String) first.get("text");
            return result != null ? result.trim() : null;

        } catch (Exception e) {
            System.err.println("Error en AnthropicService.translate: " + e.getMessage());
            return null;
        }
    }

    // ----------------------------------------------------------------
    // Genera frases de ejemplo para una palabra nueva (solo Premium)
    // Se cachean y nunca se vuelven a pedir
    // Justificación lingüística: Contextual Learning Theory (Krashen input)
    // ----------------------------------------------------------------

    public List<String> generateExamples(String word, String level) {
        String prompt = "Generate 3 example sentences in English using the word \""
                + word + "\" appropriate for a " + level + " level English learner. "
                + "Reply ONLY with a JSON array of 3 strings, no explanation.";
        try {
            Map<?, ?> response = webClient.post()
                    .uri(apiUrl)
                    .header("x-api-key", apiKey)
                    .header("anthropic-version", "2023-06-01")
                    .header("content-type", "application/json")
                    .bodyValue(Map.of(
                            "model", model,
                            "max_tokens", 200,
                            "messages", List.of(Map.of("role", "user", "content", prompt))
                    ))
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            if (response == null) return List.of();

            List<?> content = (List<?>) response.get("content");
            if (content == null || content.isEmpty()) return List.of();

            Map<?, ?> first = (Map<?, ?>) content.get(0);
            String text = (String) first.get("text");
            if (text == null) return List.of();

            // Parse simple del array JSON
            text = text.trim().replaceAll("^\\[|]$", "");
            String[] parts = text.split("\",\\s*\"");
            List<String> result = new java.util.ArrayList<>();
            for (String p : parts) {
                result.add(p.replaceAll("^\"|\"$", "").trim());
            }
            return result;

        } catch (Exception e) {
            System.err.println("Error en AnthropicService.generateExamples: " + e.getMessage());
            return List.of();
        }
    }
}
