package com.etudiant.repository;

import com.etudiant.model.Inscription;
import com.etudiant.model.Inscription.StatutInscription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InscriptionRepository extends JpaRepository<Inscription, Long> {

    List<Inscription> findByEtudiantId(Long etudiantId);

    List<Inscription> findByFiliereId(Long filiereId);

    List<Inscription> findByNiveauId(Long niveauId);

    List<Inscription> findByAnneeAcademiqueId(Long anneeAcademiqueId);

    List<Inscription> findByStatut(StatutInscription statut);

    @Query("SELECT i FROM Inscription i WHERE i.etudiant.id = :etudiantId AND i.anneeAcademique.estActive = true")
    Optional<Inscription> findInscriptionActiveByEtudiant(@Param("etudiantId") Long etudiantId);

    @Query("SELECT COUNT(i) FROM Inscription i WHERE i.filiere.id = :filiereId AND i.anneeAcademique.estActive = true")
    long countInscritsByFiliereActive(@Param("filiereId") Long filiereId);
}