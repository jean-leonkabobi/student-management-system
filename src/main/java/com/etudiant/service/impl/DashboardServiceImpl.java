package com.etudiant.service.impl;

import com.etudiant.model.Etudiant.StatutEtudiant;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.repository.*;
import com.etudiant.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final EtudiantRepository etudiantRepository;
    private final EnseignantRepository enseignantRepository;
    private final FiliereRepository filiereRepository;
    private final InscriptionRepository inscriptionRepository;
    private final MatiereRepository matiereRepository;
    private final PaiementRepository paiementRepository;
    private final NoteRepository noteRepository;

    @Override
    public long getTotalEtudiants() {
        return etudiantRepository.count();
    }

    @Override
    public long getTotalEnseignants() {
        return enseignantRepository.count();
    }

    @Override
    public long getTotalFilieres() {
        return filiereRepository.count();
    }

    @Override
    public long getTotalInscriptions() {
        return inscriptionRepository.count();
    }

    @Override
    public long getTotalMatieres() {
        return matiereRepository.count();
    }

    @Override
    public long getTotalPaiements() {
        return paiementRepository.count();
    }

    @Override
    public BigDecimal getTotalPaiementsMontant() {
        return paiementRepository.findAll().stream()
                .map(p -> p.getMontantPaye())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public Map<String, Long> getEtudiantsParFiliere() {
        Map<String, Long> result = new HashMap<>();
        // Requête JPQL pour compter les étudiants par filière
        // À implémenter avec une requête personnalisée
        return result;
    }

    @Override
    public Map<String, Long> getEtudiantsParNiveau() {
        Map<String, Long> result = new HashMap<>();
        // À implémenter
        return result;
    }

    @Override
    public Map<String, Long> getEtudiantsParStatut() {
        Map<String, Long> result = new HashMap<>();
        for (StatutEtudiant statut : StatutEtudiant.values()) {
            long count = etudiantRepository.countByStatut(statut);
            result.put(statut.name(), count);
        }
        return result;
    }

    @Override
    public Map<String, Long> getInscriptionsParAnnee() {
        Map<String, Long> result = new HashMap<>();
        // À implémenter
        return result;
    }

    @Override
    public Map<String, Long> getPaiementsParStatut() {
        Map<String, Long> result = new HashMap<>();
        for (StatutPaiement statut : StatutPaiement.values()) {
            long count = paiementRepository.findByStatut(statut).size();
            result.put(statut.name(), count);
        }
        return result;
    }

    @Override
    public BigDecimal getMoyenneNotesGenerale() {
        // À implémenter
        return BigDecimal.ZERO;
    }
}