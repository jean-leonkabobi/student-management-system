package com.etudiant.service;

import com.etudiant.model.Enseignant;
import com.etudiant.repository.EnseignantRepository;
import org.springframework.stereotype.Service;

import java.time.Year;
import java.util.List;
import java.util.Optional;

@Service
public class EnseignantServiceImpl implements EnseignantService {

    private final EnseignantRepository enseignantRepository;

    public EnseignantServiceImpl(EnseignantRepository enseignantRepository) {
        this.enseignantRepository = enseignantRepository;
    }

    @Override
    public Enseignant save(Enseignant enseignant) {
        if (enseignant.getMatricule() == null || enseignant.getMatricule().isEmpty()) {
            enseignant.setMatricule(generateMatricule());
        }
        return enseignantRepository.save(enseignant);
    }

    @Override
    public Optional<Enseignant> findById(Long id) {
        return enseignantRepository.findById(id);
    }

    @Override
    public Optional<Enseignant> findByMatricule(String matricule) {
        return enseignantRepository.findByMatricule(matricule);
    }

    @Override
    public List<Enseignant> findAll() {
        return enseignantRepository.findAll();
    }

    @Override
    public List<Enseignant> search(String keyword) {
        return enseignantRepository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(keyword, keyword);
    }

    @Override
    public List<Enseignant> findByDepartement(String departement) {
        return enseignantRepository.findByDepartement(departement);
    }

    @Override
    public Enseignant update(Long id, Enseignant enseignant) {
        Enseignant existing = enseignantRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Enseignant non trouvé avec l'id : " + id));
        existing.setNom(enseignant.getNom());
        existing.setPrenom(enseignant.getPrenom());
        existing.setEmail(enseignant.getEmail());
        existing.setTelephone(enseignant.getTelephone());
        existing.setSpecialite(enseignant.getSpecialite());
        existing.setDepartement(enseignant.getDepartement());
        existing.setGrade(enseignant.getGrade());
        return enseignantRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        enseignantRepository.deleteById(id);
    }

    @Override
    public long count() {
        return enseignantRepository.count();
    }

    @Override
    public String generateMatricule() {
        String year = String.valueOf(Year.now().getValue());
        long count = enseignantRepository.count() + 1;
        return "ENS" + year + String.format("%04d", count);
    }
}