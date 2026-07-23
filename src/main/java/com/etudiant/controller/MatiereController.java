package com.etudiant.controller;

import com.etudiant.model.Enseignant;
import com.etudiant.model.Filiere;
import com.etudiant.model.Matiere;
import com.etudiant.service.EnseignantService;
import com.etudiant.service.FiliereService;
import com.etudiant.service.MatiereService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/matieres")
public class MatiereController {

    private final MatiereService matiereService;
    private final FiliereService filiereService;
    private final EnseignantService enseignantService;

    public MatiereController(MatiereService matiereService, FiliereService filiereService,
                             EnseignantService enseignantService) {
        this.matiereService = matiereService;
        this.filiereService = filiereService;
        this.enseignantService = enseignantService;
    }

    @GetMapping
    public String liste(Model model, @RequestParam(required = false) Long filiereId) {
        model.addAttribute("filieres", filiereService.findAll());
        if (filiereId != null) {
            model.addAttribute("matieres", matiereService.findByFiliereId(filiereId));
            model.addAttribute("selectedFiliere", filiereId);
        } else {
            model.addAttribute("matieres", matiereService.findAll());
        }
        return "matieres/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("matiere", new Matiere());
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("enseignants", enseignantService.findAll());
        return "matieres/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("matiere") Matiere matiere,
                       @RequestParam(value = "filiereId", required = false) Long filiereId,
                       @RequestParam(value = "enseignantId", required = false) Long enseignantId,
                       RedirectAttributes redirectAttributes) {
        try {
            // Lier la filière
            if (filiereId != null) {
                Optional<Filiere> filiere = filiereService.findById(filiereId);
                filiere.ifPresent(matiere::setFiliere);
            }

            // Lier l'enseignant
            if (enseignantId != null) {
                Optional<Enseignant> enseignant = enseignantService.findById(enseignantId);
                enseignant.ifPresent(matiere::setEnseignant);
            }

            matiereService.save(matiere);
            redirectAttributes.addFlashAttribute("success", "Matière enregistrée avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
        }
        return "redirect:/matieres";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Matiere> matiere = matiereService.findById(id);
        if (matiere.isPresent()) {
            model.addAttribute("matiere", matiere.get());
            model.addAttribute("filieres", filiereService.findAll());
            model.addAttribute("enseignants", enseignantService.findAll());
            return "matieres/form";
        }
        redirectAttributes.addFlashAttribute("error", "Matière non trouvée");
        return "redirect:/matieres";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            matiereService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Matière supprimée");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/matieres";
    }
}