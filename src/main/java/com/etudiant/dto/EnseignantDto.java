package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnseignantDto {

    private Long id;
    private String matricule;

    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    @NotBlank(message = "Le prénom est obligatoire")
    private String prenom;

    @Email(message = "Email invalide")
    private String email;

    @Pattern(regexp = "^[0-9]{9,15}$", message = "Téléphone invalide")
    private String telephone;

    private String specialite;
    private String departement;
    private String grade;
}