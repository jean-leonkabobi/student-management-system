package com.etudiant.controller;

import com.etudiant.model.Matiere;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.MatiereService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cours")
@RequiredArgsConstructor
@Slf4j
public class CoursController {

    private final MatiereService matiereService;

    // ==========================================
    // MÉTHODES DE VÉRIFICATION
    // ==========================================

    private boolean isAdminOrScolarite(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        Role role = utilisateur.getRole();
        return role == Role.ADMIN || role == Role.SCOLARITE;
    }

    private boolean isEnseignant(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        return utilisateur.getRole() == Role.ENSEIGNANT;
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

    @GetMapping
    public String mesCours(HttpSession session, Model model) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        if (role == null) {
            return "redirect:/login";
        }

        log.debug("Affichage des cours pour le rôle: {}", role);

        model.addAttribute("role", role);
        model.addAttribute("username", utilisateur.getUsername());
        model.addAttribute("pageActive", "cours");
        model.addAttribute("pageTitle", "Mes Cours");
        model.addAttribute("utilisateur", utilisateur);

        // ADMIN ou SCOLARITE : voient tous les cours
        if (isAdminOrScolarite(session)) {
            List<Matiere> tousLesCours = matiereService.findAll();
            model.addAttribute("mesCours", tousLesCours);
            model.addAttribute("hasCours", !tousLesCours.isEmpty());
            model.addAttribute("isAdminView", true);
        }
        // Enseignant : voit ses cours assignés
        else if (isEnseignant(session) && utilisateur.getEnseignant() != null) {
            Long enseignantId = utilisateur.getEnseignant().getId();
            List<Matiere> mesCours = matiereService.findByEnseignantId(enseignantId);
            model.addAttribute("mesCours", mesCours);
            model.addAttribute("hasCours", !mesCours.isEmpty());
            model.addAttribute("isAdminView", false);
        }
        // Étudiant : n'a pas accès aux cours
        else if (isEtudiant(session)) {
            model.addAttribute("mesCours", List.of());
            model.addAttribute("hasCours", false);
            model.addAttribute("isAdminView", false);
        }
        // Autres rôles
        else {
            model.addAttribute("mesCours", List.of());
            model.addAttribute("hasCours", false);
            model.addAttribute("isAdminView", false);
        }

        return "cours/index";
    }
}