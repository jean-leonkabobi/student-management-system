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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    private final UtilisateurService utilisateurService;
    private final EtudiantService etudiantService;
    private final EnseignantService enseignantService;

    @GetMapping("/login")
    public String loginPage(HttpSession session, Model model) {
        if (session.getAttribute("utilisateur") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {

        log.debug("Tentative de connexion: {}", username);

        if (utilisateurService.authenticate(username, password)) {
            Utilisateur utilisateur = utilisateurService.findByUsername(username).orElse(null);
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("role", utilisateur != null ? utilisateur.getRole() : null);
            session.setAttribute("username", utilisateur != null ? utilisateur.getUsername() : null);

            log.info("Utilisateur connecté: {} avec rôle: {}", username, utilisateur != null ? utilisateur.getRole() : "null");
            return "redirect:/dashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("utilisateur", new Utilisateur());
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String email,
                           @RequestParam String passwordHash,
                           @RequestParam String confirmPassword,
                           @RequestParam(required = false, defaultValue = "ETUDIANT") String role,
                           RedirectAttributes redirectAttributes) {

        log.debug("Tentative d'inscription: {}", username);

        // Vérifier que les mots de passe correspondent
        if (!passwordHash.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Les mots de passe ne correspondent pas");
            return "redirect:/register";
        }

        // Vérifier que le nom d'utilisateur n'existe pas déjà
        if (utilisateurService.findByUsername(username).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Ce nom d'utilisateur existe déjà");
            return "redirect:/register";
        }

        // Vérifier que l'email n'existe pas déjà
        if (utilisateurService.findByEmail(email).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Cet email existe déjà");
            return "redirect:/register";
        }

        try {
            Role userRole;
            try {
                userRole = Role.valueOf(role);
            } catch (IllegalArgumentException e) {
                userRole = Role.ETUDIANT;
            }

            // 1. Créer le profil selon le rôle
            if (userRole == Role.ETUDIANT) {
                // Créer un étudiant
                Etudiant etudiant = new Etudiant();
                etudiant.setMatricule(etudiantService.generateMatricule());
                etudiant.setNom(username);
                etudiant.setPrenom(username);
                etudiant.setEmail(email);
                etudiant.setStatut(StatutEtudiant.ACTIF);

                Etudiant savedEtudiant = etudiantService.save(etudiant);
                log.info("Étudiant créé pour l'utilisateur {}: {}", username, savedEtudiant.getMatricule());

                // 2. Créer l'utilisateur avec l'étudiant associé
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setUsername(username);
                utilisateur.setEmail(email);
                utilisateur.setPasswordHash(passwordHash);
                utilisateur.setEstActif(true);
                utilisateur.setRole(Role.ETUDIANT);
                utilisateur.setEtudiant(savedEtudiant);

                utilisateurService.save(utilisateur);
                log.info("Utilisateur créé avec succès: {} lié à l'étudiant ID: {}", username, savedEtudiant.getId());

                redirectAttributes.addFlashAttribute("success",
                        "Inscription réussie ! Vous êtes inscrit en tant qu'étudiant. Matricule: " + savedEtudiant.getMatricule());

            } else if (userRole == Role.ENSEIGNANT) {
                // Créer un enseignant
                Enseignant enseignant = new Enseignant();
                enseignant.setMatricule(generateMatriculeEnseignant());
                enseignant.setNom(username);
                enseignant.setPrenom(username);
                enseignant.setEmail(email);
                enseignant.setGrade("À définir");
                enseignant.setDepartement("À définir");
                enseignant.setSpecialite("À définir");

                Enseignant savedEnseignant = enseignantService.save(enseignant);
                log.info("Enseignant créé pour l'utilisateur {}: {}", username, savedEnseignant.getMatricule());

                // 2. Créer l'utilisateur avec l'enseignant associé
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setUsername(username);
                utilisateur.setEmail(email);
                utilisateur.setPasswordHash(passwordHash);
                utilisateur.setEstActif(true);
                utilisateur.setRole(Role.ENSEIGNANT);
                utilisateur.setEnseignant(savedEnseignant);

                utilisateurService.save(utilisateur);
                log.info("Utilisateur créé avec succès: {} lié à l'enseignant ID: {}", username, savedEnseignant.getId());

                redirectAttributes.addFlashAttribute("success",
                        "Inscription réussie ! Vous êtes inscrit en tant qu'enseignant. Matricule: " + savedEnseignant.getMatricule());

            } else {
                // Autres rôles (ADMIN, SCOLARITE, etc.) : pas de profil spécifique
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setUsername(username);
                utilisateur.setEmail(email);
                utilisateur.setPasswordHash(passwordHash);
                utilisateur.setEstActif(true);
                utilisateur.setRole(userRole);

                utilisateurService.save(utilisateur);
                log.info("Utilisateur créé avec succès: {} avec rôle: {}", username, userRole);

                redirectAttributes.addFlashAttribute("success",
                        "Inscription réussie ! Vous êtes inscrit en tant que " + userRole);
            }

        } catch (Exception e) {
            log.error("Erreur lors de l'inscription: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de l'inscription: " + e.getMessage());
            return "redirect:/register";
        }

        return "redirect:/login";
    }

    /**
     * Génère un matricule pour un enseignant
     */
    private String generateMatriculeEnseignant() {
        long count = enseignantService.count() + 1;
        return "ENS-" + String.format("%04d", count);
    }
}