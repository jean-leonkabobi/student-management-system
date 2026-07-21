package com.etudiant.service;

import com.etudiant.model.EmploiDuTemps;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface EmploiDuTempsService {

    List<EmploiDuTemps> findAll();

    Optional<EmploiDuTemps> findById(Long id);

    List<EmploiDuTemps> findByEnseignantId(Long enseignantId);

    Map<String, List<EmploiDuTemps>> getEmploiParJour(Long enseignantId);

    EmploiDuTemps save(EmploiDuTemps emploiDuTemps);

    EmploiDuTemps update(EmploiDuTemps emploiDuTemps);

    void deleteById(Long id);
}