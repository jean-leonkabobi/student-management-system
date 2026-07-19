package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "audit_log")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;

    @Column(nullable = false, length = 100)
    private String action;

    @Column(length = 50)
    private String entite;

    @Column(name = "entite_id")
    private Long entiteId;

    @Column(name = "anciennes_valeurs", columnDefinition = "JSON")
    private String anciennesValeurs;

    @Column(name = "nouvelles_valeurs", columnDefinition = "JSON")
    private String nouvellesValeurs;

    @Column(name = "ip_address", length = 45)
    private String ipAddress;

    @Column(name = "user_agent", columnDefinition = "TEXT")
    private String userAgent;

    @Column(name = "date_action", updatable = false)
    private LocalDateTime dateAction;

    @PrePersist
    protected void onCreate() {
        dateAction = LocalDateTime.now();
    }
}