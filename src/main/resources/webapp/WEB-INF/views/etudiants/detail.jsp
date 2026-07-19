<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<!-- ========================================== -->
<!-- PAGE : DÉTAIL D'UN ÉTUDIANT -->
<!-- ========================================== -->

<div style="max-width: 1100px; margin: 0 auto;">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 style="font-size: 20px; font-weight: 700;">
            <i class="fas fa-user" style="color: var(--primary);"></i>
            Détail de l'étudiant
            <span style="font-size: 14px; font-weight: 400; color: var(--text-muted);">
                - ${etudiant.matricule}
            </span>
        </h2>
        <div style="display: flex; gap: 8px;">
            <a href="${pageContext.request.contextPath}/etudiants/modifier/${etudiant.id}"
               class="btn btn-primary">
                <i class="fas fa-edit"></i> Modifier
            </a>
            <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-outline">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>

    <!-- Carte principale -->
    <div class="detail-card">
        <!-- En-tête avec photo/avatar -->
        <div class="detail-header">
            <div class="avatar-large">
                ${etudiant.prenom.charAt(0)}${etudiant.nom.charAt(0)}
            </div>
            <div class="info">
                <h2>${etudiant.prenom} ${etudiant.nom}</h2>
                <div class="subtitle">
                    <span class="badge ${etudiant.statut == 'ACTIF' ? 'badge-success' :
                              etudiant.statut == 'SUSPENDU' ? 'badge-warning' :
                              etudiant.statut == 'DIPLOME' ? 'badge-info' : 'badge-danger'}">
                        ${etudiant.statut}
                    </span>
                    <span style="margin-left: 12px;">
                        <i class="fas fa-id-card"></i> ${etudiant.matricule}
                    </span>
                    <span style="margin-left: 12px;">
                        <i class="fas fa-envelope"></i> ${etudiant.email}
                    </span>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="detail-tabs">
            <button class="tab active" data-tab="info">
                <i class="fas fa-info-circle"></i> Informations
            </button>
            <button class="tab" data-tab="inscriptions">
                <i class="fas fa-graduation-cap"></i> Inscriptions
            </button>
            <button class="tab" data-tab="paiements">
                <i class="fas fa-coins"></i> Paiements
            </button>
            <button class="tab" data-tab="documents">
                <i class="fas fa-file"></i> Documents
            </button>
        </div>

        <!-- Contenu des tabs -->
        <div class="detail-body">

            <!-- Tab 1: Informations -->
            <div class="tab-content active" id="tab-info">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                    <div>
                        <h4 style="font-weight: 600; margin-bottom: 16px; color: var(--text-primary);">
                            <i class="fas fa-id-card" style="color: var(--primary);"></i>
                            État civil
                        </h4>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Matricule</div>
                                <div style="font-weight: 600;">${etudiant.matricule}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Sexe</div>
                                <div>${etudiant.sexe == 'M' ? 'Masculin' : 'Féminin'}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Date de naissance</div>
                                <div>
                                    <fmt:formatDate value="${etudiant.dateNaissance}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Lieu de naissance</div>
                                <div>${etudiant.lieuNaissance}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Nationalité</div>
                                <div>${etudiant.nationalite}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">État civil</div>
                                <div>${etudiant.etatCivil}</div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <h4 style="font-weight: 600; margin-bottom: 16px; color: var(--text-primary);">
                            <i class="fas fa-address-book" style="color: var(--primary);"></i>
                            Coordonnées
                        </h4>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Email</div>
                                <div>${etudiant.email}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Téléphone</div>
                                <div>${etudiant.telephone}</div>
                            </div>
                            <div style="grid-column: 1 / -1;">
                                <div style="font-size: 12px; color: var(--text-muted);">Adresse</div>
                                <div>${etudiant.adresse}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Ville</div>
                                <div>${etudiant.ville}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--text-muted);">Pays</div>
                                <div>${etudiant.pays}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tab 2: Inscriptions -->
            <div class="tab-content" id="tab-inscriptions" style="display: none;">
                <div style="text-align: center; padding: 40px 20px; color: var(--text-muted);">
                    <i class="fas fa-graduation-cap" style="font-size: 36px; display: block; margin-bottom: 12px; opacity: 0.5;"></i>
                    <p>Aucune inscription pour le moment.</p>
                    <a href="#" class="btn btn-primary btn-sm" style="margin-top: 12px;">
                        <i class="fas fa-plus"></i> Ajouter une inscription
                    </a>
                </div>
            </div>

            <!-- Tab 3: Paiements -->
            <div class="tab-content" id="tab-paiements" style="display: none;">
                <div style="text-align: center; padding: 40px 20px; color: var(--text-muted);">
                    <i class="fas fa-coins" style="font-size: 36px; display: block; margin-bottom: 12px; opacity: 0.5;"></i>
                    <p>Aucun paiement enregistré.</p>
                </div>
            </div>

            <!-- Tab 4: Documents -->
            <div class="tab-content" id="tab-documents" style="display: none;">
                <div style="text-align: center; padding: 40px 20px; color: var(--text-muted);">
                    <i class="fas fa-file" style="font-size: 36px; display: block; margin-bottom: 12px; opacity: 0.5;"></i>
                    <p>Aucun document téléchargé.</p>
                    <a href="#" class="btn btn-primary btn-sm" style="margin-top: 12px;">
                        <i class="fas fa-upload"></i> Télécharger un document
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Script pour les tabs -->
<script>
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', function() {
            // Désactiver tous les tabs
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(tc => tc.style.display = 'none');

            // Activer le tab cliqué
            this.classList.add('active');
            const target = this.dataset.tab;
            document.getElementById('tab-' + target).style.display = 'block';
        });
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>