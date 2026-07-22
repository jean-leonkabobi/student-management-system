package com.etudiant.service;

import com.etudiant.model.Matiere;
import java.util.List;
import java.util.Optional;

public interface MatiereService {
    Matiere save(Matiere matiere);
    Optional<Matiere> findById(Long id);
    Optional<Matiere> findByCode(String code);
    List<Matiere> findAll();
    List<Matiere> findByFiliereId(Long filiereId);
    List<Matiere> findByEnseignantId(Long enseignantId);
    Matiere update(Long id, Matiere matiere);
    void deleteById(Long id);
    boolean existsByCode(String code);
    long count();
}