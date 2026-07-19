package com.etudiant.service.impl;

import com.etudiant.model.Matiere;
import com.etudiant.model.Matiere.Semestre;
import com.etudiant.repository.MatiereRepository;
import com.etudiant.service.MatiereService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class MatiereServiceImpl implements MatiereService {

    private final MatiereRepository matiereRepository;

    @Override
    public List<Matiere> findAll() {
        return matiereRepository.findAll();
    }

    @Override
    public Optional<Matiere> findById(Long id) {
        return matiereRepository.findById(id);
    }

    @Override
    public Optional<Matiere> findByCode(String code) {
        return matiereRepository.findByCode(code);
    }

    @Override
    public List<Matiere> findByFiliereId(Long filiereId) {
        return matiereRepository.findByFiliereId(filiereId);
    }

    @Override
    public List<Matiere> findByNiveauId(Long niveauId) {
        return matiereRepository.findByNiveauId(niveauId);
    }

    @Override
    public List<Matiere> findByFiliereAndNiveau(Long filiereId, Long niveauId) {
        return matiereRepository.findByFiliereIdAndNiveauId(filiereId, niveauId);
    }

    @Override
    public List<Matiere> findBySemestre(Semestre semestre) {
        return matiereRepository.findBySemestre(semestre);
    }

    @Override
    public Matiere save(Matiere matiere) {
        log.info("Sauvegarde de la matière: {}", matiere.getCode());
        return matiereRepository.save(matiere);
    }

    @Override
    public Matiere update(Matiere matiere) {
        log.info("Mise à jour de la matière ID: {}", matiere.getId());
        return matiereRepository.save(matiere);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de la matière ID: {}", id);
        matiereRepository.deleteById(id);
    }

    @Override
    public boolean existsByCode(String code) {
        return matiereRepository.existsByCode(code);
    }
}