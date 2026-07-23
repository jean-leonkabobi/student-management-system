package com.etudiant.controller;

import com.etudiant.model.Classe;
import com.etudiant.model.Filiere;
import com.etudiant.service.ClasseService;
import com.etudiant.service.EtudiantService;
import com.etudiant.service.FiliereService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/classes")
public class ClasseController {

    private final ClasseService classeService;
    private final FiliereService filiereService;
    private final EtudiantService etudiantService;

    public ClasseController(ClasseService classeService, FiliereService filiereService,
                            EtudiantService etudiantService) {
        this.classeService = classeService;
        this.filiereService = filiereService;
        this.etudiantService = etudiantService;
    }

    @GetMapping
    public String liste(Model model, @RequestParam(required = false) Long filiereId) {
        model.addAttribute("filieres", filiereService.findAll());
        if (filiereId != null) {
            model.addAttribute("classes", classeService.findByFiliereId(filiereId));
            model.addAttribute("selectedFiliere", filiereId);
        } else {
            model.addAttribute("classes", classeService.findAll());
        }
        return "classes/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("classe", new Classe());
        model.addAttribute("filieres", filiereService.findAll());
        return "classes/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("classe") Classe classe,
                       @RequestParam(value = "filiereId", required = false) Long filiereId,
                       RedirectAttributes redirectAttributes) {
        try {
            if (filiereId != null) {
                Optional<Filiere> filiere = filiereService.findById(filiereId);
                filiere.ifPresent(classe::setFiliere);
            }
            classeService.save(classe);
            redirectAttributes.addFlashAttribute("success", "Classe enregistrée avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
        }
        return "redirect:/classes";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Classe> classe = classeService.findById(id);
        if (classe.isPresent()) {
            model.addAttribute("classe", classe.get());
            model.addAttribute("filieres", filiereService.findAll());
            return "classes/form";
        }
        redirectAttributes.addFlashAttribute("error", "Classe non trouvée");
        return "redirect:/classes";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            classeService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Classe supprimée");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/classes";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Classe> classe = classeService.findById(id);
        if (classe.isPresent()) {
            model.addAttribute("classe", classe.get());
            model.addAttribute("etudiantsDisponibles", etudiantService.findAll());
            return "classes/details";
        }
        redirectAttributes.addFlashAttribute("error", "Classe non trouvée");
        return "redirect:/classes";
    }

    @PostMapping("/{classeId}/ajouter-etudiant")
    public String ajouterEtudiant(@PathVariable Long classeId, @RequestParam Long etudiantId,
                                  RedirectAttributes redirectAttributes) {
        try {
            etudiantService.findById(etudiantId).ifPresent(e -> {
                classeService.addEtudiant(classeId, e);
                redirectAttributes.addFlashAttribute("success", "Étudiant ajouté à la classe");
            });
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
        }
        return "redirect:/classes/details/" + classeId;
    }

    @GetMapping("/{classeId}/retirer-etudiant/{etudiantId}")
    public String retirerEtudiant(@PathVariable Long classeId, @PathVariable Long etudiantId,
                                  RedirectAttributes redirectAttributes) {
        try {
            classeService.removeEtudiant(classeId, etudiantId);
            redirectAttributes.addFlashAttribute("success", "Étudiant retiré de la classe");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
        }
        return "redirect:/classes/details/" + classeId;
    }
}