package com.etudiant.service;

import com.etudiant.model.Utilisateur;
import java.util.List;
import java.util.Optional;

public interface UtilisateurService {
    Utilisateur save(Utilisateur utilisateur);
    Optional<Utilisateur> findById(Long id);
    Optional<Utilisateur> findByUsername(String username);
    List<Utilisateur> findAll();
    Utilisateur update(Long id, Utilisateur utilisateur);
    void deleteById(Long id);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    long count();
}