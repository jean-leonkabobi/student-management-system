package com.etudiant.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "recu_paiement")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecuPaiement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "paiement_id", nullable = false)
    private Paiement paiement;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal montant;

    @Column(name = "date_paiement")
    private LocalDate datePaiement;

    @Enumerated(EnumType.STRING)
    @Column(name = "moyen_paiement")
    private MoyenPaiement moyenPaiement;

    @Column(length = 50)
    private String reference;

    @Column(name = "recu_path", length = 255)
    private String recuPath;

    public enum MoyenPaiement {
        ESPECES, CHEQUE, VIREMENT, CARTE, MOBILE_MONEY
    }
}