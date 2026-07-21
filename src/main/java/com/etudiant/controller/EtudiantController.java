package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;
import com.etudiant.model.Filiere;
import com.etudiant.model.Niveau;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
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

import javax.servlet.http.HttpSession;
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

    // ==========================================
    // MÉTHODES DE VÉRIFICATION
    // ==========================================

    private boolean isAdminOrScolarite(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        Role role = utilisateur.getRole();
        return role == Role.ADMIN || role == Role.SCOLARITE;
    }

    private boolean isEtudiant(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        return utilisateur.getRole() == Role.ETUDIANT;
    }

    private Role getRole(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        return utilisateur != null ? utilisateur.getRole() : null;
    }

    // ==========================================
    // MÉTHODES PUBLIQUES
    // ==========================================

    /**
     * Affiche la liste des étudiants - ADMIN et SCOLARITE uniquement
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String statut,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        // L'étudiant ne peut pas voir la liste des autres étudiants
        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas accès à la liste des étudiants.");
            return "redirect:/dashboard";
        }

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
        model.addAttribute("role", getRole(session));

        return "etudiants/liste";
    }

    /**
     * Affiche le formulaire d'ajout - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/ajouter")
    public String ajouterForm(
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit d'ajouter des étudiants.");
            return "redirect:/etudiants";
        }

        log.debug("Affichage du formulaire d'ajout");

        model.addAttribute("etudiant", new Etudiant());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("pageActive", "etudiants");
        model.addAttribute("pageTitle", "Ajouter un Étudiant");
        model.addAttribute("role", getRole(session));

        return "etudiants/ajouter";
    }

    /**
     * Traite l'ajout d'un étudiant - ADMIN et SCOLARITE uniquement
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("etudiant") Etudiant etudiant,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit d'ajouter des étudiants.");
            return "redirect:/etudiants";
        }

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
     * Affiche le formulaire de modification - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(
            @PathVariable Long id,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de modifier des étudiants.");
            return "redirect:/etudiants";
        }

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
     * Traite la modification d'un étudiant - ADMIN et SCOLARITE uniquement
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute("etudiant") Etudiant etudiant,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de modifier des étudiants.");
            return "redirect:/etudiants";
        }

        log.debug("Traitement de la modification: {}", etudiant.getId());

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

            redirectAttributes.addFlashAttribute("success", "Étudiant modifié avec succès !");
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
     * Supprime un étudiant - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(
            @PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de supprimer des étudiants.");
            return "redirect:/etudiants";
        }

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
                            () -> redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé")
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
     * - ADMIN et SCOLARITE : voient tous les profils
     * - ETUDIANT : voit uniquement son propre profil
     */
    @GetMapping("/detail/{id}")
    public String detail(
            @PathVariable Long id,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Affichage du détail de l'étudiant ID: {}", id);

        return etudiantService.findById(id)
                .map(etudiant -> {
                    // Si c'est un étudiant, il ne peut voir que son propre profil
                    if (isEtudiant(session)) {
                        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
                        if (utilisateur.getEtudiant() != null) {
                            Long etudiantId = utilisateur.getEtudiant().getId();
                            if (!etudiantId.equals(id)) {
                                redirectAttributes.addFlashAttribute("error", "Vous ne pouvez pas voir le profil d'un autre étudiant.");
                                return "redirect:/dashboard";
                            }
                        } else {
                            redirectAttributes.addFlashAttribute("error", "Profil non trouvé.");
                            return "redirect:/dashboard";
                        }
                    }

                    model.addAttribute("etudiant", etudiant);
                    model.addAttribute("pageActive", "etudiants");
                    model.addAttribute("pageTitle", "Détail de l'Étudiant");
                    model.addAttribute("role", getRole(session));
                    return "etudiants/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
                    return "redirect:/etudiants";
                });
    }

    /**
     * Recherche multicritère - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/recherche")
    public String recherche(
            @RequestParam(required = false) String matricule,
            @RequestParam(required = false) String nom,
            @RequestParam(required = false) String prenom,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String statut,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas accès à la recherche avancée.");
            return "redirect:/dashboard";
        }

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
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("niveaux", niveauService.findAll());
        model.addAttribute("pageActive", "recherche");
        model.addAttribute("pageTitle", "Recherche avancée");
        model.addAttribute("role", getRole(session));

        return "etudiants/recherche-avancee";
    }

    /**
     * Recherche multicritère via API - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/api/recherche")
    @ResponseBody
    public List<Etudiant> rechercheApi(
            @RequestParam(required = false) String matricule,
            @RequestParam(required = false) String nom,
            @RequestParam(required = false) String prenom,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String statut,
            HttpSession session) {

        if (isEtudiant(session)) {
            return List.of();
        }

        StatutEtudiant statutEnum = null;
        if (statut != null && !statut.isEmpty()) {
            try {
                statutEnum = StatutEtudiant.valueOf(statut);
            } catch (IllegalArgumentException e) {
                // Ignorer
            }
        }

        return etudiantService.rechercheMultiCritere(matricule, nom, prenom, email, statutEnum);
    }
}