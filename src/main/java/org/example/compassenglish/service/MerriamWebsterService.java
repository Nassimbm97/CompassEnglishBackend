package org.example.compassenglish.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

/**
 * Merriam-Webster Collegiate Dictionary
 * Proporciona definiciones en ingles y URL de audio
 * API: https://www.dictionaryapi.com/api/v3/references/collegiate/json/{word}?key={key}
 */
@Service
public class MerriamWebsterService {

    @Value("${merriam.api.key}")
    private String apiKey;

    private static final String BASE_URL =
            "https://www.dictionaryapi.com/api/v3/references/collegiate/json/";
    private static final String AUDIO_BASE =
            "https://media.merriam-webster.com/audio/prons/en/us/mp3/";

    private final WebClient webClient;

    public MerriamWebsterService(WebClient.Builder builder) {
        this.webClient = builder.baseUrl(BASE_URL).build();
    }

    // ----------------------------------------------------------------
    // Obtiene definicion + URL de audio de una palabra en ingles
    // ----------------------------------------------------------------
    public MerriamResponse getDefinition(String word) {
        try {
            List<?> raw = webClient.get()
                    .uri(word + "?key=" + apiKey)
                    .retrieve()
                    .bodyToMono(List.class)
                    .block();

            if (raw == null || raw.isEmpty())
                return new MerriamResponse(word, null, null);

            // Si el primer elemento es String son sugerencias (palabra no encontrada)
            if (!(raw.get(0) instanceof Map))
                return new MerriamResponse(word, null, null);

            Map<?, ?> entry = (Map<?, ?>) raw.get(0);

            String definition = extractDefinition(entry);
            String audioUrl   = extractAudioUrl(entry);

            return new MerriamResponse(word, definition, audioUrl);

        } catch (Exception e) {
            System.err.println("Error MerriamWebsterService: " + e.getMessage());
            return new MerriamResponse(word, null, null);
        }
    }

    // ----------------------------------------------------------------
    // Extrae la primera definicion del JSON
    // ----------------------------------------------------------------
    private String extractDefinition(Map<?, ?> entry) {
        try {
            Object defObj = entry.get("def");
            if (!(defObj instanceof List<?> defList) || defList.isEmpty()) return null;

            Object firstSense = defList.get(0);
            if (!(firstSense instanceof Map<?, ?> senseMap)) return null;

            Object sseqObj = senseMap.get("sseq");
            if (!(sseqObj instanceof List<?> sseq) || sseq.isEmpty()) return null;

            Object firstSseq = sseq.get(0);
            if (!(firstSseq instanceof List<?> sseqInner) || sseqInner.isEmpty()) return null;

            Object firstEntry = sseqInner.get(0);
            if (!(firstEntry instanceof List<?> entryPair) || entryPair.size() < 2) return null;

            Object senseData = entryPair.get(1);
            if (!(senseData instanceof Map<?, ?> senseDataMap)) return null;

            Object dtObj = senseDataMap.get("dt");
            if (!(dtObj instanceof List<?> dt) || dt.isEmpty()) return null;

            Object firstDt = dt.get(0);
            if (!(firstDt instanceof List<?> dtPair) || dtPair.size() < 2) return null;

            Object text = dtPair.get(1);
            if (!(text instanceof String s)) return null;

            // Limpia el formato Merriam ({bc}, {sx|...|}, etc.)
            return s.replaceAll("\\{[^}]*\\}", "").trim();

        } catch (Exception e) {
            return null;
        }
    }

    // ----------------------------------------------------------------
    // Extrae la URL del audio MP3
    // ----------------------------------------------------------------
    private String extractAudioUrl(Map<?, ?> entry) {
        try {
            Object hwiObj = entry.get("hwi");
            if (!(hwiObj instanceof Map<?, ?> hwi)) return null;

            Object prsObj = hwi.get("prs");
            if (!(prsObj instanceof List<?> prs) || prs.isEmpty()) return null;

            Object firstPrs = prs.get(0);
            if (!(firstPrs instanceof Map<?, ?> prsMap)) return null;

            Object soundObj = prsMap.get("sound");
            if (!(soundObj instanceof Map<?, ?> sound)) return null;

            Object audio = sound.get("audio");
            if (!(audio instanceof String audioStr)) return null;

            // Subdirectorio segun reglas de Merriam-Webster
            String subdir;
            if (audioStr.startsWith("bix"))                          subdir = "bix";
            else if (audioStr.startsWith("gg"))                      subdir = "gg";
            else if (Character.isDigit(audioStr.charAt(0))
                  || audioStr.charAt(0) == '_')                      subdir = "number";
            else                                                      subdir = String.valueOf(audioStr.charAt(0));

            return AUDIO_BASE + subdir + "/" + audioStr + ".mp3";

        } catch (Exception e) {
            return null;
        }
    }

    // ----------------------------------------------------------------
    // DTO de respuesta
    // ----------------------------------------------------------------
    public record MerriamResponse(
            String word,
            String definition,
            String audioUrl
    ) {}
}
