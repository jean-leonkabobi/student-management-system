package com.etudiant.repository;

import com.etudiant.model.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {

    Optional<Etudiant> findByMatricule(String matricule);

    Optional<Etudiant> findByEmail(String email);

    List<Etudiant> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    boolean existsByMatricule(String matricule);
}