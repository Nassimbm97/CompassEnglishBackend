package org.example.compassenglish.model;

import jakarta.persistence.*;
import org.example.compassenglish.model.enums.SubscriptionStatus;

import java.time.LocalDate;

@Entity
@Table(name = "Subscription")
public class Subscription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UserId", nullable = false, unique = true)
    private User user;

    @Column(name = "StartDate", nullable = false)
    private LocalDate startDate;

    @Column(name = "EndDate", nullable = false)
    private LocalDate endDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "Status")
    private SubscriptionStatus status = SubscriptionStatus.ACTIVE;

    public Subscription() {}

    public Subscription(User user) {
        this.user      = user;
        this.startDate = LocalDate.now();
        this.endDate   = LocalDate.now().plusDays(30);
        this.status    = SubscriptionStatus.ACTIVE;
    }

    public boolean isActive() {
        return status == SubscriptionStatus.ACTIVE
               && !LocalDate.now().isAfter(endDate);
    }

    public int getId()                              { return id; }
    public User getUser()                           { return user; }
    public LocalDate getStartDate()                 { return startDate; }
    public LocalDate getEndDate()                   { return endDate; }
    public SubscriptionStatus getStatus()           { return status; }
    public void setStatus(SubscriptionStatus s)     { this.status = s; }
}
