package com.etudiant.service.impl;

import com.etudiant.model.EmploiDuTemps;
import com.etudiant.repository.EmploiDuTempsRepository;
import com.etudiant.service.EmploiDuTempsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class EmploiDuTempsServiceImpl implements EmploiDuTempsService {

    private final EmploiDuTempsRepository emploiDuTempsRepository;

    @Override
    public List<EmploiDuTemps> findAll() {
        return emploiDuTempsRepository.findAll();
    }

    @Override
    public Optional<EmploiDuTemps> findById(Long id) {
        return emploiDuTempsRepository.findById(id);
    }

    @Override
    public List<EmploiDuTemps> findByEnseignantId(Long enseignantId) {
        return emploiDuTempsRepository.findByEnseignantIdOrderByJourAscHeureDebutAsc(enseignantId);
    }

    @Override
    public Map<String, List<EmploiDuTemps>> getEmploiParJour(Long enseignantId) {
        List<EmploiDuTemps> emplois = findByEnseignantId(enseignantId);

        Map<String, List<EmploiDuTemps>> result = new LinkedHashMap<>();

        String[] jours = {"LUNDI", "MARDI", "MERCREDI", "JEUDI", "VENDREDI", "SAMEDI"};
        for (String jour : jours) {
            result.put(jour, emplois.stream()
                    .filter(e -> e.getJour().equals(jour))
                    .collect(java.util.stream.Collectors.toList()));
        }

        return result;
    }

    @Override
    public EmploiDuTemps save(EmploiDuTemps emploiDuTemps) {
        log.info("Sauvegarde d'un emploi du temps pour l'enseignant ID: {}",
                emploiDuTemps.getEnseignant().getId());
        return emploiDuTempsRepository.save(emploiDuTemps);
    }

    @Override
    public EmploiDuTemps update(EmploiDuTemps emploiDuTemps) {
        log.info("Mise à jour d'un emploi du temps ID: {}", emploiDuTemps.getId());
        return emploiDuTempsRepository.save(emploiDuTemps);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression d'un emploi du temps ID: {}", id);
        emploiDuTempsRepository.deleteById(id);
    }
}