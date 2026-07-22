package com.etudiant.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Page de login accessible directement
        registry.addViewController("/login").setViewName("login");

        // Redirection de l'accueil
        registry.addViewController("/").setViewName("redirect:/accueil");
    }
}