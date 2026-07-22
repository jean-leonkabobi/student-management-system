package com.etudiant.service;

import com.etudiant.model.Classe;
import com.etudiant.model.Etudiant;
import java.util.List;
import java.util.Optional;

public interface ClasseService {
    Classe save(Classe classe);
    Optional<Classe> findById(Long id);
    List<Classe> findAll();
    List<Classe> findByFiliereId(Long filiereId);
    List<Classe> findByNiveau(String niveau);
    List<Classe> findByFiliereIdAndNiveau(Long filiereId, String niveau);
    Classe update(Long id, Classe classe);
    void deleteById(Long id);
    void addEtudiant(Long classeId, Etudiant etudiant);
    void removeEtudiant(Long classeId, Long etudiantId);
    long count();
}