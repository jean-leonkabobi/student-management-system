package com.etudiant.repository;

import com.etudiant.model.Paiement;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.model.Paiement.TypeFrais;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaiementRepository extends JpaRepository<Paiement, Long> {

    List<Paiement> findByInscriptionId(Long inscriptionId);

    List<Paiement> findByStatut(StatutPaiement statut);

    List<Paiement> findByTypeFrais(TypeFrais typeFrais);
}