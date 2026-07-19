package com.etudiant.service.impl;

import com.etudiant.model.Inscription;
import com.etudiant.model.Inscription.StatutInscription;
import com.etudiant.repository.InscriptionRepository;
import com.etudiant.service.InscriptionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class InscriptionServiceImpl implements InscriptionService {

    private final InscriptionRepository inscriptionRepository;

    @Override
    public List<Inscription> findAll() {
        return inscriptionRepository.findAll();
    }

    @Override
    public Optional<Inscription> findById(Long id) {
        return inscriptionRepository.findById(id);
    }

    @Override
    public List<Inscription> findByEtudiantId(Long etudiantId) {
        return inscriptionRepository.findByEtudiantId(etudiantId);
    }

    @Override
    public List<Inscription> findByFiliereId(Long filiereId) {
        return inscriptionRepository.findByFiliereId(filiereId);
    }

    @Override
    public List<Inscription> findByNiveauId(Long niveauId) {
        return inscriptionRepository.findByNiveauId(niveauId);
    }

    @Override
    public List<Inscription> findByAnneeAcademiqueId(Long anneeAcademiqueId) {
        return inscriptionRepository.findByAnneeAcademiqueId(anneeAcademiqueId);
    }

    @Override
    public List<Inscription> findByStatut(StatutInscription statut) {
        return inscriptionRepository.findByStatut(statut);
    }

    @Override
    public Optional<Inscription> findInscriptionActiveByEtudiant(Long etudiantId) {
        return inscriptionRepository.findInscriptionActiveByEtudiant(etudiantId);
    }

    @Override
    public long countInscritsByFiliereActive(Long filiereId) {
        return inscriptionRepository.countInscritsByFiliereActive(filiereId);
    }

    @Override
    public Inscription save(Inscription inscription) {
        log.info("Sauvegarde d'une nouvelle inscription");
        if (inscription.getDateInscription() == null) {
            inscription.setDateInscription(LocalDate.now());
        }
        return inscriptionRepository.save(inscription);
    }

    @Override
    public Inscription update(Inscription inscription) {
        log.info("Mise à jour de l'inscription ID: {}", inscription.getId());
        return inscriptionRepository.save(inscription);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de l'inscription ID: {}", id);
        inscriptionRepository.deleteById(id);
    }

    @Override
    public boolean isEtudiantInscrit(Long etudiantId, Long anneeAcademiqueId) {
        return inscriptionRepository.findByEtudiantId(etudiantId)
                .stream()
                .anyMatch(i -> i.getAnneeAcademique().getId().equals(anneeAcademiqueId));
    }
}