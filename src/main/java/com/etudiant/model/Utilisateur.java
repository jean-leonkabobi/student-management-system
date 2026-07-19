package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateur")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 50)
    @NotBlank(message = "Le nom d'utilisateur est obligatoire")
    @Size(max = 50, message = "Le nom d'utilisateur ne peut pas dépasser 50 caractères")
    private String username;

    @Column(name = "password_hash", nullable = false, length = 255)
    @NotBlank(message = "Le mot de passe est obligatoire")
    private String passwordHash;

    @Column(nullable = false, length = 100)
    @Email(message = "L'email doit être valide")
    @NotBlank(message = "L'email est obligatoire")
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "etudiant_id")
    private Etudiant etudiant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "enseignant_id")
    private Enseignant enseignant;

    @Column(name = "derniere_connexion")
    private LocalDateTime derniereConnexion;

    @Column(name = "est_actif")
    private Boolean estActif = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public enum Role {
        ADMIN, SCOLARITE, ENSEIGNANT, ETUDIANT, COMPTABLE, BIBLIOTHECAIRE
    }
}