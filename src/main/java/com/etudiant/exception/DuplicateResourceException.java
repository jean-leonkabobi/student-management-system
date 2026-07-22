package com.etudiant.exception;

public class DuplicateResourceException extends RuntimeException {

    public DuplicateResourceException(String message) {
        super(message);
    }

    public DuplicateResourceException(String resource, String field, String value) {
        super(resource + " existe déjà avec " + field + " : " + value);
    }
}