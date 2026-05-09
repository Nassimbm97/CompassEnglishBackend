package org.example.compassenglish.service;

import org.example.compassenglish.model.User;
import org.example.compassenglish.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RankingService {

    private final UserRepository userRepository;

    public RankingService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getTopUsers(int limit) {
        List<User> all = userRepository.findAllOrderByPointsDesc();
        return all.subList(0, Math.min(limit, all.size()));
    }

    public int getUserRank(int userId) {
        List<User> all = userRepository.findAllOrderByPointsDesc();
        for (int i = 0; i < all.size(); i++) {
            if (all.get(i).getId() == userId) return i + 1;
        }
        return -1;
    }
}
