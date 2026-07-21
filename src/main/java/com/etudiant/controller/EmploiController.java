package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.EmploiDuTempsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emploi")
@RequiredArgsConstructor
@Slf4j
public class EmploiController {

    private final EmploiDuTempsService emploiDuTempsService; // ⬅️ AJOUTÉ

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

        // Si c'est un étudiant
        if (role == Role.ETUDIANT && utilisateur.getEtudiant() != null) {
            model.addAttribute("etudiantId", utilisateur.getEtudiant().getId());
            model.addAttribute("hasEmploi", false);
        }

        // Si c'est un enseignant
        else if (role == Role.ENSEIGNANT && utilisateur.getEnseignant() != null) {
            Long enseignantId = utilisateur.getEnseignant().getId();

            // Récupérer l'emploi du temps groupé par jour
            Map<String, List<com.etudiant.model.EmploiDuTemps>> emploiParJour =
                    emploiDuTempsService.getEmploiParJour(enseignantId);

            // Vérifier s'il y a des cours programmés
            boolean hasEmploi = !emploiParJour.values().stream().allMatch(List::isEmpty);

            model.addAttribute("emploiParJour", emploiParJour);
            model.addAttribute("hasEmploi", hasEmploi);
            model.addAttribute("enseignantId", enseignantId);
        }

        // Autres rôles
        else {
            model.addAttribute("hasEmploi", false);
        }

        return "emploi/index";
    }
}