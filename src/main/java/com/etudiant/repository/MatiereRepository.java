package com.etudiant.repository;

import com.etudiant.model.Filiere;
import com.etudiant.model.Matiere;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MatiereRepository extends JpaRepository<Matiere, Long> {

    Optional<Matiere> findByCode(String code);

    List<Matiere> findByFiliere(Filiere filiere);

    List<Matiere> findByFiliereId(Long filiereId);

    List<Matiere> findByEnseignantId(Long enseignantId);

    boolean existsByCode(String code);
}