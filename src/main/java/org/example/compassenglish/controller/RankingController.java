package org.example.compassenglish.controller;

import org.example.compassenglish.model.User;
import org.example.compassenglish.service.RankingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ranking")
public class RankingController {

    private final RankingService rankingService;

    public RankingController(RankingService rankingService) {
        this.rankingService = rankingService;
    }

    // GET /api/ranking?limit=20
    @GetMapping
    public ResponseEntity<?> getRanking(@RequestParam(defaultValue = "20") int limit) {
        List<User> top = rankingService.getTopUsers(limit);
        return ResponseEntity.ok(top.stream().map(u -> Map.of(
                "id",             u.getId(),
                "username",       u.getUsername(),
                "points",         u.getPoints(),
                "premium",        u.isPremium(),
                "levelEstimated", u.getLevelEstimated()
        )).toList());
    }

    // GET /api/ranking/user/{userId}
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getUserRank(@PathVariable int userId) {
        int rank = rankingService.getUserRank(userId);
        return ResponseEntity.ok(Map.of("userId", userId, "rank", rank));
    }
}
