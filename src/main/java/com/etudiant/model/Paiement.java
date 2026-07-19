package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "paiement")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Paiement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inscription_id", nullable = false)
    private Inscription inscription;

    @Column(name = "montant_total", nullable = false, precision = 10, scale = 2)
    private BigDecimal montantTotal;

    @Column(name = "montant_paye", precision = 10, scale = 2)
    private BigDecimal montantPaye = BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_frais", nullable = false)
    private TypeFrais typeFrais;

    @Column(name = "date_limite")
    private LocalDate dateLimite;

    @Enumerated(EnumType.STRING)
    private StatutPaiement statut = StatutPaiement.IMPRE;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "paiement", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RecuPaiement> recus = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public enum TypeFrais {
        INSCRIPTION, ACADEMIQUE, LABORATOIRE, BIBLIOTHEQUE, ASSURANCE
    }

    public enum StatutPaiement {
        PAYE, PARTIEL, IMPRE, EN_RETARD
    }
}