package com.etudiant.service;

import com.etudiant.model.Note;
import java.util.List;
import java.util.Optional;

public interface NoteService {
    Note save(Note note);
    Optional<Note> findById(Long id);
    List<Note> findAll();
    List<Note> findByEtudiantId(Long etudiantId);
    List<Note> findByMatiereId(Long matiereId);
    List<Note> findByEtudiantIdAndSemestre(Long etudiantId, String semestre);
    List<Note> findByEtudiantIdAndAnneeUniversitaire(Long etudiantId, String anneeUniversitaire);
    Note update(Long id, Note note);
    void deleteById(Long id);
    Double calculerMoyenne(Long etudiantId, Long matiereId);
    long count();
}