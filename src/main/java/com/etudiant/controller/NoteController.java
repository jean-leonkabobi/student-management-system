package com.etudiant.controller;

import com.etudiant.model.Note;
import com.etudiant.model.Note.Session;
import com.etudiant.service.InscriptionService;
import com.etudiant.service.MatiereService;
import com.etudiant.service.NoteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/notes")
@RequiredArgsConstructor
@Slf4j
public class NoteController {

    private final NoteService noteService;
    private final InscriptionService inscriptionService;
    private final MatiereService matiereService;

    /**
     * Liste des notes par inscription
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) Long matiereId,
            Model model) {

        log.debug("Affichage de la liste des notes");

        if (inscriptionId != null) {
            List<Note> notes = noteService.findByInscriptionId(inscriptionId);
            model.addAttribute("notes", notes);
            model.addAttribute("inscription", inscriptionService.findById(inscriptionId).orElse(null));

            // Calculer la moyenne générale
            BigDecimal moyenne = noteService.calculerMoyenneGenerale(inscriptionId);
            model.addAttribute("moyenneGenerale", moyenne);

        } else if (matiereId != null) {
            model.addAttribute("notes", noteService.findByMatiereId(matiereId));
            model.addAttribute("matiere", matiereService.findById(matiereId).orElse(null));
        } else {
            model.addAttribute("notes", noteService.findAll());
        }

        model.addAttribute("inscriptions", inscriptionService.findAll());
        model.addAttribute("matieres", matiereService.findAll());
        model.addAttribute("sessions", Session.values());
        model.addAttribute("pageActive", "notes");
        model.addAttribute("pageTitle", "Liste des Notes");

        return "notes/liste";
    }

    /**
     * Formulaire de saisie d'une note
     */
    @GetMapping("/saisie")
    public String saisieForm(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) Long matiereId,
            Model model) {

        log.debug("Affichage du formulaire de saisie de note");

        Note note = new Note();

        if (inscriptionId != null) {
            inscriptionService.findById(inscriptionId).ifPresent(note::setInscription);
        }
        if (matiereId != null) {
            matiereService.findById(matiereId).ifPresent(note::setMatiere);
        }

        model.addAttribute("note", note);
        model.addAttribute("inscriptions", inscriptionService.findAll());
        model.addAttribute("matieres", matiereService.findAll());
        model.addAttribute("sessions", Session.values());
        model.addAttribute("pageActive", "notes");
        model.addAttribute("pageTitle", "Saisie d'une Note");

        return "notes/saisie";
    }

    /**
     * Traite la saisie d'une note
     */
    @PostMapping("/saisie")
    public String saisie(
            @Valid @ModelAttribute("note") Note note,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de la saisie d'une note");

        // Vérifier si une note existe déjà pour cette combinaison
        noteService.findByInscriptionAndMatiereAndSession(
                        note.getInscription().getId(),
                        note.getMatiere().getId(),
                        note.getSession())
                .ifPresent(existing -> {
                    result.rejectValue("matiere", "error.note",
                            "Une note existe déjà pour cette matière et cette session");
                });

        if (result.hasErrors()) {
            model.addAttribute("inscriptions", inscriptionService.findAll());
            model.addAttribute("matieres", matiereService.findAll());
            model.addAttribute("sessions", Session.values());
            model.addAttribute("pageActive", "notes");
            model.addAttribute("pageTitle", "Saisie d'une Note");
            return "notes/saisie";
        }

        try {
            noteService.save(note);
            log.info("Note saisie avec succès");

            redirectAttributes.addFlashAttribute("success", "Note saisie avec succès !");

            return "redirect:/notes?inscriptionId=" + note.getInscription().getId();

        } catch (Exception e) {
            log.error("Erreur lors de la saisie: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de la saisie: " + e.getMessage());
            return "redirect:/notes/saisie";
        }
    }

    /**
     * Modifier une note
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        log.debug("Affichage du formulaire de modification de la note ID: {}", id);

        return noteService.findById(id)
                .map(note -> {
                    model.addAttribute("note", note);
                    model.addAttribute("inscriptions", inscriptionService.findAll());
                    model.addAttribute("matieres", matiereService.findAll());
                    model.addAttribute("sessions", Session.values());
                    model.addAttribute("pageActive", "notes");
                    model.addAttribute("pageTitle", "Modifier une Note");
                    return "notes/modifier";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Note non trouvée");
                    return "redirect:/notes";
                });
    }

    /**
     * Traite la modification d'une note
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute("note") Note note,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.debug("Traitement de la modification de la note ID: {}", note.getId());

        if (result.hasErrors()) {
            model.addAttribute("inscriptions", inscriptionService.findAll());
            model.addAttribute("matieres", matiereService.findAll());
            model.addAttribute("sessions", Session.values());
            model.addAttribute("pageActive", "notes");
            model.addAttribute("pageTitle", "Modifier une Note");
            return "notes/modifier";
        }

        try {
            noteService.update(note);
            log.info("Note modifiée avec succès");

            redirectAttributes.addFlashAttribute("success", "Note modifiée avec succès !");

            return "redirect:/notes?inscriptionId=" + note.getInscription().getId();

        } catch (Exception e) {
            log.error("Erreur lors de la modification: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de la modification: " + e.getMessage());
            return "redirect:/notes/modifier/" + note.getId();
        }
    }

    /**
     * Supprimer une note
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        log.debug("Suppression de la note ID: {}", id);

        try {
            Note note = noteService.findById(id).orElse(null);
            noteService.deleteById(id);

            redirectAttributes.addFlashAttribute("success", "Note supprimée avec succès !");

            if (note != null) {
                return "redirect:/notes?inscriptionId=" + note.getInscription().getId();
            }

        } catch (Exception e) {
            log.error("Erreur lors de la suppression: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "Impossible de supprimer cette note: " + e.getMessage());
        }

        return "redirect:/notes";
    }
}