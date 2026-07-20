package com.etudiant.service.impl;

import com.etudiant.model.AuditLog;
import com.etudiant.model.Utilisateur;
import com.etudiant.repository.AuditLogRepository;
import com.etudiant.service.AuditLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class AuditLogServiceImpl implements AuditLogService {

    private final AuditLogRepository auditLogRepository;

    @Override
    public List<AuditLog> findAll() {
        return auditLogRepository.findAll();
    }

    @Override
    public AuditLog findById(Long id) {
        return auditLogRepository.findById(id).orElse(null);
    }

    @Override
    public AuditLog logAction(Utilisateur utilisateur, String action, String entite, Long entiteId,
                              String anciennesValeurs, String nouvellesValeurs, String ipAddress, String userAgent) {
        log.info("Log d'action: {} - {}", action, entite);

        AuditLog auditLog = new AuditLog();
        auditLog.setUtilisateur(utilisateur);
        auditLog.setAction(action);
        auditLog.setEntite(entite);
        auditLog.setEntiteId(entiteId);
        auditLog.setAnciennesValeurs(anciennesValeurs);
        auditLog.setNouvellesValeurs(nouvellesValeurs);
        auditLog.setIpAddress(ipAddress);
        auditLog.setUserAgent(userAgent);
        auditLog.setDateAction(LocalDateTime.now());

        return auditLogRepository.save(auditLog);
    }

    @Override
    public List<AuditLog> findByUtilisateur(Long utilisateurId) {
        return auditLogRepository.findByUtilisateurIdOrderByDateActionDesc(utilisateurId);
    }

    @Override
    public List<AuditLog> findByEntite(String entite) {
        return auditLogRepository.findByEntiteOrderByDateActionDesc(entite);
    }

    @Override
    public List<AuditLog> findByAction(String action) {
        return auditLogRepository.findByActionOrderByDateActionDesc(action);
    }
}