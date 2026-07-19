package com.etudiant.service;

import com.etudiant.model.AnneeAcademique;

import java.util.List;
import java.util.Optional;

public interface AnneeAcademiqueService {

    List<AnneeAcademique> findAll();

    Optional<AnneeAcademique> findById(Long id);

    Optional<AnneeAcademique> findActiveYear();

    List<AnneeAcademique> findActiveYears();

    AnneeAcademique save(AnneeAcademique anneeAcademique);

    AnneeAcademique update(AnneeAcademique anneeAcademique);

    void deleteById(Long id);
}