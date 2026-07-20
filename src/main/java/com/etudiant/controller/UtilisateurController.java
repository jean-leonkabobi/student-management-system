package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
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

        utilisateurService.save(utilisateur);
        redirectAttributes.addFlashAttribute("success", "Utilisateur ajouté avec succès !");

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
}