package com.etudiant.service;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;

import java.util.List;
import java.util.Optional;

public interface EtudiantService {

    List<Etudiant> findAll();

    Optional<Etudiant> findById(Long id);

    Optional<Etudiant> findByMatricule(String matricule);

    Optional<Etudiant> findByEmail(String email);

    Etudiant save(Etudiant etudiant);

    Etudiant update(Etudiant etudiant);

    void deleteById(Long id);

    void delete(Etudiant etudiant);

    List<Etudiant> search(String keyword);

    List<Etudiant> findByStatut(StatutEtudiant statut);

    List<Etudiant> findEtudiantsByFiliere(Long filiereId);

    List<Etudiant> rechercheMultiCritere(String matricule, String nom, String prenom,
                                         String email, StatutEtudiant statut);

    long countByStatut(StatutEtudiant statut);

    long countTotal();

    String generateMatricule();

    boolean matriculeExists(String matricule);
}