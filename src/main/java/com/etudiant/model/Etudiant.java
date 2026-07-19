package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.format.DateTimeFormatter;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "etudiant")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Etudiant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 20)
    @NotBlank(message = "Le matricule est obligatoire")
    @Size(max = 20, message = "Le matricule ne peut pas dépasser 20 caractères")
    private String matricule;

    @Column(nullable = false, length = 50)
    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 50, message = "Le nom ne peut pas dépasser 50 caractères")
    private String nom;

    @Column(length = 50)
    private String postnom;

    @Column(nullable = false, length = 50)
    @NotBlank(message = "Le prénom est obligatoire")
    @Size(max = 50, message = "Le prénom ne peut pas dépasser 50 caractères")
    private String prenom;

    @Enumerated(EnumType.STRING)
    private Sexe sexe;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "lieu_naissance")
    private String lieuNaissance;

    private String nationalite;

    @Column(name = "etat_civil")
    private String etatCivil;

    private String photo;

    @Size(max = 20, message = "Le téléphone ne peut pas dépasser 20 caractères")
    private String telephone;

    @Email(message = "L'email doit être valide")
    @Column(unique = true)
    private String email;

    @Column(columnDefinition = "TEXT")
    private String adresse;

    private String ville;
    private String pays;

    @Enumerated(EnumType.STRING)
    private StatutEtudiant statut = StatutEtudiant.ACTIF;

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Tuteur> tuteurs = new ArrayList<>();

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Document> documents = new ArrayList<>();

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Inscription> inscriptions = new ArrayList<>();

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum Sexe {
        M, F
    }

    public enum StatutEtudiant {
        ACTIF, SUSPENDU, DIPLOME, ABANDONNE
    }

    public String getNomComplet() {
        return (postnom != null && !postnom.isEmpty() ? postnom + " " : "") + nom + " " + prenom;
    }

    public String getDateNaissanceFormatted() {
        if (dateNaissance == null) {
            return "";
        }
        return dateNaissance.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
}