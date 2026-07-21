package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.EnseignantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/enseignant/profil")
@RequiredArgsConstructor
@Slf4j
public class EnseignantProfilController {

    private final EnseignantService enseignantService;

    @GetMapping
    public String monProfil(HttpSession session, Model model, RedirectAttributes redirectAttributes) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        if (role == null) {
            return "redirect:/login";
        }

        if (role != Role.ENSEIGNANT) {
            redirectAttributes.addFlashAttribute("error", "Accès non autorisé.");
            return "redirect:/dashboard";
        }

        if (utilisateur.getEnseignant() == null) {
            redirectAttributes.addFlashAttribute("error", "Aucun profil enseignant associé à votre compte.");
            return "redirect:/dashboard";
        }

        Long enseignantId = utilisateur.getEnseignant().getId();
        Enseignant enseignant = enseignantService.findById(enseignantId)
                .orElseThrow(() -> new RuntimeException("Enseignant non trouvé"));

        log.debug("Affichage du profil de l'enseignant: {}", enseignant.getNomComplet());

        model.addAttribute("enseignant", enseignant);
        model.addAttribute("role", role);
        model.addAttribute("username", utilisateur.getUsername());
        model.addAttribute("pageActive", "profil");
        model.addAttribute("pageTitle", "Mon Profil - Enseignant");

        return "enseignants/profil";
    }
}
