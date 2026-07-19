package com.etudiant.repository;

import com.etudiant.model.RecuPaiement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecuPaiementRepository extends JpaRepository<RecuPaiement, Long> {

    List<RecuPaiement> findByPaiementId(Long paiementId);
}