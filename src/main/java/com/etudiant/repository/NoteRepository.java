package com.etudiant.repository;

import com.etudiant.model.Note;
import com.etudiant.model.Note.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {

    List<Note> findByInscriptionId(Long inscriptionId);

    List<Note> findByMatiereId(Long matiereId);

    List<Note> findByInscriptionIdAndSession(Long inscriptionId, Session session);

    Optional<Note> findByInscriptionIdAndMatiereIdAndSession(Long inscriptionId, Long matiereId, Session session);
}