package com.etudiant.repository;

import com.etudiant.model.Matiere;
import com.etudiant.model.Matiere.Semestre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MatiereRepository extends JpaRepository<Matiere, Long> {

    Optional<Matiere> findByCode(String code);

    List<Matiere> findByFiliereId(Long filiereId);

    List<Matiere> findByNiveauId(Long niveauId);

    List<Matiere> findByFiliereIdAndNiveauId(Long filiereId, Long niveauId);

    List<Matiere> findBySemestre(Semestre semestre);

    boolean existsByCode(String code);
}