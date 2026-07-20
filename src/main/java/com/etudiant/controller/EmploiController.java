package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/emploi")
@RequiredArgsConstructor
@Slf4j
public class EmploiController {

    @GetMapping
    public String emploiDuTemps(HttpSession session, Model model) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        if (role == null) {
            return "redirect:/login";
        }

        log.debug("Affichage de l'emploi du temps pour le rôle: {}", role);

        model.addAttribute("role", role);
        model.addAttribute("username", utilisateur.getUsername());
        model.addAttribute("pageActive", "emploi");
        model.addAttribute("pageTitle", "Mon Emploi du Temps");
        model.addAttribute("utilisateur", utilisateur);

        // Si c'est un étudiant, on passe son ID pour filtrer
        if (role == Role.ETUDIANT && utilisateur.getEtudiant() != null) {
            model.addAttribute("etudiantId", utilisateur.getEtudiant().getId());
        }

        return "emploi/index";
    }
}