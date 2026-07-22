package com.etudiant.repository;

import com.etudiant.model.Classe;
import com.etudiant.model.Filiere;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClasseRepository extends JpaRepository<Classe, Long> {

    List<Classe> findByFiliere(Filiere filiere);

    List<Classe> findByFiliereId(Long filiereId);

    List<Classe> findByNiveau(String niveau);

    List<Classe> findByFiliereIdAndNiveau(Long filiereId, String niveau);
}