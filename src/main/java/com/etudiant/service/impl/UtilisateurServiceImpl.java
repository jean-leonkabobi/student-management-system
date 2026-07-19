package com.etudiant.service.impl;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Utilisateur.Role;
import com.etudiant.repository.UtilisateurRepository;
import com.etudiant.service.UtilisateurService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class UtilisateurServiceImpl implements UtilisateurService {

    private final UtilisateurRepository utilisateurRepository;

    @Override
    public List<Utilisateur> findAll() {
        return utilisateurRepository.findAll();
    }

    @Override
    public Optional<Utilisateur> findById(Long id) {
        return utilisateurRepository.findById(id);
    }

    @Override
    public Optional<Utilisateur> findByUsername(String username) {
        return utilisateurRepository.findByUsername(username);
    }

    @Override
    public Optional<Utilisateur> findByEmail(String email) {
        return utilisateurRepository.findByEmail(email);
    }

    @Override
    public List<Utilisateur> findByRole(Role role) {
        return utilisateurRepository.findByRole(role);
    }

    @Override
    public List<Utilisateur> findByEstActif(Boolean estActif) {
        return utilisateurRepository.findByEstActif(estActif);
    }

    @Override
    public Utilisateur save(Utilisateur utilisateur) {
        log.info("Sauvegarde d'un utilisateur: {}", utilisateur.getUsername());

        // Hacher le mot de passe
        utilisateur.setPasswordHash(hashPassword(utilisateur.getPasswordHash()));

        return utilisateurRepository.save(utilisateur);
    }

    @Override
    public Utilisateur update(Utilisateur utilisateur) {
        log.info("Mise à jour de l'utilisateur ID: {}", utilisateur.getId());
        return utilisateurRepository.save(utilisateur);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de l'utilisateur ID: {}", id);
        utilisateurRepository.deleteById(id);
    }

    @Override
    public void activerUtilisateur(Long id) {
        utilisateurRepository.findById(id).ifPresent(u -> {
            u.setEstActif(true);
            utilisateurRepository.save(u);
            log.info("Utilisateur activé: {}", u.getUsername());
        });
    }

    @Override
    public void desactiverUtilisateur(Long id) {
        utilisateurRepository.findById(id).ifPresent(u -> {
            u.setEstActif(false);
            utilisateurRepository.save(u);
            log.info("Utilisateur désactivé: {}", u.getUsername());
        });
    }

    @Override
    public boolean authenticate(String username, String password) {
        return utilisateurRepository.findByUsername(username)
                .map(u -> {
                    // Vérifier le mot de passe (haché)
                    boolean isValid = u.getPasswordHash().equals(hashPassword(password));
                    if (isValid) {
                        u.setDerniereConnexion(LocalDateTime.now());
                        utilisateurRepository.save(u);
                    }
                    return isValid;
                })
                .orElse(false);
    }

    @Override
    public String hashPassword(String password) {
        // Pour le moment, hashage simple (à remplacer par BCrypt en production)
        return Integer.toHexString(password.hashCode());
    }
}