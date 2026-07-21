package com.etudiant.repository;

import com.etudiant.model.EmploiDuTemps;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmploiDuTempsRepository extends JpaRepository<EmploiDuTemps, Long> {

    List<EmploiDuTemps> findByEnseignantId(Long enseignantId);

    List<EmploiDuTemps> findByEnseignantIdAndJour(Long enseignantId, String jour);

    List<EmploiDuTemps> findByEnseignantIdOrderByJourAscHeureDebutAsc(Long enseignantId);
}