package com.etudiant.repository;

import com.etudiant.model.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {

    List<AuditLog> findByUtilisateurIdOrderByDateActionDesc(Long utilisateurId);

    List<AuditLog> findByEntiteOrderByDateActionDesc(String entite);

    List<AuditLog> findByActionOrderByDateActionDesc(String action);
}