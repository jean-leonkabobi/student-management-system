package com.etudiant.controller;

import com.etudiant.model.AnneeAcademique;
import com.etudiant.model.Etudiant;
import com.etudiant.model.Filiere;
import com.etudiant.model.Inscription;
import com.etudiant.model.Niveau;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
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

import javax.servlet.http.HttpSession;
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
    // MÉTHODES
    // ==========================================

    /**
     * Liste des inscriptions - ADMIN et SCOLARITE uniquement
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long etudiantId,
            @RequestParam(required = false) Long filiereId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Seul un étudiant ne peut pas voir les inscriptions
        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas accès aux inscriptions.");
            return "redirect:/dashboard";
        }

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
        model.addAttribute("role", getRole(session));

        return "inscriptions/liste";
    }

    /**
     * Formulaire d'ajout d'une inscription - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/ajouter")
    public String ajouterForm(
            @RequestParam(required = false) Long etudiantId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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
        model.addAttribute("role", getRole(session));

        return "inscriptions/ajouter";
    }

    /**
     * Traite l'ajout d'une inscription - ADMIN et SCOLARITE uniquement
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute("inscription") Inscription inscription,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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

            redirectAttributes.addFlashAttribute("success", "Inscription ajoutée avec succès !");
            return "redirect:/inscriptions";

        } catch (Exception e) {
            log.error("Erreur lors de l'ajout de l'inscription: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'ajout de l'inscription: " + e.getMessage());
            return "redirect:/inscriptions/ajouter";
        }
    }

    /**
     * Détail d'une inscription - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/detail/{id}")
    public String detail(
            @PathVariable Long id,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas accès aux détails des inscriptions.");
            return "redirect:/dashboard";
        }

        log.debug("Affichage du détail de l'inscription ID: {}", id);

        return inscriptionService.findById(id)
                .map(inscription -> {
                    model.addAttribute("inscription", inscription);
                    model.addAttribute("pageActive", "inscriptions");
                    model.addAttribute("pageTitle", "Détail de l'Inscription");
                    model.addAttribute("role", getRole(session));
                    return "inscriptions/detail";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Inscription non trouvée");
                    return "redirect:/inscriptions";
                });
    }

    /**
     * Supprime une inscription - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(
            @PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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