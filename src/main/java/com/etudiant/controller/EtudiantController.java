package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.service.EtudiantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/etudiants")
public class EtudiantController {

    private final EtudiantService etudiantService;

    public EtudiantController(EtudiantService etudiantService) {
        this.etudiantService = etudiantService;
    }

    @GetMapping
    public String liste(Model model, @RequestParam(required = false) String search) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("etudiants", etudiantService.search(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("etudiants", etudiantService.findAll());
        }
        return "etudiants/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("etudiant", new Etudiant());
        return "etudiants/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("etudiant") Etudiant etudiant,
                       BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "etudiants/form";
        }
        etudiantService.save(etudiant);
        redirectAttributes.addFlashAttribute("success", "Étudiant enregistré avec succès");
        return "redirect:/etudiants";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Etudiant> etudiant = etudiantService.findById(id);
        if (etudiant.isPresent()) {
            model.addAttribute("etudiant", etudiant.get());
            return "etudiants/form";
        }
        redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
        return "redirect:/etudiants";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            etudiantService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Étudiant supprimé");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/etudiants";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Etudiant> etudiant = etudiantService.findById(id);
        if (etudiant.isPresent()) {
            model.addAttribute("etudiant", etudiant.get());
            return "etudiants/details";
        }
        redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
        return "redirect:/etudiants";
    }
}