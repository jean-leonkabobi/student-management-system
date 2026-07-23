package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.service.EtudiantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/etudiants")
public class EtudiantController {

    private final EtudiantService etudiantService;
    private static final String UPLOAD_DIR = "src/main/webapp/static/uploads/";

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
    public String save(@ModelAttribute("etudiant") Etudiant etudiant,
                       @RequestParam(value = "photoFile", required = false) MultipartFile photoFile,
                       RedirectAttributes redirectAttributes) {
        try {
            // Gestion de l'upload photo
            if (photoFile != null && !photoFile.isEmpty()) {
                String fileName = UUID.randomUUID().toString() + "_" + photoFile.getOriginalFilename();
                Path uploadPath = Paths.get(UPLOAD_DIR);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                Files.copy(photoFile.getInputStream(), uploadPath.resolve(fileName));
                etudiant.setPhoto("/uploads/" + fileName);
            }

            etudiantService.save(etudiant);
            redirectAttributes.addFlashAttribute("success", "Étudiant enregistré avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
            e.printStackTrace();
        }
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