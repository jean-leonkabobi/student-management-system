package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "note",
        uniqueConstraints = @UniqueConstraint(columnNames = {"inscription_id", "matiere_id", "session"}))
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inscription_id", nullable = false)
    private Inscription inscription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "matiere_id", nullable = false)
    private Matiere matiere;

    @Column(name = "controle_continu", precision = 4, scale = 2)
    private BigDecimal controleContinu;

    @Column(precision = 4, scale = 2)
    private BigDecimal tp;

    @Column(precision = 4, scale = 2)
    private BigDecimal examen;

    @Column(precision = 4, scale = 2)
    private BigDecimal moyenne;

    @Column(name = "credit_obtenu")
    private Integer creditObtenu = 0;

    @Column(length = 20)
    private String mention;

    @Enumerated(EnumType.STRING)
    private Session session = Session.NORMALE;

    @Column(name = "date_saisie")
    private LocalDate dateSaisie;

    public enum Session {
        NORMALE, RATTRAPAGE
    }

    @PrePersist
    @PreUpdate
    public void calculerMoyenne() {
        if (controleContinu != null && tp != null && examen != null) {
            this.moyenne = controleContinu.add(tp).add(examen)
                    .divide(BigDecimal.valueOf(3), 2, BigDecimal.ROUND_HALF_UP);

            // Déterminer la mention
            if (this.moyenne != null) {
                double moy = this.moyenne.doubleValue();
                if (moy >= 16) this.mention = "Très Bien";
                else if (moy >= 14) this.mention = "Bien";
                else if (moy >= 12) this.mention = "Assez Bien";
                else if (moy >= 10) this.mention = "Passable";
                else this.mention = "Insuffisant";
            }
        }
    }
}