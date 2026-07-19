package com.etudiant.controller;

import com.etudiant.model.AnneeAcademique;
import com.etudiant.model.Etudiant;
import com.etudiant.model.Filiere;
import com.etudiant.model.Inscription;
import com.etudiant.model.Niveau;
import com.etudiant.service.AnneeAcademiqueService;
import com.etudiant.service.EtudiantService;
import com.etudiant.service.FiliereService;
import com.etudiant.service.InscriptionService;
import com.etudiant.service.NiveauService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/inscriptions")
@RequiredArgsConstructor
@Slf4j
public class InscriptionController {

    private final InscriptionService inscriptionService;
    private final EtudiantService etudiantService;
    private final FiliereService filiereService;
    private final NiveauService niveauService;
    private final AnneeAcademiqueService anneeAcademiqueService;

    /**
     * Liste des inscriptions
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long etudiantId,
            @RequestParam(required = false) Long filiereId,
            Model model) {

        log.debug("Affichage de la liste des inscriptions");

        List<Inscription> inscriptions;

        if (etudiantId != null) {
            inscriptions = inscriptionService.findByEtudiantId(etudiantId);
            model.addAttribute("etudiant", etudiantService.findById(etudiantId).orElse(null));
        } else if (filiereId != null) {
            inscriptions = inscriptionService.findByFiliereId(filiereId);
        } else {
            inscriptions = inscriptionService.findAll();
        }

        model.addAttribute("inscriptions", inscriptions);
        model.addAttribute("etudiants", etudiantService.findAll());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("pageActive", "inscriptions");
        model.addAttribute("pageTitle", "Liste des Inscriptions");

        return "inscriptions/liste";
    }

    /**
     * Formulaire d'ajout d'une inscription
     */
    @GetMapping("/ajouter")
    public String ajouterForm(
            @RequestParam(required = false) Long etudiantId,
            Model model) {

        log.debug("Affichage du formulaire d'ajout d'inscription");

        Inscription inscription = new Inscription();

        if (etudiantId != null) {
            etudiantService.findById(etudiantId).ifPresent(inscription::setEtudiant);
        }

        model.addAttribute("inscription", inscription);
        model.addAttribute("etudiants", etudiantService.findAll());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("anneesAcademiques", anneeAcademiqueService.findActiveYears());
        model.addAttribute("pageActive", "inscriptions");
        model.addAttribute("pageTitle", "Nouvelle Inscription");

        return "inscriptions/ajouter";
    }

    /**
     * Traite l'ajout d'une inscription
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("inscription") Inscription inscription,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de l'ajout d'une inscription");

        // Vérifier si l'étudiant est déjà inscrit pour cette année
        if (inscriptionService.isEtudiantInscrit(
                inscription.getEtudiant().getId(),
                inscription.getAnneeAcademique().getId())) {
            result.rejectValue("etudiant", "error.inscription",
                    "Cet étudiant est déjà inscrit pour cette année académique");
        }

        if (result.hasErrors()) {
            model.addAttribute("etudiants", etudiantService.findAll());
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("anneesAcademiques", anneeAcademiqueService.findActiveYears());
            model.addAttribute("pageActive", "inscriptions");
            model.addAttribute("pageTitle", "Nouvelle Inscription");
            return "inscriptions/ajouter";
        }

        try {
            Inscription saved = inscriptionService.save(inscription);
            log.info("Inscription ajoutée avec succès: {}", saved.getId());

            redirectAttributes.addFlashAttribute("success",
                    "Inscription ajoutée avec succès !");

            return "redirect:/inscriptions";

        } catch (Exception e) {
            log.error("Erreur lors de l'ajout de l'inscription: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'ajout de l'inscription: " + e.getMessage());
            return "redirect:/inscriptions/ajouter";
        }
    }

    /**
     * Détail d'une inscription
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du détail de l'inscription ID: {}", id);

        return inscriptionService.findById(id)
                .map(inscription -> {
                    model.addAttribute("inscription", inscription);
                    model.addAttribute("pageActive", "inscriptions");
                    model.addAttribute("pageTitle", "Détail de l'Inscription");
                    return "inscriptions/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Inscription non trouvée");
                    return "redirect:/inscriptions";
                });
    }

    /**
     * Supprime une inscription
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        log.debug("Suppression de l'inscription ID: {}", id);

        try {
            inscriptionService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Inscription supprimée avec succès !");
        } catch (Exception e) {
            log.error("Erreur lors de la suppression: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Impossible de supprimer cette inscription: " + e.getMessage());
        }

        return "redirect:/inscriptions";
    }
}