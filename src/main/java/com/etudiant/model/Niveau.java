package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "niveau")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Niveau {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 10)
    @NotBlank(message = "Le code est obligatoire")
    @Size(max = 10, message = "Le code ne peut pas dépasser 10 caractères")
    private String code;

    @Column(nullable = false, length = 50)
    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 50, message = "Le nom ne peut pas dépasser 50 caractères")
    private String nom;

    private Integer ordre;

    @OneToMany(mappedBy = "niveau", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Inscription> inscriptions = new ArrayList<>();

    @OneToMany(mappedBy = "niveau", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Matiere> matieres = new ArrayList<>();
}