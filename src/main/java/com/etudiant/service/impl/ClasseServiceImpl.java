package com.etudiant.service;

import com.etudiant.model.Classe;
import com.etudiant.model.Etudiant;
import com.etudiant.repository.ClasseRepository;
import com.etudiant.repository.EtudiantRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ClasseServiceImpl implements ClasseService {

    private final ClasseRepository classeRepository;
    private final EtudiantRepository etudiantRepository;

    public ClasseServiceImpl(ClasseRepository classeRepository, EtudiantRepository etudiantRepository) {
        this.classeRepository = classeRepository;
        this.etudiantRepository = etudiantRepository;
    }

    @Override
    public Classe save(Classe classe) {
        return classeRepository.save(classe);
    }

    @Override
    public Optional<Classe> findById(Long id) {
        return classeRepository.findById(id);
    }

    @Override
    public List<Classe> findAll() {
        return classeRepository.findAll();
    }

    @Override
    public List<Classe> findByFiliereId(Long filiereId) {
        return classeRepository.findByFiliereId(filiereId);
    }

    @Override
    public List<Classe> findByNiveau(String niveau) {
        return classeRepository.findByNiveau(niveau);
    }

    @Override
    public List<Classe> findByFiliereIdAndNiveau(Long filiereId, String niveau) {
        return classeRepository.findByFiliereIdAndNiveau(filiereId, niveau);
    }

    @Override
    public Classe update(Long id, Classe classe) {
        Classe existing = classeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'id : " + id));
        existing.setNom(classe.getNom());
        existing.setNiveau(classe.getNiveau());
        existing.setFiliere(classe.getFiliere());
        return classeRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        classeRepository.deleteById(id);
    }

    @Override
    public void addEtudiant(Long classeId, Etudiant etudiant) {
        Classe classe = classeRepository.findById(classeId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée"));
        classe.getEtudiants().add(etudiant);
        classeRepository.save(classe);
    }

    @Override
    public void removeEtudiant(Long classeId, Long etudiantId) {
        Classe classe = classeRepository.findById(classeId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée"));
        classe.getEtudiants().removeIf(e -> e.getId().equals(etudiantId));
        classeRepository.save(classe);
    }

    @Override
    public long count() {
        return classeRepository.count();
    }
}