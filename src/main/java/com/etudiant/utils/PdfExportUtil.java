package com.etudiant.utils;

import com.etudiant.model.Etudiant;
import com.etudiant.model.Note;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class PdfExportUtil {

    public static void exportReleveNotes(Etudiant etudiant, List<Note> notes, HttpServletResponse response) {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=releve_" + etudiant.getMatricule() + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document(PageSize.A4, 40, 40, 40, 40);
            PdfWriter.getInstance(document, out);
            document.open();

            // Police
            Font fontTitre = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
            Font fontSousTitre = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.DARK_GRAY);
            Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);
            Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            Font fontFooter = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 9, BaseColor.GRAY);

            // En-tête
            Paragraph titre = new Paragraph("RELEVÉ DE NOTES", fontTitre);
            titre.setAlignment(Element.ALIGN_CENTER);
            document.add(titre);

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Université — Gestion Universitaire", fontSousTitre));
            document.add(new Paragraph(" "));

            // Infos étudiant
            document.add(new Paragraph("Étudiant : " + etudiant.getPrenom() + " " + etudiant.getNom().toUpperCase(), fontNormal));
            document.add(new Paragraph("Matricule : " + etudiant.getMatricule(), fontNormal));
            if (etudiant.getDateNaissance() != null) {
                document.add(new Paragraph("Né(e) le : " + etudiant.getDateNaissance().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), fontNormal));
            }
            document.add(new Paragraph(" "));

            // Tableau
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.setWidths(new float[]{3, 1.5f, 1, 1.5f});

            // En-têtes tableau
            BaseColor headerBg = new BaseColor(26, 39, 68);
            String[] headers = {"Matière", "Type", "Note/20", "Semestre"};
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h, fontHeader));
                cell.setBackgroundColor(headerBg);
                cell.setPadding(8);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }

            // Lignes
            double total = 0;
            int count = 0;
            BaseColor evenBg = new BaseColor(245, 245, 250);

            for (int i = 0; i < notes.size(); i++) {
                Note n = notes.get(i);
                BaseColor bg = (i % 2 == 0) ? BaseColor.WHITE : evenBg;

                PdfPCell c1 = new PdfPCell(new Phrase(n.getMatiere().getNom(), fontNormal));
                c1.setBackgroundColor(bg); c1.setPadding(6); table.addCell(c1);

                PdfPCell c2 = new PdfPCell(new Phrase(n.getTypeExamen(), fontNormal));
                c2.setBackgroundColor(bg); c2.setPadding(6); c2.setHorizontalAlignment(Element.ALIGN_CENTER); table.addCell(c2);

                PdfPCell c3 = new PdfPCell(new Phrase(String.format("%.2f", n.getValeur()), fontNormal));
                c3.setBackgroundColor(bg); c3.setPadding(6); c3.setHorizontalAlignment(Element.ALIGN_CENTER); table.addCell(c3);

                PdfPCell c4 = new PdfPCell(new Phrase(n.getSemestre() != null ? n.getSemestre() : "", fontNormal));
                c4.setBackgroundColor(bg); c4.setPadding(6); c4.setHorizontalAlignment(Element.ALIGN_CENTER); table.addCell(c4);

                total += n.getValeur();
                count++;
            }

            document.add(table);
            document.add(new Paragraph(" "));

            // Moyenne
            if (count > 0) {
                double moyenne = total / count;
                Paragraph moy = new Paragraph("Moyenne générale : " + String.format("%.2f", moyenne) + " / 20", fontSousTitre);
                moy.setAlignment(Element.ALIGN_RIGHT);
                document.add(moy);
            }

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Document généré le " + java.time.LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), fontFooter));

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}