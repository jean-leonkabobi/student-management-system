package com.etudiant.controller;

import com.etudiant.model.Paiement;
import com.etudiant.model.Paiement.StatutPaiement;
import com.etudiant.model.Paiement.TypeFrais;
import com.etudiant.model.RecuPaiement;
import com.etudiant.model.RecuPaiement.MoyenPaiement;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.InscriptionService;
import com.etudiant.service.PaiementService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
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
     * Liste des paiements - Adaptée selon le rôle
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) StatutPaiement statut,
            HttpSession session,
            Model model) {

        log.debug("Affichage de la liste des paiements");

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        List<Paiement> paiements;
        List<com.etudiant.model.Inscription> inscriptions;

        if (role == Role.ETUDIANT) {
            // Étudiant : ne voit que ses paiements
            if (utilisateur.getEtudiant() != null) {
                Long etudiantId = utilisateur.getEtudiant().getId();
                inscriptions = inscriptionService.findByEtudiantId(etudiantId);

                if (inscriptionId != null) {
                    boolean hasAccess = inscriptions.stream().anyMatch(i -> i.getId().equals(inscriptionId));
                    if (hasAccess) {
                        paiements = paiementService.findByInscriptionId(inscriptionId);
                        model.addAttribute("inscription", inscriptionService.findById(inscriptionId).orElse(null));
                        model.addAttribute("totalPaye", paiementService.getTotalPayeByInscription(inscriptionId));
                        model.addAttribute("totalRestant", paiementService.getTotalRestantByInscription(inscriptionId));
                    } else if (!inscriptions.isEmpty()) {
                        Long firstId = inscriptions.get(0).getId();
                        paiements = paiementService.findByInscriptionId(firstId);
                        model.addAttribute("inscription", inscriptions.get(0));
                        model.addAttribute("totalPaye", paiementService.getTotalPayeByInscription(firstId));
                        model.addAttribute("totalRestant", paiementService.getTotalRestantByInscription(firstId));
                    } else {
                        paiements = List.of();
                        model.addAttribute("inscription", null);
                        model.addAttribute("totalPaye", BigDecimal.ZERO);
                        model.addAttribute("totalRestant", BigDecimal.ZERO);
                    }
                } else if (!inscriptions.isEmpty()) {
                    Long firstId = inscriptions.get(0).getId();
                    paiements = paiementService.findByInscriptionId(firstId);
                    model.addAttribute("inscription", inscriptions.get(0));
                    model.addAttribute("totalPaye", paiementService.getTotalPayeByInscription(firstId));
                    model.addAttribute("totalRestant", paiementService.getTotalRestantByInscription(firstId));
                } else {
                    paiements = List.of();
                    model.addAttribute("inscription", null);
                    model.addAttribute("totalPaye", BigDecimal.ZERO);
                    model.addAttribute("totalRestant", BigDecimal.ZERO);
                }

                model.addAttribute("inscriptions", inscriptions);
                model.addAttribute("isEtudiant", true);
            } else {
                paiements = List.of();
                inscriptions = List.of();
                model.addAttribute("inscriptions", inscriptions);
                model.addAttribute("isEtudiant", true);
                model.addAttribute("totalPaye", BigDecimal.ZERO);
                model.addAttribute("totalRestant", BigDecimal.ZERO);
            }
        } else {
            // Administrateur, Scolarité, Comptable : voit tout
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

            model.addAttribute("inscriptions", inscriptionService.findAll());
            model.addAttribute("isEtudiant", false);
        }

        model.addAttribute("paiements", paiements);
        model.addAttribute("statuts", StatutPaiement.values());
        model.addAttribute("typesFrais", TypeFrais.values());
        model.addAttribute("moyensPaiement", MoyenPaiement.values());
        model.addAttribute("pageActive", "paiements");
        model.addAttribute("pageTitle", role == Role.ETUDIANT ? "Mes Paiements" : "Liste des Paiements");
        model.addAttribute("role", role);

        return "paiements/liste";
    }

    /**
     * Formulaire d'ajout - Réservé aux administrateurs, scolarité et comptables
     */
    @GetMapping("/ajouter")
    public String ajouterForm(
            @RequestParam(required = false) Long inscriptionId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        // Seuls les admins, scolarité et comptables peuvent ajouter des paiements
        if (role == Role.ETUDIANT || role == Role.ENSEIGNANT || role == Role.BIBLIOTHECAIRE) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit d'ajouter des paiements.");
            return "redirect:/paiements";
        }

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
        model.addAttribute("role", role);

        return "paiements/ajouter";
    }

    /**
     * Traite l'ajout - Réservé aux administrateurs, scolarité et comptables
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("paiement") Paiement paiement,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        if (role == Role.ETUDIANT || role == Role.ENSEIGNANT || role == Role.BIBLIOTHECAIRE) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit d'ajouter des paiements.");
            return "redirect:/paiements";
        }

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
     * Enregistrer un paiement (avec reçu) - Réservé aux administrateurs, scolarité et comptables
     */
    @PostMapping("/enregistrer")
    public String enregistrerPaiement(
            @RequestParam Long paiementId,
            @RequestParam BigDecimal montant,
            @RequestParam String reference,
            @RequestParam MoyenPaiement moyenPaiement,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        if (role == Role.ETUDIANT || role == Role.ENSEIGNANT || role == Role.BIBLIOTHECAIRE) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit d'enregistrer des paiements.");
            return "redirect:/paiements";
        }

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
     * Détail d'un paiement - Adaptée selon le rôle
     */
    @GetMapping("/detail/{id}")
    public String detail(
            @PathVariable Long id,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Affichage du détail du paiement ID: {}", id);

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        return paiementService.findById(id)
                .map(paiement -> {
                    // Vérifier si l'étudiant a accès à ce paiement
                    if (role == Role.ETUDIANT) {
                        if (utilisateur.getEtudiant() != null) {
                            Long etudiantId = utilisateur.getEtudiant().getId();
                            Long inscriptionEtudiantId = paiement.getInscription().getEtudiant().getId();
                            if (!etudiantId.equals(inscriptionEtudiantId)) {
                                redirectAttributes.addFlashAttribute("error", "Vous n'avez pas accès à ce paiement.");
                                return "redirect:/paiements";
                            }
                        } else {
                            redirectAttributes.addFlashAttribute("error", "Profil étudiant non trouvé.");
                            return "redirect:/paiements";
                        }
                    }

                    model.addAttribute("paiement", paiement);
                    model.addAttribute("moyensPaiement", MoyenPaiement.values());
                    model.addAttribute("pageActive", "paiements");
                    model.addAttribute("pageTitle", "Détail du Paiement");
                    model.addAttribute("role", role);
                    return "paiements/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Paiement non trouvé");
                    return "redirect:/paiements";
                });
    }

    /**
     * Supprimer un paiement - Réservé aux administrateurs uniquement
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(
            @PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        // Seuls les administrateurs peuvent supprimer des paiements
        if (role != Role.ADMIN && role != Role.SCOLARITE && role != Role.COMPTABLE) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de supprimer des paiements.");
            return "redirect:/paiements";
        }

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