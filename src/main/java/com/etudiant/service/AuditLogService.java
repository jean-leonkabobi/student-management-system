package com.etudiant.service;

import com.etudiant.model.AuditLog;
import com.etudiant.model.Utilisateur;

import java.util.List;

public interface AuditLogService {

    List<AuditLog> findAll();

    AuditLog findById(Long id);

    AuditLog logAction(Utilisateur utilisateur, String action, String entite, Long entiteId,
                       String anciennesValeurs, String nouvellesValeurs, String ipAddress, String userAgent);

    List<AuditLog> findByUtilisateur(Long utilisateurId);

    List<AuditLog> findByEntite(String entite);

    List<AuditLog> findByAction(String action);
}