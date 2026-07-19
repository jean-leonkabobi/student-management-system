package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "annee_academique")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnneeAcademique {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 20)
    @NotBlank(message = "Le libellé est obligatoire")
    @Size(max = 20, message = "Le libellé ne peut pas dépasser 20 caractères")
    private String libelle;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "est_active")
    private Boolean estActive = false;

    @OneToMany(mappedBy = "anneeAcademique", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Inscription> inscriptions = new ArrayList<>();
}