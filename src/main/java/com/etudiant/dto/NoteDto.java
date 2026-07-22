package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoteDto {

    private Long id;

    @NotNull(message = "La note est obligatoire")
    @Min(value = 0, message = "Minimum 0")
    @Max(value = 20, message = "Maximum 20")
    private Double valeur;

    @NotBlank(message = "Le type d'examen est obligatoire")
    private String typeExamen;

    private String semestre;
    private String anneeUniversitaire;

    @NotNull(message = "L'étudiant est obligatoire")
    private Long etudiantId;

    private String etudiantNom;
    private String etudiantPrenom;

    @NotNull(message = "La matière est obligatoire")
    private Long matiereId;

    private String matiereNom;
}