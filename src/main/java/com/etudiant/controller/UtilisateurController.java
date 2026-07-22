package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.service.UtilisateurService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/utilisateurs")
public class UtilisateurController {

    private final UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    @GetMapping
    public String liste(Model model) {
        model.addAttribute("utilisateurs", utilisateurService.findAll());
        return "utilisateurs/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("utilisateur", new Utilisateur());
        return "utilisateurs/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("utilisateur") Utilisateur utilisateur,
                       BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "utilisateurs/form";
        }
        if (utilisateurService.existsByUsername(utilisateur.getUsername())) {
            redirectAttributes.addFlashAttribute("error", "Ce nom d'utilisateur existe déjà");
            return "redirect:/utilisateurs/ajouter";
        }
        utilisateurService.save(utilisateur);
        redirectAttributes.addFlashAttribute("success", "Utilisateur créé avec succès");
        return "redirect:/utilisateurs";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Utilisateur> utilisateur = utilisateurService.findById(id);
        if (utilisateur.isPresent()) {
            model.addAttribute("utilisateur", utilisateur.get());
            return "utilisateurs/form";
        }
        redirectAttributes.addFlashAttribute("error", "Utilisateur non trouvé");
        return "redirect:/utilisateurs";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            utilisateurService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Utilisateur supprimé");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/utilisateurs";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Utilisateur> utilisateur = utilisateurService.findById(id);
        if (utilisateur.isPresent()) {
            model.addAttribute("utilisateur", utilisateur.get());
            return "utilisateurs/details";
        }
        redirectAttributes.addFlashAttribute("error", "Utilisateur non trouvé");
        return "redirect:/utilisateurs";
    }
}