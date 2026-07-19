package com.etudiant.service;

import com.etudiant.model.Paiement;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.model.Paiement.TypeFrais;
import com.etudiant.model.RecuPaiement;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PaiementService {

    List<Paiement> findAll();

    Optional<Paiement> findById(Long id);

    List<Paiement> findByInscriptionId(Long inscriptionId);

    List<Paiement> findByStatut(StatutPaiement statut);

    List<Paiement> findByTypeFrais(TypeFrais typeFrais);

    BigDecimal getTotalPayeByInscription(Long inscriptionId);

    BigDecimal getTotalRestantByInscription(Long inscriptionId);

    Paiement save(Paiement paiement);

    Paiement update(Paiement paiement);

    void deleteById(Long id);

    RecuPaiement enregistrerPaiement(Paiement paiement, BigDecimal montant, String reference, RecuPaiement.MoyenPaiement moyen);

    void mettreAJourStatut(Paiement paiement);
}