package com.etudiant.service;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;

import java.util.List;
import java.util.Optional;

public interface UtilisateurService {

    List<Utilisateur> findAll();

    Optional<Utilisateur> findById(Long id);

    Optional<Utilisateur> findByUsername(String username);

    Optional<Utilisateur> findByEmail(String email);

    List<Utilisateur> findByRole(Role role);

    List<Utilisateur> findByEstActif(Boolean estActif);

    Utilisateur save(Utilisateur utilisateur);

    Utilisateur update(Utilisateur utilisateur);

    void deleteById(Long id);

    void activerUtilisateur(Long id);

    void desactiverUtilisateur(Long id);

    boolean authenticate(String username, String password);

    String hashPassword(String password);
}