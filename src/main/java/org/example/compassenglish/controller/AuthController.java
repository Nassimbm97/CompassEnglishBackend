package org.example.compassenglish.controller;

import org.example.compassenglish.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.example.compassenglish.model.enums.LearningMode;
import org.example.compassenglish.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

// Reemplaza LoginController y SettingsController de JavaFX
// El frontend Android (Jetpack Compose) llama a estos endpoints con Retrofit
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    // POST /api/auth/login
    // Body: { "username": "...", "password": "..." }
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body) {
        Optional<User> user = userService.login(
                body.get("username"),
                body.get("password")
        );
        if (user.isEmpty())
            return ResponseEntity.status(401).body(Map.of("error", "Credenciales incorrectas"));

        return ResponseEntity.ok(toDto(user.get()));
    }

    // POST /api/auth/register
    // Body: { "username": "...", "password": "...", "email": "...", "learningMode": "FREE|EVALUATION" }
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Map<String, String> body) {
        try {
            String rawPassword = body.get("password");
            String hashed = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
            User user = new User(body.get("username"), hashed, body.get("email"));
            if (body.containsKey("learningMode")) {
                try { user.setLearningMode(LearningMode.valueOf(body.get("learningMode"))); }
                catch (IllegalArgumentException ignored) {}
            }
            User saved = userService.registerHashed(user);
            return ResponseEntity.ok(toDto(saved));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // PUT /api/auth/settings/{userId}
    // Body: { "username": "...", "email": "...", "password": "...", "avatarUrl": "..." }
    // Reemplaza SettingsController.saveChanges()
    @PutMapping("/settings/{userId}")
    public ResponseEntity<?> updateSettings(@PathVariable int userId,
                                            @RequestBody Map<String, String> body) {
        User user = userService.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));

        if (body.containsKey("username") && !body.get("username").isBlank())
            user.setUsername(body.get("username"));

        if (body.containsKey("email") && body.get("email").contains("@"))
            user.setEmail(body.get("email"));

        if (body.containsKey("password") && !body.get("password").isBlank())
            user.setPassword(body.get("password")); // UserService aplica el hash

        if (body.containsKey("avatarUrl"))
            user.setAvatarUrl(body.get("avatarUrl"));

        if (body.containsKey("learningMode")) {
            try {
                user.setLearningMode(LearningMode.valueOf(body.get("learningMode")));
            } catch (IllegalArgumentException ignored) {}
        }

        userService.update(user);
        return ResponseEntity.ok(toDto(user));
    }

    // DELETE /api/auth/{userId}
    // Reemplaza SettingsController.handleDeleteUser()
    @DeleteMapping("/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable int userId) {
        boolean deleted = userService.delete(userId);
        if (!deleted)
            return ResponseEntity.notFound().build();
        return ResponseEntity.ok(Map.of("message", "Usuario eliminado"));
    }

    // Mapeo a DTO — no expone la contraseña
    private Map<String, Object> toDto(User user) {
        Map<String, Object> dto = new java.util.HashMap<>();
        dto.put("id",             user.getId());
        dto.put("username",       user.getUsername());
        dto.put("email",          user.getEmail());
        dto.put("points",         user.getPoints());
        dto.put("premium",        user.isPremium());
        dto.put("learningMode",   user.getLearningMode());
        dto.put("avatarUrl",      user.getAvatarUrl());
        dto.put("levelEstimated", user.getLevelEstimated());
        dto.put("role",           user.getRole());
        return dto;
    }
}