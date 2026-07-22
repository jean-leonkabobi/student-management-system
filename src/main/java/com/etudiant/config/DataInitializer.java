package com.etudiant.config;

import com.etudiant.model.Utilisateur;
import com.etudiant.model.Filiere;
import com.etudiant.service.UtilisateurService;
import com.etudiant.service.FiliereService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UtilisateurService utilisateurService;
    private final FiliereService filiereService;

    public DataInitializer(UtilisateurService utilisateurService, FiliereService filiereService) {
        this.utilisateurService = utilisateurService;
        this.filiereService = filiereService;
    }

    @Override
    public void run(String... args) throws Exception {
        initUtilisateurs();
        initFilieres();
    }

    private void initUtilisateurs() {
        if (utilisateurService.count() == 0) {
            Utilisateur admin = new Utilisateur();
            admin.setUsername("admin");
            admin.setPassword("admin123");
            admin.setRole("ADMIN");
            admin.setNom("Admin");
            admin.setPrenom("Super");
            admin.setEmail("admin@universite.com");
            admin.setActif(true);
            utilisateurService.save(admin);

            Utilisateur scolarite = new Utilisateur();
            scolarite.setUsername("scolarite");
            scolarite.setPassword("scolarite123");
            scolarite.setRole("SCOLARITE");
            scolarite.setNom("Scolarité");
            scolarite.setPrenom("Agent");
            scolarite.setEmail("scolarite@universite.com");
            scolarite.setActif(true);
            utilisateurService.save(scolarite);

            System.out.println("=== UTILISATEURS INITIALISÉS ===");
            System.out.println("Admin : admin / admin123");
            System.out.println("Scolarité : scolarite / scolarite123");
        }
    }

    private void initFilieres() {
        if (filiereService.count() == 0) {
            String[][] filieresData = {
                    {"INFO", "Informatique", "Filière Génie Logiciel, Réseaux et Systèmes"},
                    {"MATH", "Mathématiques", "Filière Mathématiques Pures et Appliquées"},
                    {"PHY", "Physique", "Filière Sciences Physiques et Chimiques"},
                    {"BIO", "Biologie", "Filière Sciences de la Vie et de la Terre"},
                    {"ECO", "Économie", "Filière Sciences Économiques et Gestion"},
                    {"DROIT", "Droit", "Filière Sciences Juridiques et Politiques"},
                    {"LIT", "Littérature", "Filière Lettres Modernes et Linguistique"},
                    {"HIST", "Histoire", "Filière Histoire et Civilisations"}
            };

            for (String[] data : filieresData) {
                Filiere filiere = new Filiere();
                filiere.setCode(data[0]);
                filiere.setNom(data[1]);
                filiere.setDescription(data[2]);
                filiereService.save(filiere);
            }

            System.out.println("=== " + filieresData.length + " FILIÈRES INITIALISÉES ===");
        }
    }
}