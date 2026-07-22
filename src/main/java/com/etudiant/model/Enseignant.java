package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "enseignants")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Enseignant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 20)
    private String matricule;

    @Column(nullable = false, length = 50)
    private String nom;

    @Column(nullable = false, length = 50)
    private String prenom;

    @Column(unique = true, length = 100)
    private String email;

    @Column(length = 20)
    private String telephone;

    @Column(length = 100)
    private String specialite;

    @Column(length = 100)
    private String departement;

    @Column(length = 50)
    private String grade;

    @OneToMany(mappedBy = "enseignant")
    private List<Matiere> matieres = new ArrayList<>();
}