package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.service.EnseignantService;
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
@RequestMapping("/enseignants")
@RequiredArgsConstructor
@Slf4j
public class EnseignantController {

    // ==========================================
    // CONSTANTES
    // ==========================================
    private static final String REDIRECT_LISTE = "redirect:/enseignants";
    private static final String VIEW_LISTE = "enseignants/liste";
    private static final String VIEW_FORM = "enseignants/ajouter";
    private static final String VIEW_MODIFIER = "enseignants/modifier";

    private static final String ATTR_PAGE_ACTIVE = "pageActive";
    private static final String ATTR_PAGE_TITLE = "pageTitle";
    private static final String ATTR_ENSEIGNANT = "enseignant";
    private static final String ATTR_ENSEIGNANTS = "enseignants";
    private static final String ATTR_SEARCH = "search";

    private static final String MSG_SUCCESS = "success";
    private static final String MSG_ERROR = "error";
    private static final String PAGE_ACTIVE_VALUE = "enseignants";

    private static final String TITLE_LISTE = "Liste des Enseignants";
    private static final String TITLE_AJOUTER = "Ajouter un Enseignant";
    private static final String TITLE_MODIFIER = "Modifier un Enseignant";

    // ==========================================
    // SERVICES
    // ==========================================
    private final EnseignantService enseignantService;

    // ==========================================
    // MÉTHODES
    // ==========================================

    /**
     * Affiche la liste des enseignants
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) String search,
            Model model) {

        log.debug("Affichage de la liste des enseignants");

        List<Enseignant> enseignants;
        if (search != null && !search.trim().isEmpty()) {
            enseignants = enseignantService.search(search.trim());
        } else {
            enseignants = enseignantService.findAll();
        }

        model.addAttribute(ATTR_ENSEIGNANTS, enseignants);
        model.addAttribute(ATTR_SEARCH, search);
        model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
        model.addAttribute(ATTR_PAGE_TITLE, TITLE_LISTE);

        return VIEW_LISTE;
    }

    /**
     * Affiche le formulaire d'ajout
     */
    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute(ATTR_ENSEIGNANT, new Enseignant());
        model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
        model.addAttribute(ATTR_PAGE_TITLE, TITLE_AJOUTER);
        return VIEW_FORM;
    }

    /**
     * Traite l'ajout d'un enseignant
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute(ATTR_ENSEIGNANT) Enseignant enseignant,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (enseignantService.existsByMatricule(enseignant.getMatricule())) {
            result.rejectValue("matricule", "error.enseignant", "Ce matricule existe déjà");
        }

        if (result.hasErrors()) {
            model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
            model.addAttribute(ATTR_PAGE_TITLE, TITLE_AJOUTER);
            return VIEW_FORM;
        }

        enseignantService.save(enseignant);
        redirectAttributes.addFlashAttribute(MSG_SUCCESS, "Enseignant ajouté avec succès !");
        return REDIRECT_LISTE;
    }

    /**
     * Affiche le formulaire de modification
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(
            @PathVariable Long id,
            Model model,
            RedirectAttributes redirectAttributes) {

        return enseignantService.findById(id)
                .map(enseignant -> {
                    model.addAttribute(ATTR_ENSEIGNANT, enseignant);
                    model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
                    model.addAttribute(ATTR_PAGE_TITLE, TITLE_MODIFIER);
                    return VIEW_MODIFIER;
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute(MSG_ERROR, "Enseignant non trouvé");
                    return REDIRECT_LISTE;
                });
    }

    /**
     * Traite la modification d'un enseignant
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute(ATTR_ENSEIGNANT) Enseignant enseignant,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
            model.addAttribute(ATTR_PAGE_TITLE, TITLE_MODIFIER);
            return VIEW_MODIFIER;
        }

        enseignantService.update(enseignant);
        redirectAttributes.addFlashAttribute(MSG_SUCCESS, "Enseignant modifié avec succès !");
        return REDIRECT_LISTE;
    }

    /**
     * Supprime un enseignant
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        enseignantService.deleteById(id);
        redirectAttributes.addFlashAttribute(MSG_SUCCESS, "Enseignant supprimé !");
        return REDIRECT_LISTE;
    }
}