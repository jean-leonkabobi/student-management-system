package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.EnseignantService;
import com.etudiant.service.UtilisateurService;
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
    private static final String MSG_INFO = "info";
    private static final String PAGE_ACTIVE_VALUE = "enseignants";

    private static final String TITLE_LISTE = "Liste des Enseignants";
    private static final String TITLE_AJOUTER = "Ajouter un Enseignant";
    private static final String TITLE_MODIFIER = "Modifier un Enseignant";

    // ==========================================
    // SERVICES
    // ==========================================
    private final EnseignantService enseignantService;
    private final UtilisateurService utilisateurService;

    // ==========================================
    // MÉTHODES DE VÉRIFICATION
    // ==========================================

    private boolean isAdminOrScolarite(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        Role role = utilisateur.getRole();
        return role == Role.ADMIN || role == Role.SCOLARITE;
    }

    private Role getRole(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        return utilisateur != null ? utilisateur.getRole() : null;
    }

    // ==========================================
    // MÉTHODES
    // ==========================================

    /**
     * Affiche la liste des enseignants - ADMIN et SCOLARITE uniquement
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) String search,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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
        model.addAttribute("role", getRole(session));

        return VIEW_LISTE;
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
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

        model.addAttribute(ATTR_ENSEIGNANT, new Enseignant());
        model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
        model.addAttribute(ATTR_PAGE_TITLE, TITLE_AJOUTER);

        return VIEW_FORM;
    }

    /**
     * Traite l'ajout d'un enseignant - ADMIN et SCOLARITE uniquement
     */
    @PostMapping("/ajouter")
    public String ajouter(
            @Valid @ModelAttribute(ATTR_ENSEIGNANT) Enseignant enseignant,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

        if (enseignantService.existsByMatricule(enseignant.getMatricule())) {
            result.rejectValue("matricule", "error.enseignant", "Ce matricule existe déjà");
        }

        if (result.hasErrors()) {
            model.addAttribute(ATTR_PAGE_ACTIVE, PAGE_ACTIVE_VALUE);
            model.addAttribute(ATTR_PAGE_TITLE, TITLE_AJOUTER);
            return VIEW_FORM;
        }

        // Sauvegarder l'enseignant
        Enseignant savedEnseignant = enseignantService.save(enseignant);

        // Générer un mot de passe aléatoire
        String motDePasse = generateRandomPassword();

        // Générer le nom d'utilisateur
        String username = generateUsername(enseignant);

        // Créer le compte utilisateur pour l'enseignant
        try {
            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setUsername(username);
            utilisateur.setPasswordHash(motDePasse);
            utilisateur.setEmail(enseignant.getEmail());
            utilisateur.setRole(Role.ENSEIGNANT);
            utilisateur.setEnseignant(savedEnseignant);
            utilisateur.setEstActif(true);

            utilisateurService.save(utilisateur);

            log.info("==================================================");
            log.info("👨‍🏫 ENSEIGNANT CRÉÉ AVEC SUCCÈS !");
            log.info("   Nom: {}", enseignant.getNomComplet());
            log.info("   Email: {}", enseignant.getEmail());
            log.info("   Matricule: {}", enseignant.getMatricule());
            log.info("   👤 Nom d'utilisateur: {}", username);
            log.info("   🔑 Mot de passe: {}", motDePasse);
            log.info("==================================================");

            redirectAttributes.addFlashAttribute(MSG_SUCCESS,
                    "Enseignant ajouté avec succès ! Un compte utilisateur a été créé.");
            redirectAttributes.addFlashAttribute(MSG_INFO,
                    "Nom d'utilisateur: " + username + " | Mot de passe: " + motDePasse);

        } catch (Exception e) {
            log.error("Erreur lors de la création du compte utilisateur: {}", e.getMessage());
            redirectAttributes.addFlashAttribute(MSG_SUCCESS,
                    "Enseignant ajouté avec succès ! Mais le compte utilisateur n'a pas pu être créé.");
        }

        return REDIRECT_LISTE;
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
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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
     * Traite la modification d'un enseignant - ADMIN et SCOLARITE uniquement
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute(ATTR_ENSEIGNANT) Enseignant enseignant,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administration.");
            return "redirect:/dashboard";
        }

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
     * Supprime un enseignant - ADMIN et SCOLARITE uniquement
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

        enseignantService.deleteById(id);
        redirectAttributes.addFlashAttribute(MSG_SUCCESS, "Enseignant supprimé !");
        return REDIRECT_LISTE;
    }

    // ==========================================
    // MÉTHODES PRIVÉES
    // ==========================================

    /**
     * Génère un nom d'utilisateur à partir du nom, prénom et postnom
     */
    private String generateUsername(Enseignant enseignant) {
        StringBuilder sb = new StringBuilder();

        if (enseignant.getNom() != null && !enseignant.getNom().isEmpty()) {
            sb.append(enseignant.getNom().toLowerCase());
        }

        if (enseignant.getPrenom() != null && !enseignant.getPrenom().isEmpty()) {
            if (sb.length() > 0) sb.append(".");
            sb.append(enseignant.getPrenom().toLowerCase());
        }

        if (enseignant.getPostnom() != null && !enseignant.getPostnom().isEmpty()) {
            if (sb.length() > 0) sb.append(".");
            sb.append(enseignant.getPostnom().toLowerCase());
        }

        return sb.toString().replace(" ", ".");
    }

    /**
     * Génère un mot de passe aléatoire de 8 caractères
     */
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
}