package com.etudiant.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtils {

    private static final DateTimeFormatter FRENCH_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public static String formatFrench(LocalDate date) {
        return date != null ? date.format(FRENCH_FORMATTER) : "";
    }

    public static LocalDate parseFrench(String date) {
        return date != null && !date.isEmpty() ? LocalDate.parse(date, FRENCH_FORMATTER) : null;
    }
}