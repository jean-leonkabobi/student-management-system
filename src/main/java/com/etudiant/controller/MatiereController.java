package com.etudiant.controller;

import com.etudiant.model.Matiere;
import com.etudiant.service.EnseignantService;
import com.etudiant.service.FiliereService;
import com.etudiant.service.MatiereService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
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
    public String liste(Model model, @RequestParam(required = false) Long filiereId,
                        @RequestParam(required = false) Long enseignantId) {
        model.addAttribute("filieres", filiereService.findAll());
        if (filiereId != null) {
            model.addAttribute("matieres", matiereService.findByFiliereId(filiereId));
            model.addAttribute("selectedFiliere", filiereId);
        } else if (enseignantId != null) {
            model.addAttribute("matieres", matiereService.findByEnseignantId(enseignantId));
            model.addAttribute("selectedEnseignant", enseignantId);
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
    public String save(@Valid @ModelAttribute("matiere") Matiere matiere,
                       BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "matieres/form";
        }
        if (matiereService.existsByCode(matiere.getCode())) {
            redirectAttributes.addFlashAttribute("error", "Ce code de matière existe déjà");
            return "redirect:/matieres/ajouter";
        }
        matiereService.save(matiere);
        redirectAttributes.addFlashAttribute("success", "Matière créée avec succès");
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