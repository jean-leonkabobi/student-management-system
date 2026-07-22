package com.etudiant.service;

import com.etudiant.model.Filiere;
import java.util.List;
import java.util.Optional;

public interface FiliereService {
    Filiere save(Filiere filiere);
    Optional<Filiere> findById(Long id);
    Optional<Filiere> findByCode(String code);
    List<Filiere> findAll();
    Filiere update(Long id, Filiere filiere);
    void deleteById(Long id);
    boolean existsByCode(String code);
    long count();
}