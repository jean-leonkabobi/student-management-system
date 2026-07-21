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

    @GetMapping
    public String liste(HttpSession session, Model model) {
        if (session.getAttribute("utilisateur") == null) {
            return "redirect:/login";
        }

        List<Utilisateur> utilisateurs = utilisateurService.findAll();
        model.addAttribute("utilisateurs", utilisateurs);
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageActive", "utilisateurs");
        model.addAttribute("pageTitle", "Liste des Utilisateurs");

        return "utilisateurs/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(HttpSession session, Model model) {
        if (session.getAttribute("utilisateur") == null) {
            return "redirect:/login";
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

        if (session.getAttribute("utilisateur") == null) {
            return "redirect:/login";
        }

        // Vérifier que les mots de passe correspondent
        if (!utilisateur.getPasswordHash().equals(confirmPassword)) {
            result.rejectValue("passwordHash", "error.utilisateur", "Les mots de passe ne correspondent pas");
        }

        // Vérifier que le nom d'utilisateur n'existe pas déjà
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
            // Créer le profil selon le rôle
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
                // Autres rôles : ADMIN, SCOLARITE, COMPTABLE, BIBLIOTHECAIRE
                // Pas de profil spécifique, juste l'utilisateur
                log.info("Utilisateur {} créé avec le rôle {}", utilisateur.getUsername(), utilisateur.getRole());
            }

            // Sauvegarder l'utilisateur
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

        return "redirect:/utilisateurs";
    }

    @GetMapping("/toggle/{id}")
    public String toggle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
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
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        utilisateurService.deleteById(id);
        redirectAttributes.addFlashAttribute("success", "Utilisateur supprimé");
        return "redirect:/utilisateurs";
    }

    /**
     * Génère un matricule pour un enseignant
     */
    private String generateMatriculeEnseignant() {
        long count = enseignantService.count() + 1;
        return "ENS-" + String.format("%04d", count);
    }
}