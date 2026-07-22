package com.etudiant.repository;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Matiere;
import com.etudiant.model.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {

    List<Note> findByEtudiant(Etudiant etudiant);

    List<Note> findByEtudiantId(Long etudiantId);

    List<Note> findByMatiere(Matiere matiere);

    List<Note> findByMatiereId(Long matiereId);

    List<Note> findByEtudiantIdAndSemestre(Long etudiantId, String semestre);

    List<Note> findByEtudiantIdAndAnneeUniversitaire(Long etudiantId, String anneeUniversitaire);

    List<Note> findByMatiereIdAndTypeExamen(Long matiereId, String typeExamen);
}