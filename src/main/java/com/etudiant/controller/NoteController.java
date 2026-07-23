package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Matiere;
import com.etudiant.model.Note;
import com.etudiant.service.EtudiantService;
import com.etudiant.service.MatiereService;
import com.etudiant.service.NoteService;
import com.etudiant.utils.PdfExportUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/notes")
public class NoteController {

    private final NoteService noteService;
    private final EtudiantService etudiantService;
    private final MatiereService matiereService;

    public NoteController(NoteService noteService, EtudiantService etudiantService,
                          MatiereService matiereService) {
        this.noteService = noteService;
        this.etudiantService = etudiantService;
        this.matiereService = matiereService;
    }

    @GetMapping
    public String liste(Model model, @RequestParam(required = false) Long etudiantId,
                        @RequestParam(required = false) String semestre) {
        model.addAttribute("etudiants", etudiantService.findAll());
        if (etudiantId != null && semestre != null && !semestre.isEmpty()) {
            model.addAttribute("notes", noteService.findByEtudiantIdAndSemestre(etudiantId, semestre));
            model.addAttribute("selectedEtudiant", etudiantId);
            model.addAttribute("selectedSemestre", semestre);
        } else if (etudiantId != null) {
            model.addAttribute("notes", noteService.findByEtudiantId(etudiantId));
            model.addAttribute("selectedEtudiant", etudiantId);
        } else {
            model.addAttribute("notes", noteService.findAll());
        }
        return "notes/liste";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("note", new Note());
        model.addAttribute("etudiants", etudiantService.findAll());
        model.addAttribute("matieres", matiereService.findAll());
        return "notes/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("note") Note note,
                       @RequestParam("etudiantId") Long etudiantId,
                       @RequestParam("matiereId") Long matiereId,
                       RedirectAttributes redirectAttributes) {
        try {
            Optional<Etudiant> etudiant = etudiantService.findById(etudiantId);
            Optional<Matiere> matiere = matiereService.findById(matiereId);

            if (etudiant.isPresent() && matiere.isPresent()) {
                note.setEtudiant(etudiant.get());
                note.setMatiere(matiere.get());
                noteService.save(note);
                redirectAttributes.addFlashAttribute("success", "Note enregistrée avec succès !");
            } else {
                redirectAttributes.addFlashAttribute("error", "Étudiant ou matière introuvable");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur : " + e.getMessage());
        }
        return "redirect:/notes";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Note> note = noteService.findById(id);
        if (note.isPresent()) {
            model.addAttribute("note", note.get());
            model.addAttribute("etudiants", etudiantService.findAll());
            model.addAttribute("matieres", matiereService.findAll());
            return "notes/form";
        }
        redirectAttributes.addFlashAttribute("error", "Note non trouvée");
        return "redirect:/notes";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            noteService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Note supprimée");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/notes";
    }

    @GetMapping("/releve/{etudiantId}")
    public String releveNotes(@PathVariable Long etudiantId, Model model,
                              RedirectAttributes redirectAttributes) {
        Optional<Etudiant> etudiant = etudiantService.findById(etudiantId);
        if (etudiant.isPresent()) {
            model.addAttribute("etudiant", etudiant.get());
            model.addAttribute("notes", noteService.findByEtudiantId(etudiantId));
            return "notes/releve";
        }
        redirectAttributes.addFlashAttribute("error", "Étudiant non trouvé");
        return "redirect:/notes";
    }

    @GetMapping("/releve/pdf/{etudiantId}")
    public void exportPdf(@PathVariable Long etudiantId, HttpServletResponse response) {
        Optional<Etudiant> etudiant = etudiantService.findById(etudiantId);
        if (etudiant.isPresent()) {
            List<Note> notes = noteService.findByEtudiantId(etudiantId);
            PdfExportUtil.exportReleveNotes(etudiant.get(), notes, response);
        }
    }
}