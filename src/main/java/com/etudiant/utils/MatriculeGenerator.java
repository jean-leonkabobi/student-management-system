package com.etudiant.utils;

import java.time.Year;

public class MatriculeGenerator {

    public static String generateEtudiantMatricule(long count) {
        String year = String.valueOf(Year.now().getValue());
        return "ETU" + year + String.format("%04d", count + 1);
    }

    public static String generateEnseignantMatricule(long count) {
        String year = String.valueOf(Year.now().getValue());
        return "ENS" + year + String.format("%04d", count + 1);
    }
}