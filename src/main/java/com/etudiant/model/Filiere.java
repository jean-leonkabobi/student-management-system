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
@Table(name = "filiere")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Filiere {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 10)
    @NotBlank(message = "Le code est obligatoire")
    @Size(max = 10, message = "Le code ne peut pas dépasser 10 caractères")
    private String code;

    @Column(nullable = false, length = 100)
    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 100, message = "Le nom ne peut pas dépasser 100 caractères")
    private String nom;

    private String description;
    private String departement;

    @OneToMany(mappedBy = "filiere")
    private List<Inscription> inscriptions = new ArrayList<>();

    @OneToMany(mappedBy = "filiere")
    private List<Matiere> matieres = new ArrayList<>();
}