package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.service.DashboardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@Slf4j
public class DashboardController {

    private final DashboardService dashboardService;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(HttpSession session, Model model) {

        // Vérifier si l'utilisateur est connecté
        if (session.getAttribute("utilisateur") == null) {
            return "redirect:/login";
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur.getRole();

        log.debug("Affichage du tableau de bord pour le rôle: {}", role);

        switch (role) {
            case ADMIN:
                return dashboardAdmin(session, model);
            case SCOLARITE:
                return dashboardScolarite(session, model);
            case COMPTABLE:
            case BIBLIOTHECAIRE:
                return dashboardAdmin(session, model);
            case ENSEIGNANT:
                return dashboardEnseignant(session, model);
            case ETUDIANT:
                return dashboardEtudiant(session, model);
            default:
                return dashboardAdmin(session, model);
        }
    }

    /**
     * Dashboard pour l'administration (complet)
     */
    private String dashboardAdmin(HttpSession session, Model model) {
        model.addAttribute("totalEtudiants", dashboardService.getTotalEtudiants());
        model.addAttribute("totalEnseignants", dashboardService.getTotalEnseignants());
        model.addAttribute("totalFilieres", dashboardService.getTotalFilieres());
        model.addAttribute("totalInscriptions", dashboardService.getTotalInscriptions());
        model.addAttribute("totalMatieres", dashboardService.getTotalMatieres());
        model.addAttribute("totalPaiements", dashboardService.getTotalPaiements());
        model.addAttribute("totalPaiementsMontant", dashboardService.getTotalPaiementsMontant());
        model.addAttribute("etudiantsParStatut", dashboardService.getEtudiantsParStatut());
        model.addAttribute("paiementsParStatut", dashboardService.getPaiementsParStatut());
        model.addAttribute("moyenneGenerale", dashboardService.getMoyenneNotesGenerale());

        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageActive", "dashboard");
        model.addAttribute("pageTitle", "Tableau de bord - Administration");
        model.addAttribute("utilisateur", session.getAttribute("utilisateur"));

        return "dashboard/admin";
    }

    /**
     * Dashboard pour les enseignants
     */
    private String dashboardEnseignant(HttpSession session, Model model) {
        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageActive", "dashboard");
        model.addAttribute("pageTitle", "Tableau de bord - Enseignant");
        model.addAttribute("utilisateur", session.getAttribute("utilisateur"));

        return "dashboard/enseignant";
    }

    /**
     * Dashboard pour les étudiants
     */
    private String dashboardEtudiant(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        String username = utilisateur != null ? utilisateur.getUsername() : "Utilisateur";
        Object role = session.getAttribute("role");

        model.addAttribute("role", role);
        model.addAttribute("username", username);
        model.addAttribute("pageActive", "dashboard");
        model.addAttribute("pageTitle", "Tableau de bord - Étudiant");
        model.addAttribute("utilisateur", utilisateur);

        return "dashboard/etudiant";
    }

    /**
     * Dashboard pour la Scolarité
     */
    private String dashboardScolarite(HttpSession session, Model model) {
        model.addAttribute("totalEtudiants", dashboardService.getTotalEtudiants());
        model.addAttribute("totalEnseignants", dashboardService.getTotalEnseignants());
        model.addAttribute("totalFilieres", dashboardService.getTotalFilieres());
        model.addAttribute("totalInscriptions", dashboardService.getTotalInscriptions());
        model.addAttribute("totalMatieres", dashboardService.getTotalMatieres());
        model.addAttribute("totalPaiements", dashboardService.getTotalPaiements());
        model.addAttribute("totalPaiementsMontant", dashboardService.getTotalPaiementsMontant());
        model.addAttribute("etudiantsParStatut", dashboardService.getEtudiantsParStatut());
        model.addAttribute("paiementsParStatut", dashboardService.getPaiementsParStatut());
        model.addAttribute("moyenneGenerale", dashboardService.getMoyenneNotesGenerale());

        model.addAttribute("role", session.getAttribute("role"));
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("pageActive", "dashboard");
        model.addAttribute("pageTitle", "Tableau de bord - Scolarité");
        model.addAttribute("utilisateur", session.getAttribute("utilisateur"));

        return "dashboard/scolarite";
    }
}