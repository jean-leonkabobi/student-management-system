package com.etudiant.service;

import com.etudiant.model.Note;
import com.etudiant.model.Note.Session;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface NoteService {

    List<Note> findAll();

    Optional<Note> findById(Long id);

    List<Note> findByInscriptionId(Long inscriptionId);

    List<Note> findByMatiereId(Long matiereId);

    List<Note> findByInscriptionAndSession(Long inscriptionId, Session session);

    Optional<Note> findByInscriptionAndMatiereAndSession(Long inscriptionId, Long matiereId, Session session);

    BigDecimal calculerMoyenneGenerale(Long inscriptionId);

    Note save(Note note);

    Note update(Note note);

    void deleteById(Long id);
}