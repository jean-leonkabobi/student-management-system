package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "matiere")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Matiere {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 20)
    @NotBlank(message = "Le code est obligatoire")
    @Size(max = 20, message = "Le code ne peut pas dépasser 20 caractères")
    private String code;

    @Column(nullable = false, length = 100)
    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 100, message = "Le nom ne peut pas dépasser 100 caractères")
    private String nom;

    @Column(precision = 3, scale = 1)
    private BigDecimal coefficient = BigDecimal.ONE;

    private Integer credit = 0;

    @Column(name = "volume_horaire")
    private Integer volumeHoraire;

    @Enumerated(EnumType.STRING)
    private Semestre semestre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "filiere_id")
    private Filiere filiere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "niveau_id")
    private Niveau niveau;

    @OneToMany(mappedBy = "matiere", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Note> notes = new ArrayList<>();

    @OneToMany(mappedBy = "matiere", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Presence> presences = new ArrayList<>();

    public enum Semestre {
        S1, S2, S3, S4, S5, S6
    }
}