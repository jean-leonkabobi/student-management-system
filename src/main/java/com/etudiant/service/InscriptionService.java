package com.etudiant.service;

import com.etudiant.model.Inscription;
import com.etudiant.model.Inscription.StatutInscription;

import java.util.List;
import java.util.Optional;

public interface InscriptionService {

    List<Inscription> findAll();

    Optional<Inscription> findById(Long id);

    List<Inscription> findByEtudiantId(Long etudiantId);

    List<Inscription> findByFiliereId(Long filiereId);

    List<Inscription> findByNiveauId(Long niveauId);

    List<Inscription> findByAnneeAcademiqueId(Long anneeAcademiqueId);

    List<Inscription> findByStatut(StatutInscription statut);

    Optional<Inscription> findInscriptionActiveByEtudiant(Long etudiantId);

    long countInscritsByFiliereActive(Long filiereId);

    Inscription save(Inscription inscription);

    Inscription update(Inscription inscription);

    void deleteById(Long id);

    boolean isEtudiantInscrit(Long etudiantId, Long anneeAcademiqueId);
}