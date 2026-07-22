package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.model.Etudiant;
import com.etudiant.model.Etudiant.StatutEtudiant;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.EnseignantService;
import com.etudiant.service.EtudiantService;
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
@RequestMapping("/utilisateurs")
@RequiredArgsConstructor
@Slf4j
public class UtilisateurController {

    private final UtilisateurService utilisateurService;
    private final EtudiantService etudiantService;
    private final EnseignantService enseignantService;

    private boolean isAdmin(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        return utilisateur != null && utilisateur.getRole() == Role.ADMIN;
    }

    @GetMapping
    public String liste(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administrateur.");
            return "redirect:/dashboard";
        }

        List<Utilisateur> utilisateurs = utilisateurService.findAll();
        model.addAttribute("utilisateurs", utilisateurs);
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageActive", "utilisateurs");
        model.addAttribute("pageTitle", "Liste des Utilisateurs");

        return "utilisateurs/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administrateur.");
            return "redirect:/dashboard";
        }

        model.addAttribute("utilisateur", new Utilisateur());
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageActive", "utilisateurs");
        model.addAttribute("pageTitle", "Ajouter un Utilisateur");

        return "utilisateurs/ajouter";
    }

    @PostMapping("/ajouter")
    public String ajouter(@Valid @ModelAttribute("utilisateur") Utilisateur utilisateur,
                          BindingResult result,
                          @RequestParam String confirmPassword,
                          HttpSession session,
                          Model model,
                          RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administrateur.");
            return "redirect:/dashboard";
        }

        if (!utilisateur.getPasswordHash().equals(confirmPassword)) {
            result.rejectValue("passwordHash", "error.utilisateur", "Les mots de passe ne correspondent pas");
        }

        if (utilisateurService.findByUsername(utilisateur.getUsername()).isPresent()) {
            result.rejectValue("username", "error.utilisateur", "Ce nom d'utilisateur existe déjà");
        }

        if (result.hasErrors()) {
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageActive", "utilisateurs");
            model.addAttribute("pageTitle", "Ajouter un Utilisateur");
            return "utilisateurs/ajouter";
        }

        try {
            if (utilisateur.getRole() == Role.ETUDIANT) {
                // Créer un étudiant
                Etudiant etudiant = new Etudiant();
                etudiant.setMatricule(etudiantService.generateMatricule());
                etudiant.setNom(utilisateur.getUsername());
                etudiant.setPrenom(utilisateur.getUsername());
                etudiant.setEmail(utilisateur.getEmail());
                etudiant.setStatut(StatutEtudiant.ACTIF);

                Etudiant savedEtudiant = etudiantService.save(etudiant);
                utilisateur.setEtudiant(savedEtudiant);
                log.info("Étudiant créé pour l'utilisateur {}: {}", utilisateur.getUsername(), savedEtudiant.getMatricule());

                // Générer un mot de passe aléatoire pour l'étudiant
                String motDePasse = generateRandomPassword();
                utilisateur.setPasswordHash(motDePasse);

                log.info("==================================================");
                log.info("🎓 ÉTUDIANT CRÉÉ AVEC SUCCÈS !");
                log.info("   Nom: {}", utilisateur.getUsername());
                log.info("   Email: {}", utilisateur.getEmail());
                log.info("   Matricule: {}", savedEtudiant.getMatricule());
                log.info("   🔑 Mot de passe: {}", motDePasse);
                log.info("==================================================");

                redirectAttributes.addFlashAttribute("info",
                        "Mot de passe généré: " + motDePasse + " (à communiquer à l'étudiant)");

            } else if (utilisateur.getRole() == Role.ENSEIGNANT) {
                // Créer un enseignant
                Enseignant enseignant = new Enseignant();
                enseignant.setMatricule(generateMatriculeEnseignant());
                enseignant.setNom(utilisateur.getUsername());
                enseignant.setPrenom(utilisateur.getUsername());
                enseignant.setEmail(utilisateur.getEmail());
                enseignant.setGrade("À définir");
                enseignant.setDepartement("À définir");
                enseignant.setSpecialite("À définir");

                Enseignant savedEnseignant = enseignantService.save(enseignant);
                utilisateur.setEnseignant(savedEnseignant);
                log.info("Enseignant créé pour l'utilisateur {}: {}", utilisateur.getUsername(), savedEnseignant.getMatricule());

            } else {
                log.info("Utilisateur {} créé avec le rôle {}", utilisateur.getUsername(), utilisateur.getRole());
            }

            utilisateurService.save(utilisateur);
            redirectAttributes.addFlashAttribute("success", "Utilisateur ajouté avec succès !");

        } catch (Exception e) {
            log.error("Erreur lors de l'ajout: {}", e.getMessage());
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageActive", "utilisateurs");
            model.addAttribute("pageTitle", "Ajouter un Utilisateur");
            model.addAttribute("error", "Erreur: " + e.getMessage());
            return "utilisateurs/ajouter";
        }

        // ⬇️ REDIRIGER VERS LE DASHBOARD ⬇️
        return "redirect:/dashboard";
    }

    @GetMapping("/toggle/{id}")
    public String toggle(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administrateur.");
            return "redirect:/dashboard";
        }

        utilisateurService.findById(id).ifPresent(u -> {
            if (u.getEstActif()) {
                utilisateurService.desactiverUtilisateur(id);
                redirectAttributes.addFlashAttribute("success", "Utilisateur désactivé");
            } else {
                utilisateurService.activerUtilisateur(id);
                redirectAttributes.addFlashAttribute("success", "Utilisateur activé");
            }
        });

        return "redirect:/utilisateurs";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé. Réservé à l'administrateur.");
            return "redirect:/dashboard";
        }

        utilisateurService.deleteById(id);
        redirectAttributes.addFlashAttribute("success", "Utilisateur supprimé");
        return "redirect:/utilisateurs";
    }

    private String generateMatriculeEnseignant() {
        long count = enseignantService.count() + 1;
        return "ENS-" + String.format("%04d", count);
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