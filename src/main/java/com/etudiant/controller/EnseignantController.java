package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.service.EnseignantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/enseignants")
public class EnseignantController {

    private final EnseignantService enseignantService;

    public EnseignantController(EnseignantService enseignantService) {
        this.enseignantService = enseignantService;
    }

    @GetMapping
    public String liste(Model model, @RequestParam(required = false) String search,
                        @RequestParam(required = false) String departement) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("enseignants", enseignantService.search(search));
            model.addAttribute("search", search);
        } else if (departement != null && !departement.isEmpty()) {
            model.addAttribute("enseignants", enseignantService.findByDepartement(departement));
            model.addAttribute("departement", departement);
        } else {
            model.addAttribute("enseignants", enseignantService.findAll());
        }
        return "enseignants/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("enseignant", new Enseignant());
        return "enseignants/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("enseignant") Enseignant enseignant,
                       BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "enseignants/form";
        }
        enseignantService.save(enseignant);
        redirectAttributes.addFlashAttribute("success", "Enseignant enregistré avec succès");
        return "redirect:/enseignants";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Enseignant> enseignant = enseignantService.findById(id);
        if (enseignant.isPresent()) {
            model.addAttribute("enseignant", enseignant.get());
            return "enseignants/form";
        }
        redirectAttributes.addFlashAttribute("error", "Enseignant non trouvé");
        return "redirect:/enseignants";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            enseignantService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Enseignant supprimé");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/enseignants";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Enseignant> enseignant = enseignantService.findById(id);
        if (enseignant.isPresent()) {
            model.addAttribute("enseignant", enseignant.get());
            return "enseignants/details";
        }
        redirectAttributes.addFlashAttribute("error", "Enseignant non trouvé");
        return "redirect:/enseignants";
    }
}