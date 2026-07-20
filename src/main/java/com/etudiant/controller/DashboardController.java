package com.etudiant.controller;

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

        log.debug("Affichage du tableau de bord");

        // Statistiques principales
        model.addAttribute("totalEtudiants", dashboardService.getTotalEtudiants());
        model.addAttribute("totalEnseignants", dashboardService.getTotalEnseignants());
        model.addAttribute("totalFilieres", dashboardService.getTotalFilieres());
        model.addAttribute("totalInscriptions", dashboardService.getTotalInscriptions());
        model.addAttribute("totalMatieres", dashboardService.getTotalMatieres());
        model.addAttribute("totalPaiements", dashboardService.getTotalPaiements());
        model.addAttribute("totalPaiementsMontant", dashboardService.getTotalPaiementsMontant());

        // Graphiques
        model.addAttribute("etudiantsParStatut", dashboardService.getEtudiantsParStatut());
        model.addAttribute("paiementsParStatut", dashboardService.getPaiementsParStatut());
        model.addAttribute("moyenneGenerale", dashboardService.getMoyenneNotesGenerale());

        model.addAttribute("pageActive", "dashboard");
        model.addAttribute("pageTitle", "Tableau de bord");

        // Récupérer l'utilisateur connecté
        model.addAttribute("utilisateur", session.getAttribute("utilisateur"));

        return "dashboard/index";
    }
}