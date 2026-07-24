package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.service.EtudiantService;
import com.etudiant.utils.ExcelExportUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import javax.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
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
    public String liste(Model model, @RequestParam(required = false) String search,
                        @RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Etudiant> etudiantPage;

        if (search != null && !search.isEmpty()) {
            etudiantPage = etudiantService.searchPaginated(search, pageable);
            model.addAttribute("search", search);
        } else {
            etudiantPage = etudiantService.findAllPaginated(pageable);
        }

        model.addAttribute("etudiants", etudiantPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", etudiantPage.getTotalPages());
        model.addAttribute("totalItems", etudiantPage.getTotalElements());
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

    @GetMapping("/export/excel")
    public void exportExcel(HttpServletResponse response) {
        List<Etudiant> etudiants = etudiantService.findAll();
        ExcelExportUtil.exportEtudiants(etudiants, response);
    }
}