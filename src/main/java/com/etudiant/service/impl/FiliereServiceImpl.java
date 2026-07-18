package com.etudiant.service.impl;

import com.etudiant.model.Filiere;
import com.etudiant.repository.FiliereRepository;
import com.etudiant.service.FiliereService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class FiliereServiceImpl implements FiliereService {

    private final FiliereRepository filiereRepository;

    @Override
    public List<Filiere> findAll() {
        return filiereRepository.findAll();
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
    public Filiere save(Filiere filiere) {
        return filiereRepository.save(filiere);
    }

    @Override
    public void deleteById(Long id) {
        filiereRepository.deleteById(id);
    }

    @Override
    public boolean existsByCode(String code) {
        return filiereRepository.existsByCode(code);
    }
}