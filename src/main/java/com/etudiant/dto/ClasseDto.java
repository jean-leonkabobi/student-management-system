package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClasseDto {

    private Long id;

    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    @NotBlank(message = "Le niveau est obligatoire")
    private String niveau;

    @NotNull(message = "La filière est obligatoire")
    private Long filiereId;

    private String filiereNom; // pour l'affichage
}