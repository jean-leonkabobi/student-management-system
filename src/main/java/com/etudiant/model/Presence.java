package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "presence")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Presence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inscription_id", nullable = false)
    private Inscription inscription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "matiere_id", nullable = false)
    private Matiere matiere;

    private LocalDate date;

    @Column(name = "heure_debut")
    private LocalTime heureDebut;

    @Column(name = "heure_fin")
    private LocalTime heureFin;

    @Enumerated(EnumType.STRING)
    private StatutPresence statut = StatutPresence.PRESENT;

    @Column(columnDefinition = "TEXT")
    private String justificatif;

    public enum StatutPresence {
        PRESENT, ABSENT, RETARD, JUSTIFIE
    }
}