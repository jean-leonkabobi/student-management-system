package com.etudiant.service.impl;

import com.etudiant.model.Utilisateur;
import com.etudiant.repository.UtilisateurRepository;
import com.etudiant.service.UtilisateurService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UtilisateurServiceImpl implements UtilisateurService {

    private final UtilisateurRepository utilisateurRepository;

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepository) {
        this.utilisateurRepository = utilisateurRepository;
    }

    @Override
    public Utilisateur save(Utilisateur utilisateur) {
        return utilisateurRepository.save(utilisateur);
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
    public List<Utilisateur> findAll() {
        return utilisateurRepository.findAll();
    }

    @Override
    public Utilisateur update(Long id, Utilisateur utilisateur) {
        Utilisateur existing = utilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé avec l'id : " + id));
        existing.setUsername(utilisateur.getUsername());
        existing.setNom(utilisateur.getNom());
        existing.setPrenom(utilisateur.getPrenom());
        existing.setEmail(utilisateur.getEmail());
        existing.setRole(utilisateur.getRole());
        existing.setActif(utilisateur.getActif());
        if (utilisateur.getPassword() != null && !utilisateur.getPassword().isEmpty()) {
            existing.setPassword(utilisateur.getPassword());
        }
        return utilisateurRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        utilisateurRepository.deleteById(id);
    }

    @Override
    public boolean existsByUsername(String username) {
        return utilisateurRepository.existsByUsername(username);
    }

    @Override
    public boolean existsByEmail(String email) {
        return utilisateurRepository.existsByEmail(email);
    }

    @Override
    public long count() {
        return utilisateurRepository.count();
    }
}