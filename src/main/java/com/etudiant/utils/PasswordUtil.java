package com.etudiant.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hasher un mot de passe
    public static String hash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // Vérifier un mot de passe
    public static boolean verify(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}