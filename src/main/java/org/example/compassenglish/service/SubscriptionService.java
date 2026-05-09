package org.example.compassenglish.service;

import org.example.compassenglish.model.Subscription;
import org.example.compassenglish.model.User;
import org.example.compassenglish.repository.SubscriptionRepository;
import org.example.compassenglish.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;
    private final UserRepository         userRepository;

    public SubscriptionService(SubscriptionRepository subscriptionRepository,
                               UserRepository userRepository) {
        this.subscriptionRepository = subscriptionRepository;
        this.userRepository         = userRepository;
    }

    // "Pago" simulado: crea la suscripción y activa el flag premium en User
    public Subscription activate(int userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));

        Subscription sub = subscriptionRepository.findByUserId(userId)
                .orElse(new Subscription(user));

        // Resetea fechas aunque ya existiera
        sub = new Subscription(user);
        user.setPremium(true);
        userRepository.save(user);
        return subscriptionRepository.save(sub);
    }

    public boolean isActive(int userId) {
        return subscriptionRepository.findByUserId(userId)
                .map(Subscription::isActive)
                .orElse(false);
    }

    public void cancel(int userId) {
        subscriptionRepository.findByUserId(userId).ifPresent(sub -> {
            sub.setStatus(org.example.compassenglish.model.enums.SubscriptionStatus.CANCELLED);
            subscriptionRepository.save(sub);
            userRepository.findById(userId).ifPresent(u -> {
                u.setPremium(false);
                userRepository.save(u);
            });
        });
    }
}
