package com.etudiant.service.impl;

import com.etudiant.model.Niveau;
import com.etudiant.repository.NiveauRepository;
import com.etudiant.service.NiveauService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class NiveauServiceImpl implements NiveauService {

    private final NiveauRepository niveauRepository;

    @Override
    public List<Niveau> findAll() {
        return niveauRepository.findAllByOrderByOrdreAsc();
    }

    @Override
    public Optional<Niveau> findById(Long id) {
        return niveauRepository.findById(id);
    }

    @Override
    public Optional<Niveau> findByCode(String code) {
        return niveauRepository.findByCode(code);
    }

    @Override
    public Niveau save(Niveau niveau) {
        return niveauRepository.save(niveau);
    }

    @Override
    public void deleteById(Long id) {
        niveauRepository.deleteById(id);
    }
}