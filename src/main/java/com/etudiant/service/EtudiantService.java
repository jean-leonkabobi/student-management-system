package com.etudiant.service;

import com.etudiant.model.Etudiant;
import java.util.List;
import java.util.Optional;

public interface EtudiantService {
    Etudiant save(Etudiant etudiant);
    Optional<Etudiant> findById(Long id);
    Optional<Etudiant> findByMatricule(String matricule);
    List<Etudiant> findAll();
    List<Etudiant> search(String keyword);
    Etudiant update(Long id, Etudiant etudiant);
    void deleteById(Long id);
    boolean existsByMatricule(String matricule);
    long count();
    String generateMatricule();
}