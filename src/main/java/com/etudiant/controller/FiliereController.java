package com.etudiant.controller;

import com.etudiant.model.Filiere;
import com.etudiant.service.FiliereService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/filieres")
public class FiliereController {

    private final FiliereService filiereService;

    public FiliereController(FiliereService filiereService) {
        this.filiereService = filiereService;
    }

    @GetMapping
    public String liste(Model model) {
        model.addAttribute("filieres", filiereService.findAll());
        return "filieres/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("filiere", new Filiere());
        return "filieres/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("filiere") Filiere filiere,
                       BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "filieres/form";
        }
        if (filiereService.existsByCode(filiere.getCode())) {
            redirectAttributes.addFlashAttribute("error", "Ce code de filière existe déjà");
            return "redirect:/filieres/ajouter";
        }
        filiereService.save(filiere);
        redirectAttributes.addFlashAttribute("success", "Filière créée avec succès");
        return "redirect:/filieres";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Filiere> filiere = filiereService.findById(id);
        if (filiere.isPresent()) {
            model.addAttribute("filiere", filiere.get());
            return "filieres/form";
        }
        redirectAttributes.addFlashAttribute("error", "Filière non trouvée");
        return "redirect:/filieres";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            filiereService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Filière supprimée");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/filieres";
    }
}