package com.etudiant.service.impl;

import com.etudiant.model.Note;
import com.etudiant.model.Note.Session;
import com.etudiant.repository.NoteRepository;
import com.etudiant.service.NoteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class NoteServiceImpl implements NoteService {

    private final NoteRepository noteRepository;

    @Override
    public List<Note> findAll() {
        return noteRepository.findAll();
    }

    @Override
    public Optional<Note> findById(Long id) {
        return noteRepository.findById(id);
    }

    @Override
    public List<Note> findByInscriptionId(Long inscriptionId) {
        return noteRepository.findByInscriptionId(inscriptionId);
    }

    @Override
    public List<Note> findByMatiereId(Long matiereId) {
        return noteRepository.findByMatiereId(matiereId);
    }

    @Override
    public List<Note> findByInscriptionAndSession(Long inscriptionId, Session session) {
        return noteRepository.findByInscriptionIdAndSession(inscriptionId, session);
    }

    @Override
    public Optional<Note> findByInscriptionAndMatiereAndSession(Long inscriptionId, Long matiereId, Session session) {
        return noteRepository.findByInscriptionIdAndMatiereIdAndSession(inscriptionId, matiereId, session);
    }

    @Override
    public BigDecimal calculerMoyenneGenerale(Long inscriptionId) {
        List<Note> notes = noteRepository.findByInscriptionId(inscriptionId);

        if (notes.isEmpty()) {
            return BigDecimal.ZERO;
        }

        // Calcul de la moyenne pondérée par les crédits
        BigDecimal totalPoints = BigDecimal.ZERO;
        int totalCredits = 0;

        for (Note note : notes) {
            if (note.getMoyenne() != null) {
                totalPoints = totalPoints.add(note.getMoyenne().multiply(BigDecimal.valueOf(note.getMatiere().getCredit())));
                totalCredits += note.getMatiere().getCredit();
            }
        }

        if (totalCredits == 0) {
            return BigDecimal.ZERO;
        }

        return totalPoints.divide(BigDecimal.valueOf(totalCredits), 2, RoundingMode.HALF_UP);
    }

    @Override
    public Note save(Note note) {
        log.info("Sauvegarde d'une note");
        note.calculerMoyenne();
        return noteRepository.save(note);
    }

    @Override
    public Note update(Note note) {
        log.info("Mise à jour de la note ID: {}", note.getId());
        note.calculerMoyenne();
        return noteRepository.save(note);
    }

    @Override
    public void deleteById(Long id) {
        log.info("Suppression de la note ID: {}", id);
        noteRepository.deleteById(id);
    }
}