package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name = "enseignant")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Enseignant {

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

    @Column(length = 20)
    private String telephone;

    @Email(message = "L'email doit être valide")
    @Column(unique = true, length = 100)
    private String email;

    @Column(length = 50)
    private String grade;

    @Column(length = 100)
    private String specialite;

    @Column(length = 100)
    private String departement;

    private String photo;

    public String getNomComplet() {
        return (postnom != null && !postnom.isEmpty() ? postnom + " " : "") + nom + " " + prenom;
    }
}