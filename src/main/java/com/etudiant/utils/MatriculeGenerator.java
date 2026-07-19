package com.etudiant.utils;

import com.etudiant.repository.EtudiantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Component
@RequiredArgsConstructor
public class MatriculeGenerator {

    private final EtudiantRepository etudiantRepository;

    /**
     * Génère un matricule unique au format : ETU-YYYY-XXXX
     * Où YYYY est l'année en cours et XXXX est un nombre séquentiel
     */
    public String generate() {
        String year = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy"));

        // Compter les étudiants existants pour générer un numéro séquentiel
        long count = etudiantRepository.count() + 1;
        String sequence = String.format("%04d", count);

        return "ETU-" + year + "-" + sequence;
    }
}