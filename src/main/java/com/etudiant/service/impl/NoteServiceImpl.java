package com.etudiant.service;

import com.etudiant.model.Note;
import com.etudiant.repository.NoteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class NoteServiceImpl implements NoteService {

    private final NoteRepository noteRepository;

    public NoteServiceImpl(NoteRepository noteRepository) {
        this.noteRepository = noteRepository;
    }

    @Override
    public Note save(Note note) {
        return noteRepository.save(note);
    }

    @Override
    public Optional<Note> findById(Long id) {
        return noteRepository.findById(id);
    }

    @Override
    public List<Note> findAll() {
        return noteRepository.findAll();
    }

    @Override
    public List<Note> findByEtudiantId(Long etudiantId) {
        return noteRepository.findByEtudiantId(etudiantId);
    }

    @Override
    public List<Note> findByMatiereId(Long matiereId) {
        return noteRepository.findByMatiereId(matiereId);
    }

    @Override
    public List<Note> findByEtudiantIdAndSemestre(Long etudiantId, String semestre) {
        return noteRepository.findByEtudiantIdAndSemestre(etudiantId, semestre);
    }

    @Override
    public List<Note> findByEtudiantIdAndAnneeUniversitaire(Long etudiantId, String anneeUniversitaire) {
        return noteRepository.findByEtudiantIdAndAnneeUniversitaire(etudiantId, anneeUniversitaire);
    }

    @Override
    public Note update(Long id, Note note) {
        Note existing = noteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Note non trouvée avec l'id : " + id));
        existing.setValeur(note.getValeur());
        existing.setTypeExamen(note.getTypeExamen());
        existing.setSemestre(note.getSemestre());
        existing.setAnneeUniversitaire(note.getAnneeUniversitaire());
        existing.setEtudiant(note.getEtudiant());
        existing.setMatiere(note.getMatiere());
        return noteRepository.save(existing);
    }

    @Override
    public void deleteById(Long id) {
        noteRepository.deleteById(id);
    }

    @Override
    public Double calculerMoyenne(Long etudiantId, Long matiereId) {
        List<Note> notes = noteRepository.findByMatiereId(matiereId);
        if (notes == null || notes.isEmpty()) {
            return 0.0;
        }
        double somme = notes.stream()
                .filter(n -> n.getEtudiant().getId().equals(etudiantId))
                .mapToDouble(Note::getValeur)
                .sum();
        long count = notes.stream()
                .filter(n -> n.getEtudiant().getId().equals(etudiantId))
                .count();
        return count > 0 ? somme / count : 0.0;
    }

    @Override
    public long count() {
        return noteRepository.count();
    }
}