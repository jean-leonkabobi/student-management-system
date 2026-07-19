package com.etudiant.service;

import com.etudiant.model.Matiere;
import com.etudiant.model.Matiere.Semestre;

import java.util.List;
import java.util.Optional;

public interface MatiereService {

    List<Matiere> findAll();

    Optional<Matiere> findById(Long id);

    Optional<Matiere> findByCode(String code);

    List<Matiere> findByFiliereId(Long filiereId);

    List<Matiere> findByNiveauId(Long niveauId);

    List<Matiere> findByFiliereAndNiveau(Long filiereId, Long niveauId);

    List<Matiere> findBySemestre(Semestre semestre);

    Matiere save(Matiere matiere);

    Matiere update(Matiere matiere);

    void deleteById(Long id);

    boolean existsByCode(String code);
}