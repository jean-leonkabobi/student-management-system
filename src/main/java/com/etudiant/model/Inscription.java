package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "inscription",
        uniqueConstraints = @UniqueConstraint(columnNames = {"etudiant_id", "filiere_id", "niveau_id", "annee_academique_id"}))
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Inscription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "filiere_id", nullable = false)
    private Filiere filiere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "niveau_id", nullable = false)
    private Niveau niveau;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "annee_academique_id", nullable = false)
    private AnneeAcademique anneeAcademique;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "date_inscription")
    private LocalDate dateInscription;

    @Enumerated(EnumType.STRING)
    private StatutInscription statut = StatutInscription.INSCRIT;

    @OneToMany(mappedBy = "inscription", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Note> notes = new ArrayList<>();

    @OneToMany(mappedBy = "inscription", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Paiement> paiements = new ArrayList<>();

    @OneToMany(mappedBy = "inscription", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Presence> presences = new ArrayList<>();

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (dateInscription == null) {
            dateInscription = LocalDate.now();
        }
    }

    public enum StatutInscription {
        INSCRIT, REINSCRIT, SUSPENDU, DIPLOME
    }
}