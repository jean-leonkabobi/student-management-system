package com.etudiant.controller;

import com.etudiant.model.Utilisateur;
import com.etudiant.service.UtilisateurService;
import com.etudiant.utils.PasswordUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
public class LoginController {

    private final UtilisateurService utilisateurService;

    public LoginController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String authenticate(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        System.out.println("=== TENTATIVE CONNEXION : " + username + " ===");

        Optional<Utilisateur> userOpt = utilisateurService.findByUsername(username);

        if (userOpt.isPresent() && PasswordUtil.verify(password, userOpt.get().getPassword()) && userOpt.get().getActif()) {
            Utilisateur user = userOpt.get();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userPrenom", user.getPrenom());
            session.setAttribute("userNom", user.getNom());
            System.out.println("=== CONNEXION RÉUSSIE : " + username + " | Rôle : " + user.getRole() + " ===");
            return "redirect:/";
        }

        System.out.println("=== ÉCHEC CONNEXION : " + username + " ===");
        redirectAttributes.addFlashAttribute("error", "Identifiants incorrects");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout";
    }
}