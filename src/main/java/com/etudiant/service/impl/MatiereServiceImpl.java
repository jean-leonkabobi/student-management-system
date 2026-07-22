package com.etudiant.service;

import com.etudiant.model.Matiere;
import com.etudiant.repository.MatiereRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MatiereServiceImpl implements MatiereService {

    private final MatiereRepository matiereRepository;

    public MatiereServiceImpl(MatiereRepository matiereRepository) {
        this.matiereRepository = matiereRepository;
    }

    @Override
    public Matiere save(Matiere matiere) {
        return matiereRepository.save(matiere);
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
    public List<Matiere> findAll() {
        return matiereRepository.findAll();
    }

    @Override
    public List<Matiere> findByFiliereId(Long filiereId) {
        return matiereRepository.findByFiliereId(filiereId);
    }

    @Override
    public List<Matiere> findByEnseignantId(Long enseignantId) {
        return matiereRepository.findByEnseignantId(enseignantId);
    }

    @Override
    public Matiere update(Long id, Matiere matiere) {
        Matiere existing = matiereRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Matière non trouvée avec l'id : " + id));
        existing.setCode(matiere.getCode());
        existing.setNom(matiere.getNom());
        existing.setCoefficient(matiere.getCoefficient());
        existing.setNombreHeures(matiere.getNombreHeures());
        existing.setEnseignant(matiere.getEnseignant());
        existing.setFiliere(matiere.getFiliere());
        return matiereRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        matiereRepository.deleteById(id);
    }

    @Override
    public boolean existsByCode(String code) {
        return matiereRepository.existsByCode(code);
    }

    @Override
    public long count() {
        return matiereRepository.count();
    }
}