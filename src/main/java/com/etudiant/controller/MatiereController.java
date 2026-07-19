package com.etudiant.controller;

import com.etudiant.model.Matiere;
import com.etudiant.model.Matiere.Semestre;
import com.etudiant.service.FiliereService;
import com.etudiant.service.MatiereService;
import com.etudiant.service.NiveauService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/matieres")
@RequiredArgsConstructor
@Slf4j
public class MatiereController {

    private final MatiereService matiereService;
    private final FiliereService filiereService;
    private final NiveauService niveauService;

    /**
     * Liste des matières
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long filiereId,
            @RequestParam(required = false) Long niveauId,
            Model model) {

        log.debug("Affichage de la liste des matières");

        if (filiereId != null && niveauId != null) {
            model.addAttribute("matieres",
                    matiereService.findByFiliereAndNiveau(filiereId, niveauId));
        } else if (filiereId != null) {
            model.addAttribute("matieres", matiereService.findByFiliereId(filiereId));
        } else if (niveauId != null) {
            model.addAttribute("matieres", matiereService.findByNiveauId(niveauId));
        } else {
            model.addAttribute("matieres", matiereService.findAll());
        }

        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("semestres", Semestre.values());
        model.addAttribute("pageActive", "matieres");
        model.addAttribute("pageTitle", "Liste des Matières");

        return "matieres/liste";
    }

    /**
     * Formulaire d'ajout d'une matière
     */
    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        log.debug("Affichage du formulaire d'ajout de matière");

        model.addAttribute("matiere", new Matiere());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("semestres", Semestre.values());
        model.addAttribute("pageActive", "matieres");
        model.addAttribute("pageTitle", "Nouvelle Matière");

        return "matieres/ajouter";
    }

    /**
     * Traite l'ajout d'une matière
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("matiere") Matiere matiere,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de l'ajout d'une matière");

        if (matiereService.existsByCode(matiere.getCode())) {
            result.rejectValue("code", "error.matiere", "Ce code existe déjà");
        }

        if (result.hasErrors()) {
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("semestres", Semestre.values());
            model.addAttribute("pageActive", "matieres");
            model.addAttribute("pageTitle", "Nouvelle Matière");
            return "matieres/ajouter";
        }

        try {
            Matiere saved = matiereService.save(matiere);
            log.info("Matière ajoutée avec succès: {}", saved.getCode());

            redirectAttributes.addFlashAttribute("success",
                    "Matière ajoutée avec succès !");

            return "redirect:/matieres";

        } catch (Exception e) {
            log.error("Erreur lors de l'ajout: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'ajout: " + e.getMessage());
            return "redirect:/matieres/ajouter";
        }
    }

    /**
     * Formulaire de modification d'une matière
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du formulaire de modification de la matière ID: {}", id);

        return matiereService.findById(id)
                .map(matiere -> {
                    model.addAttribute("matiere", matiere);
                    model.addAttribute("filieres", filiereService.findAll());
                    model.addAttribute("niveaux", niveauService.findAll());
                    model.addAttribute("semestres", Semestre.values());
                    model.addAttribute("pageActive", "matieres");
                    model.addAttribute("pageTitle", "Modifier une Matière");
                    return "matieres/modifier";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Matière non trouvée");
                    return "redirect:/matieres";
                });
    }

    /**
     * Traite la modification d'une matière
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute("matiere") Matiere matiere,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de la modification de la matière ID: {}", matiere.getId());

        if (result.hasErrors()) {
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("semestres", Semestre.values());
            model.addAttribute("pageActive", "matieres");
            model.addAttribute("pageTitle", "Modifier une Matière");
            return "matieres/modifier";
        }

        try {
            matiereService.update(matiere);
            log.info("Matière modifiée avec succès: {}", matiere.getCode());

            redirectAttributes.addFlashAttribute("success",
                    "Matière modifiée avec succès !");

            return "redirect:/matieres";

        } catch (Exception e) {
            log.error("Erreur lors de la modification: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de la modification: " + e.getMessage());
            return "redirect:/matieres/modifier/" + matiere.getId();
        }
    }

    /**
     * Supprime une matière
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        log.debug("Suppression de la matière ID: {}", id);

        try {
            matiereService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Matière supprimée avec succès !");
        } catch (Exception e) {
            log.error("Erreur lors de la suppression: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Impossible de supprimer cette matière: " + e.getMessage());
        }

        return "redirect:/matieres";
    }
}