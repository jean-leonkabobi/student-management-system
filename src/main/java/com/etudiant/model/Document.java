package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "document")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_document", nullable = false)
    private TypeDocument typeDocument;

    @Column(name = "nom_fichier", length = 255)
    private String nomFichier;

    @Column(name = "chemin_fichier", length = 500)
    private String cheminFichier;

    @Column(name = "date_upload")
    private LocalDate dateUpload;

    @Column(columnDefinition = "TEXT")
    private String description;

    public enum TypeDocument {
        CNI, PASSEPORT, ACTE_NAISSANCE, DIPLOME, BULLETIN, PHOTO, CERTIFICAT_MEDICAL, AUTRE
    }
}