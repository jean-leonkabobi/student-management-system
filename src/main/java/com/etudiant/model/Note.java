package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notes")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double valeur;

    @Column(name = "type_examen", nullable = false, length = 30)
    private String typeExamen; // DS, EXAMEN, TP, RATTRAPAGE

    @Column(length = 10)
    private String semestre; // S1, S2, S3...

    @Column(name = "annee_universitaire", length = 9)
    private String anneeUniversitaire; // 2025-2026

    @Column(name = "date_saisie")
    private LocalDateTime dateSaisie;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "matiere_id", nullable = false)
    private Matiere matiere;

    @PrePersist
    protected void onCreate() {
        this.dateSaisie = LocalDateTime.now();
    }
}