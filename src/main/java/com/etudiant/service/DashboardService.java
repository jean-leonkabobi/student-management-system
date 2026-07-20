package com.etudiant.service;

import java.math.BigDecimal;
import java.util.Map;

public interface DashboardService {

    long getTotalEtudiants();

    long getTotalEnseignants();

    long getTotalFilieres();

    long getTotalInscriptions();

    long getTotalMatieres();

    long getTotalPaiements();

    BigDecimal getTotalPaiementsMontant();

    Map<String, Long> getEtudiantsParFiliere();

    Map<String, Long> getEtudiantsParNiveau();

    Map<String, Long> getEtudiantsParStatut();

    Map<String, Long> getInscriptionsParAnnee();

    Map<String, Long> getPaiementsParStatut();

    BigDecimal getMoyenneNotesGenerale();
}