package com.etudiant.service;

import com.etudiant.model.Filiere;
import java.util.List;
import java.util.Optional;

public interface FiliereService {
    List<Filiere> findAll();
    Optional<Filiere> findById(Long id);
    Optional<Filiere> findByCode(String code);
    Filiere save(Filiere filiere);
    void deleteById(Long id);
    boolean existsByCode(String code);
}