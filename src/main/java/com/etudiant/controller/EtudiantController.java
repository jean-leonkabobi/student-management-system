package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;
import com.etudiant.model.Filiere;
import com.etudiant.model.Niveau;
import com.etudiant.service.EtudiantService;
import com.etudiant.service.FiliereService;
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
@RequestMapping("/etudiants")
@RequiredArgsConstructor
@Slf4j
public class EtudiantController {

    private final EtudiantService etudiantService;
    private final FiliereService filiereService;
    private final NiveauService niveauService;

    /**
     * Affiche la liste des étudiants
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String statut,
            Model model) {

        log.debug("Affichage de la liste des étudiants - search: {}, statut: {}", search, statut);

        List<Etudiant> etudiants;

        if (search != null && !search.trim().isEmpty()) {
            etudiants = etudiantService.search(search.trim());
        } else if (statut != null && !statut.isEmpty()) {
            try {
                StatutEtudiant statutEnum = StatutEtudiant.valueOf(statut);
                etudiants = etudiantService.findByStatut(statutEnum);
            } catch (IllegalArgumentException e) {
                etudiants = etudiantService.findAll();
            }
        } else {
            etudiants = etudiantService.findAll();
        }

        model.addAttribute("etudiants", etudiants);
        model.addAttribute("search", search);
        model.addAttribute("statut", statut);
        model.addAttribute("statuts", StatutEtudiant.values());
        model.addAttribute("totalEtudiants", etudiantService.countTotal());
        model.addAttribute("pageActive", "etudiants");
        model.addAttribute("pageTitle", "Liste des Étudiants");

        return "etudiants/liste";
    }

    /**
     * Affiche le formulaire d'ajout d'un étudiant
     */
    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        log.debug("Affichage du formulaire d'ajout");

        model.addAttribute("etudiant", new Etudiant());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("pageActive", "etudiants");
        model.addAttribute("pageTitle", "Ajouter un Étudiant");

        return "etudiants/ajouter";
    }

    /**
     * Traite l'ajout d'un étudiant
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("etudiant") Etudiant etudiant,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de l'ajout d'un étudiant: {}", etudiant.getNomComplet());

        // Vérifier si l'email existe déjà
        if (etudiant.getEmail() != null && !etudiant.getEmail().isEmpty()) {
            if (etudiantService.findByEmail(etudiant.getEmail()).isPresent()) {
                result.rejectValue("email", "error.etudiant", "Cet email est déjà utilisé");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("pageActive", "etudiants");
            model.addAttribute("pageTitle", "Ajouter un Étudiant");
            return "etudiants/ajouter";
        }

        try {
            // Génération automatique du matricule
            etudiant.setMatricule(etudiantService.generateMatricule());

            Etudiant saved = etudiantService.save(etudiant);
            log.info("Étudiant ajouté avec succès: {}", saved.getMatricule());

            redirectAttributes.addFlashAttribute("success",
                    "Étudiant ajouté avec succès ! Matricule: " + saved.getMatricule());

            return "redirect:/etudiants";

        } catch (IllegalArgumentException e) {
            log.error("Erreur lors de l'ajout: {}", e.getMessage());
            result.rejectValue("matricule", "error.etudiant", e.getMessage());
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("pageActive", "etudiants");
            model.addAttribute("pageTitle", "Ajouter un Étudiant");
            return "etudiants/ajouter";
        }
    }

    /**
     * Affiche le formulaire de modification d'un étudiant
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du formulaire de modification pour l'ID: {}", id);

        return etudiantService.findById(id)
                .map(etudiant -> {
                    model.addAttribute("etudiant", etudiant);
                    model.addAttribute("filieres", filiereService.findAll());
                    model.addAttribute("niveaux", niveauService.findAll());
                    model.addAttribute("pageActive", "etudiants");
                    model.addAttribute("pageTitle", "Modifier un Étudiant");
                    return "etudiants/modifier";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
                    return "redirect:/etudiants";
                });
    }

    /**
     * Traite la modification d'un étudiant
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute("etudiant") Etudiant etudiant,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de la modification: {}", etudiant.getId());

        // Vérifier si l'email existe déjà (sauf pour l'étudiant lui-même)
        if (etudiant.getEmail() != null && !etudiant.getEmail().isEmpty()) {
            etudiantService.findByEmail(etudiant.getEmail())
                    .ifPresent(existing -> {
                        if (!existing.getId().equals(etudiant.getId())) {
                            result.rejectValue("email", "error.etudiant", "Cet email est déjà utilisé");
                        }
                    });
        }

        if (result.hasErrors()) {
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("pageActive", "etudiants");
            model.addAttribute("pageTitle", "Modifier un Étudiant");
            return "etudiants/modifier";
        }

        try {
            etudiantService.update(etudiant);
            log.info("Étudiant modifié avec succès: {}", etudiant.getMatricule());

            redirectAttributes.addFlashAttribute("success",
                    "Étudiant modifié avec succès !");

            return "redirect:/etudiants";

        } catch (IllegalArgumentException e) {
            log.error("Erreur lors de la modification: {}", e.getMessage());
            result.rejectValue("id", "error.etudiant", e.getMessage());
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("niveaux", niveauService.findAll());
            model.addAttribute("pageActive", "etudiants");
            model.addAttribute("pageTitle", "Modifier un Étudiant");
            return "etudiants/modifier";
        }
    }

    /**
     * Supprime un étudiant
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        log.debug("Suppression de l'étudiant avec l'ID: {}", id);

        try {
            etudiantService.findById(id)
                    .ifPresentOrElse(
                            etudiant -> {
                                etudiantService.deleteById(id);
                                log.info("Étudiant supprimé: {}", etudiant.getMatricule());
                                redirectAttributes.addFlashAttribute("success",
                                        "Étudiant supprimé avec succès !");
                            },
                            () -> {
                                redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
                            }
                    );
        } catch (Exception e) {
            log.error("Erreur lors de la suppression: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Impossible de supprimer cet étudiant : " + e.getMessage());
        }

        return "redirect:/etudiants";
    }

    /**
     * Affiche le détail d'un étudiant
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du détail de l'étudiant ID: {}", id);

        return etudiantService.findById(id)
                .map(etudiant -> {
                    model.addAttribute("etudiant", etudiant);
                    model.addAttribute("pageActive", "etudiants");
                    model.addAttribute("pageTitle", "Détail de l'Étudiant");
                    return "etudiants/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
                    return "redirect:/etudiants";
                });
    }

    /**
     * Recherche multicritère
     */
    @GetMapping("/recherche")
    public String recherche(
            @RequestParam(required = false) String matricule,
            @RequestParam(required = false) String nom,
            @RequestParam(required = false) String prenom,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String statut,
            Model model) {

        log.debug("Recherche multicritère");

        StatutEtudiant statutEnum = null;
        if (statut != null && !statut.isEmpty()) {
            try {
                statutEnum = StatutEtudiant.valueOf(statut);
            } catch (IllegalArgumentException e) {
                // Ignorer
            }
        }

        List<Etudiant> etudiants = etudiantService.rechercheMultiCritere(
                matricule, nom, prenom, email, statutEnum);

        model.addAttribute("etudiants", etudiants);
        model.addAttribute("matricule", matricule);
        model.addAttribute("nom", nom);
        model.addAttribute("prenom", prenom);
        model.addAttribute("email", email);
        model.addAttribute("statut", statut);
        model.addAttribute("statuts", StatutEtudiant.values());
        model.addAttribute("pageActive", "etudiants");
        model.addAttribute("pageTitle", "Recherche d'Étudiants");

        return "etudiants/recherche";
    }
}