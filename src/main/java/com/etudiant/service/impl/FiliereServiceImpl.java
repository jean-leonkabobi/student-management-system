package com.etudiant.service.impl;

import com.etudiant.model.Filiere;
import com.etudiant.repository.FiliereRepository;
import com.etudiant.service.FiliereService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FiliereServiceImpl implements FiliereService {

    private final FiliereRepository filiereRepository;

    public FiliereServiceImpl(FiliereRepository filiereRepository) {
        this.filiereRepository = filiereRepository;
    }

    @Override
    public Filiere save(Filiere filiere) {
        return filiereRepository.save(filiere);
    }

    @Override
    public Optional<Filiere> findById(Long id) {
        return filiereRepository.findById(id);
    }

    @Override
    public Optional<Filiere> findByCode(String code) {
        return filiereRepository.findByCode(code);
    }

    @Override
    public List<Filiere> findAll() {
        return filiereRepository.findAll();
    }

    @Override
    public Filiere update(Long id, Filiere filiere) {
        Filiere existing = filiereRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Filière non trouvée avec l'id : " + id));
        existing.setCode(filiere.getCode());
        existing.setNom(filiere.getNom());
        existing.setDescription(filiere.getDescription());
        return filiereRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        filiereRepository.deleteById(id);
    }

    @Override
    public boolean existsByCode(String code) {
        return filiereRepository.existsByCode(code);
    }

    @Override
    public long count() {
        return filiereRepository.count();
    }
}