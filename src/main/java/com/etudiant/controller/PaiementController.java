package com.etudiant.controller;

import com.etudiant.model.Paiement;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.model.Paiement.TypeFrais;
import com.etudiant.model.RecuPaiement;
import com.etudiant.model.RecuPaiement.MoyenPaiement;
import com.etudiant.service.InscriptionService;
import com.etudiant.service.PaiementService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/paiements")
@RequiredArgsConstructor
@Slf4j
public class PaiementController {

    private final PaiementService paiementService;
    private final InscriptionService inscriptionService;

    /**
     * Liste des paiements
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) StatutPaiement statut,
            Model model) {

        log.debug("Affichage de la liste des paiements");

        List<Paiement> paiements;

        if (inscriptionId != null) {
            paiements = paiementService.findByInscriptionId(inscriptionId);
            model.addAttribute("inscription", inscriptionService.findById(inscriptionId).orElse(null));
            model.addAttribute("totalPaye", paiementService.getTotalPayeByInscription(inscriptionId));
            model.addAttribute("totalRestant", paiementService.getTotalRestantByInscription(inscriptionId));
        } else if (statut != null) {
            paiements = paiementService.findByStatut(statut);
        } else {
            paiements = paiementService.findAll();
        }

        model.addAttribute("paiements", paiements);
        model.addAttribute("inscriptions", inscriptionService.findAll());
        model.addAttribute("statuts", StatutPaiement.values());
        model.addAttribute("typesFrais", TypeFrais.values());
        model.addAttribute("moyensPaiement", MoyenPaiement.values());
        model.addAttribute("pageActive", "paiements");
        model.addAttribute("pageTitle", "Liste des Paiements");

        return "paiements/liste";
    }

    /**
     * Formulaire d'ajout d'un paiement
     */
    @GetMapping("/ajouter")
    public String ajouterForm(
            @RequestParam(required = false) Long inscriptionId,
            Model model) {

        log.debug("Affichage du formulaire d'ajout de paiement");

        Paiement paiement = new Paiement();

        if (inscriptionId != null) {
            inscriptionService.findById(inscriptionId).ifPresent(paiement::setInscription);
        }

        model.addAttribute("paiement", paiement);
        model.addAttribute("inscriptions", inscriptionService.findAll());
        model.addAttribute("typesFrais", TypeFrais.values());
        model.addAttribute("moyensPaiement", MoyenPaiement.values());
        model.addAttribute("pageActive", "paiements");
        model.addAttribute("pageTitle", "Nouveau Paiement");

        return "paiements/ajouter";
    }

    /**
     * Traite l'ajout d'un paiement
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("paiement") Paiement paiement,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de l'ajout d'un paiement");

        if (result.hasErrors()) {
            model.addAttribute("inscriptions", inscriptionService.findAll());
            model.addAttribute("typesFrais", TypeFrais.values());
            model.addAttribute("moyensPaiement", MoyenPaiement.values());
            model.addAttribute("pageActive", "paiements");
            model.addAttribute("pageTitle", "Nouveau Paiement");
            return "paiements/ajouter";
        }

        try {
            paiementService.save(paiement);
            log.info("Paiement ajouté avec succès");

            redirectAttributes.addFlashAttribute("success", "Paiement ajouté avec succès !");

            return "redirect:/paiements?inscriptionId=" + paiement.getInscription().getId();

        } catch (Exception e) {
            log.error("Erreur lors de l'ajout: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'ajout: " + e.getMessage());
            return "redirect:/paiements/ajouter";
        }
    }

    /**
     * Enregistrer un paiement (avec reçu)
     */
    @PostMapping("/enregistrer")
    public String enregistrerPaiement(
            @RequestParam Long paiementId,
            @RequestParam BigDecimal montant,
            @RequestParam String reference,
            @RequestParam MoyenPaiement moyenPaiement,
            RedirectAttributes redirectAttributes) {

        log.debug("Enregistrement d'un paiement pour l'ID: {}", paiementId);

        try {
            Paiement paiement = paiementService.findById(paiementId)
                    .orElseThrow(() -> new RuntimeException("Paiement non trouvé"));

            RecuPaiement recu = paiementService.enregistrerPaiement(
                    paiement, montant, reference, moyenPaiement);

            log.info("Paiement enregistré avec succès, reçu ID: {}", recu.getId());

            redirectAttributes.addFlashAttribute("success",
                    "Paiement enregistré avec succès ! Montant: " + montant);

            return "redirect:/paiements?inscriptionId=" + paiement.getInscription().getId();

        } catch (Exception e) {
            log.error("Erreur lors de l'enregistrement: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'enregistrement: " + e.getMessage());
            return "redirect:/paiements";
        }
    }

    /**
     * Détail d'un paiement
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du détail du paiement ID: {}", id);

        return paiementService.findById(id)
                .map(paiement -> {
                    model.addAttribute("paiement", paiement);
                    model.addAttribute("moyensPaiement", MoyenPaiement.values());
                    model.addAttribute("pageActive", "paiements");
                    model.addAttribute("pageTitle", "Détail du Paiement");
                    return "paiements/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Paiement non trouvé");
                    return "redirect:/paiements";
                });
    }

    /**
     * Supprimer un paiement
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        log.debug("Suppression du paiement ID: {}", id);

        try {
            Paiement paiement = paiementService.findById(id).orElse(null);
            paiementService.deleteById(id);

            redirectAttributes.addFlashAttribute("success", "Paiement supprimé avec succès !");

            if (paiement != null) {
                return "redirect:/paiements?inscriptionId=" + paiement.getInscription().getId();
            }

        } catch (Exception e) {
            log.error("Erreur lors de la suppression: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Impossible de supprimer ce paiement: " + e.getMessage());
        }

        return "redirect:/paiements";
    }
}