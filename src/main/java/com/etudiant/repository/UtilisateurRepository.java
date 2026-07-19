package com.etudiant.repository;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {

    Optional<Utilisateur> findByUsername(String username);

    Optional<Utilisateur> findByEmail(String email);

    List<Utilisateur> findByRole(Role role);

    List<Utilisateur> findByEstActif(Boolean estActif);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);
}