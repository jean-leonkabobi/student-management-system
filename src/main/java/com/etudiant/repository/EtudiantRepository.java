package com.etudiant.repository;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {

    // Recherche par matricule
    Optional<Etudiant> findByMatricule(String matricule);

    // Recherche par email
    Optional<Etudiant> findByEmail(String email);

    // Recherche par nom ou prénom
    List<Etudiant> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    // Recherche par statut
    List<Etudiant> findByStatut(StatutEtudiant statut);

    // Recherche par filière (via les inscriptions)
    @Query("SELECT DISTINCT e FROM Etudiant e JOIN e.inscriptions i WHERE i.filiere.id = :filiereId")
    List<Etudiant> findEtudiantsByFiliereId(@Param("filiereId") Long filiereId);

    // Vérifier si un matricule existe
    boolean existsByMatricule(String matricule);

    // Compter les étudiants par statut
    long countByStatut(StatutEtudiant statut);

    // Recherche multicritère
    @Query("SELECT e FROM Etudiant e WHERE " +
            "(:matricule IS NULL OR e.matricule LIKE CONCAT('%', :matricule, '%')) AND " +
            "(:nom IS NULL OR e.nom LIKE CONCAT('%', :nom, '%')) AND " +
            "(:prenom IS NULL OR e.prenom LIKE CONCAT('%', :prenom, '%')) AND " +
            "(:email IS NULL OR e.email LIKE CONCAT('%', :email, '%')) AND " +
            "(:statut IS NULL OR e.statut = :statut)")
    List<Etudiant> rechercheMultiCritere(@Param("matricule") String matricule,
                                         @Param("nom") String nom,
                                         @Param("prenom") String prenom,
                                         @Param("email") String email,
                                         @Param("statut") StatutEtudiant statut);
}