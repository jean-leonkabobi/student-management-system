package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MatiereDto {

    private Long id;

    @NotBlank(message = "Le code est obligatoire")
    private String code;

    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    @Min(value = 1, message = "Le coefficient minimum est 1")
    @Max(value = 10, message = "Le coefficient maximum est 10")
    private Integer coefficient;

    @Min(value = 1, message = "Le nombre d'heures minimum est 1")
    private Integer nombreHeures;

    private Long enseignantId;
    private String enseignantNom;
    private Long filiereId;
    private String filiereNom;
}