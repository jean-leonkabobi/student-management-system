package com.etudiant.service.impl;

import com.etudiant.model.AnneeAcademique;
import com.etudiant.repository.AnneeAcademiqueRepository;
import com.etudiant.service.AnneeAcademiqueService;
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
public class AnneeAcademiqueServiceImpl implements AnneeAcademiqueService {

    private final AnneeAcademiqueRepository anneeAcademiqueRepository;

    @Override
    public List<AnneeAcademique> findAll() {
        return anneeAcademiqueRepository.findAll();
    }

    @Override
    public Optional<AnneeAcademique> findById(Long id) {
        return anneeAcademiqueRepository.findById(id);
    }

    @Override
    public Optional<AnneeAcademique> findActiveYear() {
        // Récupérer la liste des années actives et prendre la première
        List<AnneeAcademique> activeYears = anneeAcademiqueRepository.findByEstActiveTrue();
        return activeYears.isEmpty() ? Optional.empty() : Optional.of(activeYears.get(0));
    }

    @Override
    public List<AnneeAcademique> findActiveYears() {
        return anneeAcademiqueRepository.findByEstActiveTrue();
    }

    @Override
    public AnneeAcademique save(AnneeAcademique anneeAcademique) {
        log.info("Sauvegarde d'une année académique: {}", anneeAcademique.getLibelle());

        // Si cette année est active, désactiver les autres
        if (anneeAcademique.getEstActive()) {
            anneeAcademiqueRepository.findByEstActiveTrue()
                    .forEach(a -> {
                        a.setEstActive(false);
                        anneeAcademiqueRepository.save(a);
                    });
        }

        return anneeAcademiqueRepository.save(anneeAcademique);
    }

    @Override
    public AnneeAcademique update(AnneeAcademique anneeAcademique) {
        log.info("Mise à jour de l'année académique ID: {}", anneeAcademique.getId());

        // Si cette année est active, désactiver les autres
        if (anneeAcademique.getEstActive()) {
            anneeAcademiqueRepository.findByEstActiveTrue()
                    .forEach(a -> {
                        if (!a.getId().equals(anneeAcademique.getId())) {
                            a.setEstActive(false);
                            anneeAcademiqueRepository.save(a);
                        }
                    });
        }

        return anneeAcademiqueRepository.save(anneeAcademique);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de l'année académique ID: {}", id);
        anneeAcademiqueRepository.deleteById(id);
    }
}