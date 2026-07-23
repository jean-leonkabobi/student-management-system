package com.etudiant.utils;

import com.etudiant.model.Etudiant;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ExcelExportUtil {

    public static void exportEtudiants(List<Etudiant> etudiants, HttpServletResponse response) {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=etudiants.xlsx");

        try (Workbook workbook = new XSSFWorkbook(); OutputStream out = response.getOutputStream()) {
            Sheet sheet = workbook.createSheet("Étudiants");

            // Style en-tête
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(BorderStyle.THIN);

            // En-têtes
            String[] headers = {"Matricule", "Nom", "Prénom", "Email", "Téléphone", "Date Naissance", "Date Inscription"};
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
                sheet.autoSizeColumn(i);
            }

            // Données
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            int rowNum = 1;
            for (Etudiant e : etudiants) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(e.getMatricule());
                row.createCell(1).setCellValue(e.getNom());
                row.createCell(2).setCellValue(e.getPrenom());
                row.createCell(3).setCellValue(e.getEmail() != null ? e.getEmail() : "");
                row.createCell(4).setCellValue(e.getTelephone() != null ? e.getTelephone() : "");
                row.createCell(5).setCellValue(e.getDateNaissance() != null ? e.getDateNaissance().format(dtf) : "");
                row.createCell(6).setCellValue(e.getDateInscription() != null ? e.getDateInscription().format(dtf) : "");
            }

            // Auto-size
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}