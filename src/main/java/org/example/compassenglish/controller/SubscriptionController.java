package org.example.compassenglish.controller;

import org.example.compassenglish.model.Subscription;
import org.example.compassenglish.service.SubscriptionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/subscription")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    public SubscriptionController(SubscriptionService subscriptionService) {
        this.subscriptionService = subscriptionService;
    }

    // POST /api/subscription/activate/{userId}
    // Simula el pago — activa premium 30 días
    @PostMapping("/activate/{userId}")
    public ResponseEntity<?> activate(@PathVariable int userId) {
        Subscription sub = subscriptionService.activate(userId);
        return ResponseEntity.ok(Map.of(
                "status",    sub.getStatus(),
                "startDate", sub.getStartDate().toString(),
                "endDate",   sub.getEndDate().toString(),
                "active",    sub.isActive()
        ));
    }

    // GET /api/subscription/status/{userId}
    @GetMapping("/status/{userId}")
    public ResponseEntity<?> status(@PathVariable int userId) {
        boolean active = subscriptionService.isActive(userId);
        return ResponseEntity.ok(Map.of("active", active));
    }

    // DELETE /api/subscription/cancel/{userId}
    @DeleteMapping("/cancel/{userId}")
    public ResponseEntity<?> cancel(@PathVariable int userId) {
        subscriptionService.cancel(userId);
        return ResponseEntity.ok(Map.of("message", "Suscripción cancelada"));
    }
}
