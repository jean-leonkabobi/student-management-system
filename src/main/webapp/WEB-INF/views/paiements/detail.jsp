<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h4><i class="fas fa-coins"></i> Détail du paiement</h4>
        <div>
            <a href="${pageContext.request.contextPath}/paiements" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Informations générales</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>ID</th>
                        <td>${paiement.id}</td>
                    </tr>
                    <tr>
                        <th>Type de frais</th>
                        <td><span class="badge bg-info">${paiement.typeFrais}</span></td>
                    </tr>
                    <tr>
                        <th>Montant total</th>
                        <td><strong>${paiement.montantTotal} €</strong></td>
                    </tr>
                    <tr>
                        <th>Montant payé</th>
                        <td class="text-success"><strong>${paiement.montantPaye} €</strong></td>
                    </tr>
                    <tr>
                        <th>Reste à payer</th>
                        <td class="text-danger"><strong>${paiement.montantTotal - paiement.montantPaye} €</strong></td>
                    </tr>
                    <tr>
                        <th>Statut</th>
                        <td>
                            <span class="badge
                                ${paiement.statut == 'PAYE' ? 'bg-success' :
                                  paiement.statut == 'PARTIEL' ? 'bg-warning' :
                                  paiement.statut == 'EN_RETARD' ? 'bg-danger' : 'bg-secondary'}">
                                ${paiement.statut}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>Date limite</th>
                        <td><fmt:formatDate value="${paiement.dateLimite}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    <tr>
                        <th>Créé le</th>
                        <td>${paiement.createdAt}</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Étudiant</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Matricule</th>
                        <td><strong>${paiement.inscription.etudiant.matricule}</strong></td>
                    </tr>
                    <tr>
                        <th>Nom complet</th>
                        <td>${paiement.inscription.etudiant.prenom} ${paiement.inscription.etudiant.nom}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${paiement.inscription.etudiant.email}</td>
                    </tr>
                    <tr>
                        <th>Téléphone</th>
                        <td>${paiement.inscription.etudiant.telephone}</td>
                    </tr>
                </table>

                <h5 class="border-bottom pb-2 mt-3">Inscription</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Filière</th>
                        <td>${paiement.inscription.filiere.nom}</td>
                    </tr>
                    <tr>
                        <th>Niveau</th>
                        <td>${paiement.inscription.niveau.nom}</td>
                    </tr>
                    <tr>
                        <th>Année</th>
                        <td>${paiement.inscription.anneeAcademique.libelle}</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Reçus -->
        <div class="mt-3">
            <h5 class="border-bottom pb-2">Reçus</h5>
            <c:choose>
                <c:when test="${empty paiement.recus}">
                    <p class="text-muted">Aucun reçu enregistré</p>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>Montant</th>
                                <th>Date</th>
                                <th>Moyen</th>
                                <th>Référence</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${paiement.recus}" var="r">
                                <tr>
                                    <td><strong>${r.montant} €</strong></td>
                                    <td><fmt:formatDate value="${r.datePaiement}" pattern="dd/MM/yyyy"/></td>
                                    <td>${r.moyenPaiement}</td>
                                    <td>${r.reference}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/paiements" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>