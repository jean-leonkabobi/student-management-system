package com.etudiant.service;

import com.etudiant.model.Enseignant;
import java.util.List;
import java.util.Optional;

public interface EnseignantService {
    Enseignant save(Enseignant enseignant);
    Optional<Enseignant> findById(Long id);
    Optional<Enseignant> findByMatricule(String matricule);
    List<Enseignant> findAll();
    List<Enseignant> search(String keyword);
    List<Enseignant> findByDepartement(String departement);
    Enseignant update(Long id, Enseignant enseignant);
    void deleteById(Long id);
    long count();
    String generateMatricule();
}