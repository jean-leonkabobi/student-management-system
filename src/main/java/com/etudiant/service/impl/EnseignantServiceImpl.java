package com.etudiant.service.impl;

import com.etudiant.model.Enseignant;
import com.etudiant.repository.EnseignantRepository;
import com.etudiant.service.EnseignantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class EnseignantServiceImpl implements EnseignantService {

    private final EnseignantRepository enseignantRepository;

    @Override
    public List<Enseignant> findAll() {
        return enseignantRepository.findAll();
    }

    @Override
    public Optional<Enseignant> findById(Long id) {
        return enseignantRepository.findById(id);
    }

    @Override
    public Optional<Enseignant> findByMatricule(String matricule) {
        return enseignantRepository.findByMatricule(matricule);
    }

    @Override
    public Optional<Enseignant> findByEmail(String email) {
        return enseignantRepository.findByEmail(email);
    }

    @Override
    public List<Enseignant> search(String keyword) {
        log.debug("Recherche d'enseignants avec le mot-clé: {}", keyword);
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        return enseignantRepository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(
                keyword.trim(), keyword.trim());
    }

    @Override
    public Enseignant save(Enseignant enseignant) {
        log.info("Sauvegarde de l'enseignant: {}", enseignant.getNomComplet());

        // Générer un matricule si vide
        if (enseignant.getMatricule() == null || enseignant.getMatricule().isEmpty()) {
            enseignant.setMatricule(generateMatricule());
        }

        return enseignantRepository.save(enseignant);
    }

    @Override
    public Enseignant update(Enseignant enseignant) {
        log.info("Mise à jour de l'enseignant ID: {}", enseignant.getId());
        return enseignantRepository.save(enseignant);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de l'enseignant ID: {}", id);
        enseignantRepository.deleteById(id);
    }

    @Override
    public boolean existsByMatricule(String matricule) {
        return enseignantRepository.existsByMatricule(matricule);
    }

    @Override
    public long count() {
        return enseignantRepository.count();
    }

    private String generateMatricule() {
        long count = enseignantRepository.count() + 1;
        return "ENS-" + String.format("%04d", count);
    }
}