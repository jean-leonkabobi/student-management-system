package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.service.UtilisateurService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    private final UtilisateurService utilisateurService;

    @GetMapping("/login")
    public String loginPage(HttpSession session, Model model) {
        // Si déjà connecté, rediriger vers le dashboard
        if (session.getAttribute("utilisateur") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {

        log.debug("Tentative de connexion: {}", username);

        if (utilisateurService.authenticate(username, password)) {
            Utilisateur utilisateur = utilisateurService.findByUsername(username).orElse(null);
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("role", utilisateur != null ? utilisateur.getRole() : null);

            log.info("Utilisateur connecté: {}", username);
            return "redirect:/dashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("utilisateur", new Utilisateur());
        return "register";
    }

    @PostMapping("/register")
    public String register(Utilisateur utilisateur,
                           @RequestParam String confirmPassword,
                           RedirectAttributes redirectAttributes) {

        if (!utilisateur.getPasswordHash().equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Les mots de passe ne correspondent pas");
            return "redirect:/register";
        }

        if (utilisateurService.findByUsername(utilisateur.getUsername()).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Ce nom d'utilisateur existe déjà");
            return "redirect:/register";
        }

        utilisateurService.save(utilisateur);
        redirectAttributes.addFlashAttribute("success", "Inscription réussie ! Connectez-vous.");
        return "redirect:/login";
    }
}