package com.etudiant.service.impl;

import com.etudiant.model.Paiement;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.model.Paiement.TypeFrais;
import com.etudiant.model.RecuPaiement;
import com.etudiant.model.RecuPaiement.MoyenPaiement;
import com.etudiant.repository.PaiementRepository;
import com.etudiant.repository.RecuPaiementRepository;
import com.etudiant.service.PaiementService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class PaiementServiceImpl implements PaiementService {

    private final PaiementRepository paiementRepository;
    private final RecuPaiementRepository recuPaiementRepository;

    @Override
    public List<Paiement> findAll() {
        return paiementRepository.findAll();
    }

    @Override
    public Optional<Paiement> findById(Long id) {
        return paiementRepository.findById(id);
    }

    @Override
    public List<Paiement> findByInscriptionId(Long inscriptionId) {
        return paiementRepository.findByInscriptionId(inscriptionId);
    }

    @Override
    public List<Paiement> findByStatut(StatutPaiement statut) {
        return paiementRepository.findByStatut(statut);
    }

    @Override
    public List<Paiement> findByTypeFrais(TypeFrais typeFrais) {
        return paiementRepository.findByTypeFrais(typeFrais);
    }

    @Override
    public BigDecimal getTotalPayeByInscription(Long inscriptionId) {
        List<Paiement> paiements = paiementRepository.findByInscriptionId(inscriptionId);
        return paiements.stream()
                .map(Paiement::getMontantPaye)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public BigDecimal getTotalRestantByInscription(Long inscriptionId) {
        List<Paiement> paiements = paiementRepository.findByInscriptionId(inscriptionId);
        BigDecimal totalRestant = BigDecimal.ZERO;

        for (Paiement p : paiements) {
            totalRestant = totalRestant.add(p.getMontantTotal().subtract(p.getMontantPaye()));
        }

        return totalRestant;
    }

    @Override
    public Paiement save(Paiement paiement) {
        log.info("Sauvegarde d'un paiement pour l'inscription ID: {}",
                paiement.getInscription() != null ? paiement.getInscription().getId() : "null");
        return paiementRepository.save(paiement);
    }

    @Override
    public Paiement update(Paiement paiement) {
        log.info("Mise à jour du paiement ID: {}", paiement.getId());
        return paiementRepository.save(paiement);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression du paiement ID: {}", id);
        paiementRepository.deleteById(id);
    }

    @Override
    public RecuPaiement enregistrerPaiement(Paiement paiement, BigDecimal montant,
                                            String reference, MoyenPaiement moyen) {
        log.info("Enregistrement d'un paiement de {} pour le paiement ID: {}", montant, paiement.getId());

        // Mettre à jour le montant payé
        BigDecimal nouveauMontantPaye = paiement.getMontantPaye().add(montant);
        paiement.setMontantPaye(nouveauMontantPaye);
        paiementRepository.save(paiement);

        // Mettre à jour le statut
        mettreAJourStatut(paiement);

        // Créer le reçu
        RecuPaiement recu = new RecuPaiement();
        recu.setPaiement(paiement);
        recu.setMontant(montant);
        recu.setDatePaiement(LocalDate.now());
        recu.setMoyenPaiement(moyen);
        recu.setReference(reference);

        return recuPaiementRepository.save(recu);
    }

    @Override
    public void mettreAJourStatut(Paiement paiement) {
        BigDecimal restant = paiement.getMontantTotal().subtract(paiement.getMontantPaye());

        if (restant.compareTo(BigDecimal.ZERO) <= 0) {
            paiement.setStatut(StatutPaiement.PAYE);
        } else if (paiement.getMontantPaye().compareTo(BigDecimal.ZERO) > 0) {
            paiement.setStatut(StatutPaiement.PARTIEL);
        }

        // Vérifier le retard
        if (paiement.getDateLimite() != null &&
                paiement.getDateLimite().isBefore(LocalDate.now()) &&
                paiement.getStatut() != StatutPaiement.PAYE) {
            paiement.setStatut(StatutPaiement.EN_RETARD);
        }

        paiementRepository.save(paiement);
    }
}