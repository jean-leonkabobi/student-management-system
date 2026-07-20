package com.etudiant.service;

import com.etudiant.model.Enseignant;

import java.util.List;
import java.util.Optional;

public interface EnseignantService {

    List<Enseignant> findAll();

    Optional<Enseignant> findById(Long id);

    Optional<Enseignant> findByMatricule(String matricule);

    Optional<Enseignant> findByEmail(String email);

    List<Enseignant> search(String keyword);  // ⬅️ NOUVEAU

    Enseignant save(Enseignant enseignant);

    Enseignant update(Enseignant enseignant);

    void deleteById(Long id);

    boolean existsByMatricule(String matricule);  // ⬅️ NOUVEAU

    long count();
}