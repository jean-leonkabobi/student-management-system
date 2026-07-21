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

        // Si c'est un enseignant, récupérer ses cours
        if (role == Role.ENSEIGNANT && utilisateur.getEnseignant() != null) {
            Long enseignantId = utilisateur.getEnseignant().getId();
            List<Matiere> mesCours = matiereService.findByEnseignantId(enseignantId);
            model.addAttribute("mesCours", mesCours);
            model.addAttribute("hasCours", !mesCours.isEmpty());
        } else {
            model.addAttribute("mesCours", List.of());
            model.addAttribute("hasCours", false);
        }

        return "cours/index";
    }
}