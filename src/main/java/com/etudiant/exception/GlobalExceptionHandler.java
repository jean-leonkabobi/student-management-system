package com.etudiant.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public RedirectView handleNotFound(ResourceNotFoundException ex, RedirectAttributes attributes) {
        attributes.addFlashAttribute("error", ex.getMessage());
        return new RedirectView("/");
    }

    @ExceptionHandler(DuplicateResourceException.class)
    public RedirectView handleDuplicate(DuplicateResourceException ex, RedirectAttributes attributes) {
        attributes.addFlashAttribute("error", ex.getMessage());
        return new RedirectView("/");
    }

    @ExceptionHandler(Exception.class)
    public RedirectView handleGeneral(Exception ex, RedirectAttributes attributes) {
        attributes.addFlashAttribute("error", "Une erreur est survenue : " + ex.getMessage());
        return new RedirectView("/");
    }
}