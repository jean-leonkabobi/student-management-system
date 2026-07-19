package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name = "tuteur")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Tuteur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @Column(nullable = false, length = 50)
    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 50, message = "Le nom ne peut pas dépasser 50 caractères")
    private String nom;

    @Column(nullable = false, length = 50)
    @NotBlank(message = "Le prénom est obligatoire")
    @Size(max = 50, message = "Le prénom ne peut pas dépasser 50 caractères")
    private String prenom;

    @Column(length = 20)
    private String telephone;

    @Email(message = "L'email doit être valide")
    @Column(length = 100)
    private String email;

    @Column(length = 100)
    private String profession;

    @Column(columnDefinition = "TEXT")
    private String adresse;

    @Column(name = "lien_parente", length = 30)
    private String lienParente;

    @Column(name = "est_urgence")
    private Boolean estUrgence = false;
}