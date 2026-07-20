package com.etudiant.controller;

import com.etudiant.model.Etudiant;
import com.etudiant.service.EtudiantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/export")
@RequiredArgsConstructor
@Slf4j
public class ExportController {

    private final EtudiantService etudiantService;

    @GetMapping("/etudiants/csv")
    public ResponseEntity<byte[]> exportEtudiantsCSV(@RequestParam(required = false) String filiere) {
        log.debug("Export CSV des étudiants");

        List<Etudiant> etudiants = etudiantService.findAll();

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        PrintWriter writer = new PrintWriter(out);

        // En-tête du CSV
        writer.println("Matricule,Nom,Prenom,Email,Telephone,Statut,Filiere");

        // Données
        for (Etudiant e : etudiants) {
            writer.printf("%s,%s,%s,%s,%s,%s,%s%n",
                    e.getMatricule(),
                    e.getNom(),
                    e.getPrenom(),
                    e.getEmail(),
                    e.getTelephone() != null ? e.getTelephone() : "",
                    e.getStatut(),
                    e.getInscriptions().isEmpty() ? "" : e.getInscriptions().get(0).getFiliere().getNom()
            );
        }
        writer.flush();

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=etudiants.csv");
        headers.add(HttpHeaders.CONTENT_TYPE, "text/csv; charset=UTF-8");

        return ResponseEntity.ok()
                .headers(headers)
                .contentType(MediaType.parseMediaType("text/csv"))
                .body(out.toByteArray());
    }

    @GetMapping("/etudiants/pdf")
    public ResponseEntity<byte[]> exportEtudiantsPDF(@RequestParam(required = false) String filiere) {
        log.debug("Export PDF des étudiants (à implémenter avec iText ou Jasper)");

        // Pour l'instant, retourner un message
        String message = "Export PDF - À implémenter avec une bibliothèque PDF";

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=etudiants.pdf");

        return ResponseEntity.ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(message.getBytes());
    }
}