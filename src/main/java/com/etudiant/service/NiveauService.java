package com.etudiant.service;

import com.etudiant.model.Niveau;
import java.util.List;
import java.util.Optional;

public interface NiveauService {
    List<Niveau> findAll();
    Optional<Niveau> findById(Long id);
    Optional<Niveau> findByCode(String code);
    Niveau save(Niveau niveau);
    void deleteById(Long id);
}