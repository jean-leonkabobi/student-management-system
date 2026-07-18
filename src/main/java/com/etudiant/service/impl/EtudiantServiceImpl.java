package com.etudiant.service.impl;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;
import com.etudiant.repository.EtudiantRepository;
import com.etudiant.service.EtudiantService;
import com.etudiant.utils.MatriculeGenerator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class EtudiantServiceImpl implements EtudiantService {

    private final EtudiantRepository etudiantRepository;
    private final MatriculeGenerator matriculeGenerator;

    @Override
    public List<Etudiant> findAll() {
        log.debug("Récupération de tous les étudiants");
        return etudiantRepository.findAll();
    }

    @Override
    public Optional<Etudiant> findById(Long id) {
        log.debug("Recherche de l'étudiant avec l'ID: {}", id);
        return etudiantRepository.findById(id);
    }

    @Override
    public Optional<Etudiant> findByMatricule(String matricule) {
        log.debug("Recherche de l'étudiant avec le matricule: {}", matricule);
        return etudiantRepository.findByMatricule(matricule);
    }

    @Override
    public Optional<Etudiant> findByEmail(String email) {
        log.debug("Recherche de l'étudiant avec l'email: {}", email);
        return etudiantRepository.findByEmail(email);
    }

    @Override
    public Etudiant save(Etudiant etudiant) {
        log.info("Sauvegarde d'un nouvel étudiant: {}", etudiant.getNomComplet());

        // Générer un matricule si ce n'est pas déjà fait
        if (etudiant.getMatricule() == null || etudiant.getMatricule().isEmpty()) {
            etudiant.setMatricule(matriculeGenerator.generate());
        }

        // Vérifier que le matricule est unique
        if (etudiantRepository.existsByMatricule(etudiant.getMatricule())) {
            throw new IllegalArgumentException("Le matricule " + etudiant.getMatricule() + " existe déjà");
        }

        return etudiantRepository.save(etudiant);
    }

    @Override
    public Etudiant update(Etudiant etudiant) {
        log.info("Mise à jour de l'étudiant: {}", etudiant.getNomComplet());

        // Vérifier que l'étudiant existe
        if (!etudiantRepository.existsById(etudiant.getId())) {
            throw new IllegalArgumentException("L'étudiant avec l'ID " + etudiant.getId() + " n'existe pas");
        }

        return etudiantRepository.save(etudiant);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de l'étudiant avec l'ID: {}", id);

        // Vérifier que l'étudiant existe
        if (!etudiantRepository.existsById(id)) {
            throw new IllegalArgumentException("L'étudiant avec l'ID " + id + " n'existe pas");
        }

        etudiantRepository.deleteById(id);
    }

    @Override
    public void delete(Etudiant etudiant) {
        log.info("Suppression de l'étudiant: {}", etudiant.getNomComplet());
        etudiantRepository.delete(etudiant);
    }

    @Override
    public List<Etudiant> search(String keyword) {
        log.debug("Recherche d'étudiants avec le mot-clé: {}", keyword);
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        return etudiantRepository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(
                keyword.trim(), keyword.trim());
    }

    @Override
    public List<Etudiant> findByStatut(StatutEtudiant statut) {
        log.debug("Recherche des étudiants avec le statut: {}", statut);
        return etudiantRepository.findByStatut(statut);
    }

    @Override
    public List<Etudiant> findEtudiantsByFiliere(Long filiereId) {
        log.debug("Recherche des étudiants de la filière ID: {}", filiereId);
        return etudiantRepository.findEtudiantsByFiliereId(filiereId);
    }

    @Override
    public List<Etudiant> rechercheMultiCritere(String matricule, String nom, String prenom,
                                                String email, StatutEtudiant statut) {
        log.debug("Recherche multi-critère");
        return etudiantRepository.rechercheMultiCritere(matricule, nom, prenom, email, statut);
    }

    @Override
    public long countByStatut(StatutEtudiant statut) {
        return etudiantRepository.countByStatut(statut);
    }

    @Override
    public long countTotal() {
        return etudiantRepository.count();
    }

    @Override
    public String generateMatricule() {
        return matriculeGenerator.generate();
    }

    @Override
    public boolean matriculeExists(String matricule) {
        return etudiantRepository.existsByMatricule(matricule);
    }
}