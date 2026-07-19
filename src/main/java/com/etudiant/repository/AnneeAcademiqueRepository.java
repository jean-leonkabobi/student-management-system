package com.etudiant.repository;

import com.etudiant.model.AnneeAcademique;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AnneeAcademiqueRepository extends JpaRepository<AnneeAcademique, Long> {

    // Retourne une List car il peut y avoir plusieurs années actives
    List<AnneeAcademique> findByEstActiveTrue();

}