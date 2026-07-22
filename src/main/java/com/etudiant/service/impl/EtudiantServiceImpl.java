package com.etudiant.service;

import com.etudiant.model.Etudiant;
import com.etudiant.repository.EtudiantRepository;
import org.springframework.stereotype.Service;

import java.time.Year;
import java.util.List;
import java.util.Optional;

@Service
public class EtudiantServiceImpl implements EtudiantService {

    private final EtudiantRepository etudiantRepository;

    public EtudiantServiceImpl(EtudiantRepository etudiantRepository) {
        this.etudiantRepository = etudiantRepository;
    }

    @Override
    public Etudiant save(Etudiant etudiant) {
        if (etudiant.getMatricule() == null || etudiant.getMatricule().isEmpty()) {
            etudiant.setMatricule(generateMatricule());
        }
        return etudiantRepository.save(etudiant);
    }

    @Override
    public Optional<Etudiant> findById(Long id) {
        return etudiantRepository.findById(id);
    }

    @Override
    public Optional<Etudiant> findByMatricule(String matricule) {
        return etudiantRepository.findByMatricule(matricule);
    }

    @Override
    public List<Etudiant> findAll() {
        return etudiantRepository.findAll();
    }

    @Override
    public List<Etudiant> search(String keyword) {
        return etudiantRepository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(keyword, keyword);
    }

    @Override
    public Etudiant update(Long id, Etudiant etudiant) {
        Etudiant existing = etudiantRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Étudiant non trouvé avec l'id : " + id));
        existing.setNom(etudiant.getNom());
        existing.setPrenom(etudiant.getPrenom());
        existing.setDateNaissance(etudiant.getDateNaissance());
        existing.setEmail(etudiant.getEmail());
        existing.setTelephone(etudiant.getTelephone());
        existing.setAdresse(etudiant.getAdresse());
        if (etudiant.getPhoto() != null) {
            existing.setPhoto(etudiant.getPhoto());
        }
        return etudiantRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        etudiantRepository.deleteById(id);
    }

    @Override
    public boolean existsByMatricule(String matricule) {
        return etudiantRepository.existsByMatricule(matricule);
    }

    @Override
    public long count() {
        return etudiantRepository.count();
    }

    @Override
    public String generateMatricule() {
        String year = String.valueOf(Year.now().getValue());
        long count = etudiantRepository.count() + 1;
        return "ETU" + year + String.format("%04d", count);
    }
}