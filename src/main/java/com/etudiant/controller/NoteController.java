package com.etudiant.controller;

import com.etudiant.model.Note;
import com.etudiant.model.Note.Session;
import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
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

import javax.servlet.http.HttpSession;
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

    // ==========================================
    // MÉTHODES DE VÉRIFICATION
    // ==========================================

    private boolean isAdminOrScolarite(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        Role role = utilisateur.getRole();
        return role == Role.ADMIN || role == Role.SCOLARITE;
    }

    private boolean isEnseignant(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        return utilisateur.getRole() == Role.ENSEIGNANT;
    }

    private boolean isEtudiant(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) return false;
        return utilisateur.getRole() == Role.ETUDIANT;
    }

    private Role getRole(HttpSession session) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        return utilisateur != null ? utilisateur.getRole() : null;
    }

    // ==========================================
    // MÉTHODES
    // ==========================================

    /**
     * Liste des notes - Adaptée selon le rôle
     */
    @GetMapping
    public String liste(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) Long matiereId,
            HttpSession session,
            Model model) {

        log.debug("Affichage de la liste des notes");

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        Role role = utilisateur != null ? utilisateur.getRole() : null;

        List<Note> notes;
        List<com.etudiant.model.Inscription> inscriptions;

        // Si l'utilisateur est un étudiant, filtrer par ses inscriptions
        if (isEtudiant(session)) {
            if (utilisateur.getEtudiant() != null) {
                Long etudiantId = utilisateur.getEtudiant().getId();
                inscriptions = inscriptionService.findByEtudiantId(etudiantId);

                if (inscriptionId != null) {
                    boolean hasAccess = inscriptions.stream().anyMatch(i -> i.getId().equals(inscriptionId));
                    if (hasAccess) {
                        notes = noteService.findByInscriptionId(inscriptionId);
                        model.addAttribute("inscription", inscriptionService.findById(inscriptionId).orElse(null));
                        BigDecimal moyenne = noteService.calculerMoyenneGenerale(inscriptionId);
                        model.addAttribute("moyenneGenerale", moyenne);
                    } else if (!inscriptions.isEmpty()) {
                        Long firstId = inscriptions.get(0).getId();
                        notes = noteService.findByInscriptionId(firstId);
                        model.addAttribute("inscription", inscriptions.get(0));
                        BigDecimal moyenne = noteService.calculerMoyenneGenerale(firstId);
                        model.addAttribute("moyenneGenerale", moyenne);
                    } else {
                        notes = List.of();
                        model.addAttribute("inscription", null);
                        model.addAttribute("moyenneGenerale", BigDecimal.ZERO);
                    }
                } else if (!inscriptions.isEmpty()) {
                    Long firstId = inscriptions.get(0).getId();
                    notes = noteService.findByInscriptionId(firstId);
                    model.addAttribute("inscription", inscriptions.get(0));
                    BigDecimal moyenne = noteService.calculerMoyenneGenerale(firstId);
                    model.addAttribute("moyenneGenerale", moyenne);
                } else {
                    notes = List.of();
                    model.addAttribute("inscription", null);
                    model.addAttribute("moyenneGenerale", BigDecimal.ZERO);
                }

                model.addAttribute("inscriptions", inscriptions);
                model.addAttribute("isEtudiant", true);
            } else {
                notes = List.of();
                inscriptions = List.of();
                model.addAttribute("inscriptions", inscriptions);
                model.addAttribute("isEtudiant", true);
                model.addAttribute("moyenneGenerale", BigDecimal.ZERO);
            }

            model.addAttribute("matieres", List.of());

        } else {
            // ADMIN, SCOLARITE, ENSEIGNANT - accès complet
            if (inscriptionId != null) {
                notes = noteService.findByInscriptionId(inscriptionId);
                model.addAttribute("inscription", inscriptionService.findById(inscriptionId).orElse(null));
                BigDecimal moyenne = noteService.calculerMoyenneGenerale(inscriptionId);
                model.addAttribute("moyenneGenerale", moyenne);
            } else if (matiereId != null) {
                notes = noteService.findByMatiereId(matiereId);
                model.addAttribute("matiere", matiereService.findById(matiereId).orElse(null));
            } else {
                notes = noteService.findAll();
            }

            model.addAttribute("inscriptions", inscriptionService.findAll());
            model.addAttribute("matieres", matiereService.findAll());
            model.addAttribute("isEtudiant", false);
        }

        model.addAttribute("notes", notes);
        model.addAttribute("sessions", Session.values());
        model.addAttribute("pageActive", "notes");
        model.addAttribute("pageTitle", isEtudiant(session) ? "Mes Notes" : "Liste des Notes");
        model.addAttribute("role", getRole(session));

        return "notes/liste";
    }

    /**
     * Formulaire de saisie - ADMIN, SCOLARITE et ENSEIGNANT
     */
    @GetMapping("/saisie")
    public String saisieForm(
            @RequestParam(required = false) Long inscriptionId,
            @RequestParam(required = false) Long matiereId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de saisir des notes.");
            return "redirect:/notes";
        }

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
        model.addAttribute("role", getRole(session));

        return "notes/saisie";
    }

    /**
     * Traite la saisie d'une note - ADMIN, SCOLARITE et ENSEIGNANT
     */
    @PostMapping("/saisie")
    public String saisie(
            @Valid @ModelAttribute("note") Note note,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de saisir des notes.");
            return "redirect:/notes";
        }

        log.debug("Traitement de la saisie d'une note");

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
     * Modifier une note - ADMIN, SCOLARITE et ENSEIGNANT
     */
    @GetMapping("/modifier/{id}")
    public String modifierForm(
            @PathVariable Long id,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de modifier des notes.");
            return "redirect:/notes";
        }

        log.debug("Affichage du formulaire de modification de la note ID: {}", id);

        return noteService.findById(id)
                .map(note -> {
                    model.addAttribute("note", note);
                    model.addAttribute("inscriptions", inscriptionService.findAll());
                    model.addAttribute("matieres", matiereService.findAll());
                    model.addAttribute("sessions", Session.values());
                    model.addAttribute("pageActive", "notes");
                    model.addAttribute("pageTitle", "Modifier une Note");
                    model.addAttribute("role", getRole(session));
                    return "notes/modifier";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Note non trouvée");
                    return "redirect:/notes";
                });
    }

    /**
     * Traite la modification d'une note - ADMIN, SCOLARITE et ENSEIGNANT
     */
    @PostMapping("/modifier")
    public String modifier(
            @Valid @ModelAttribute("note") Note note,
            BindingResult result,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (isEtudiant(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de modifier des notes.");
            return "redirect:/notes";
        }

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
     * Supprimer une note - ADMIN et SCOLARITE uniquement
     */
    @GetMapping("/supprimer/{id}")
    public String supprimer(
            @PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdminOrScolarite(session)) {
            redirectAttributes.addFlashAttribute("error", "Vous n'avez pas le droit de supprimer des notes.");
            return "redirect:/notes";
        }

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