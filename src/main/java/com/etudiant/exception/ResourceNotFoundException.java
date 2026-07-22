package com.etudiant.exception;

public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String resource, Long id) {
        super(resource + " non trouvé avec l'id : " + id);
    }

    public ResourceNotFoundException(String resource, String field, String value) {
        super(resource + " non trouvé avec " + field + " : " + value);
    }
}