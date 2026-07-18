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
    private String libelle; // 2024-2025

    private LocalDate dateDebut;
    private LocalDate dateFin;

    private Boolean estActive = false;

    @OneToMany(mappedBy = "anneeAcademique")
    private List<Inscription> inscriptions = new ArrayList<>();
}