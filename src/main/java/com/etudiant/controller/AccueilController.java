package com.etudiant.controller;

import com.etudiant.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccueilController {

    private final EtudiantService etudiantService;
    private final EnseignantService enseignantService;
    private final FiliereService filiereService;
    private final ClasseService classeService;
    private final MatiereService matiereService;

    public AccueilController(EtudiantService etudiantService, EnseignantService enseignantService,
                             FiliereService filiereService, ClasseService classeService,
                             MatiereService matiereService) {
        this.etudiantService = etudiantService;
        this.enseignantService = enseignantService;
        this.filiereService = filiereService;
        this.classeService = classeService;
        this.matiereService = matiereService;
    }

    @GetMapping("/")
    public String accueil(Model model) {
        model.addAttribute("nbEtudiants", etudiantService.count());
        model.addAttribute("nbEnseignants", enseignantService.count());
        model.addAttribute("nbFilieres", filiereService.count());
        model.addAttribute("nbClasses", classeService.count());
        model.addAttribute("nbMatieres", matiereService.count());
        return "accueil";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }
}