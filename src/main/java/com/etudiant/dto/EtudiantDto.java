package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EtudiantDto {

    private Long id;
    private String matricule;

    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    @NotBlank(message = "Le prénom est obligatoire")
    private String prenom;

    @Past(message = "La date de naissance doit être dans le passé")
    private LocalDate dateNaissance;

    @Email(message = "Email invalide")
    private String email;

    @Pattern(regexp = "^[0-9]{9,15}$", message = "Téléphone invalide")
    private String telephone;

    private String adresse;
    private String photo;
}