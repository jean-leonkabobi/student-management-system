package com.etudiant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FiliereDto {

    private Long id;

    @NotBlank(message = "Le code est obligatoire")
    @Size(min = 2, max = 10, message = "2 à 10 caractères")
    private String code;

    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    private String description;
}