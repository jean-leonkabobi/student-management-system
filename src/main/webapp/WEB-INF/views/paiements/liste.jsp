<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";
    boolean isEtudiant = "ETUDIANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/header-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : LISTE DES PAIEMENTS -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-coins" style="color: #2563EB;"></i>
        <c:choose>
            <c:when test="<%= isEtudiant %>">Mes Paiements</c:when>
            <c:otherwise>Liste des Paiements</c:otherwise>
        </c:choose>
    </h2>
    <c:if test="<%= !isEtudiant %>">
        <a href="${pageContext.request.contextPath}/paiements/ajouter" class="btn btn-primary">
            <i class="fas fa-plus"></i> Nouveau paiement
        </a>
    </c:if>
</div>

<!-- Messages -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle"></i> ${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle"></i> ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Résumé des paiements pour l'étudiant -->
<c:if test="<%= isEtudiant %>">
    <div class="row g-3 mb-3">
        <div class="col-md-6">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h6 class="card-title">Total payé</h6>
                    <h3>${totalPaye != null ? totalPaye : '0'} €</h3>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card bg-danger text-white">
                <div class="card-body">
                    <h6 class="card-title">Reste à payer</h6>
                    <h3>${totalRestant != null ? totalRestant : '0'} €</h3>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- Filtres - Uniquement pour les administrateurs -->
<c:if test="<%= !isEtudiant %>">
    <div class="card mb-3">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/paiements" method="get" class="row g-2">
                <div class="col-md-4">
                    <select name="inscriptionId" class="form-select">
                        <option value="">Toutes les inscriptions</option>
                        <c:forEach items="${inscriptions}" var="i">
                            <option value="${i.id}" ${param.inscriptionId == i.id ? 'selected' : ''}>
                                    ${i.etudiant.matricule} - ${i.etudiant.prenom} ${i.etudiant.nom}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <select name="statut" class="form-select">
                        <option value="">Tous les statuts</option>
                        <c:forEach items="${statuts}" var="s">
                            <option value="${s}" ${param.statut == s ? 'selected' : ''}>${s}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter"></i> Filtrer
                    </button>
                </div>
                <div class="col-md-2">
                    <a href="${pageContext.request.contextPath}/paiements" class="btn btn-secondary w-100">
                        <i class="fas fa-undo"></i> Réinitialiser
                    </a>
                </div>
            </form>
        </div>
    </div>
</c:if>

<!-- Tableau -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>#</th>
                    <c:if test="<%= !isEtudiant %>">
                        <th>Étudiant</th>
                    </c:if>
                    <th>Type de frais</th>
                    <th>Montant total</th>
                    <th>Payé</th>
                    <th>Reste</th>
                    <th>Statut</th>
                    <th>Date limite</th>
                    <c:if test="<%= !isEtudiant %>">
                        <th class="text-center">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty paiements}">
                        <tr>
                            <td colspan="${isEtudiant ? 7 : 9}" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucun paiement trouvé
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${paiements}" var="p" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <c:if test="<%= !isEtudiant %>">
                                    <td>
                                            ${p.inscription.etudiant.prenom} ${p.inscription.etudiant.nom}
                                        <br>
                                        <small class="text-muted">${p.inscription.etudiant.matricule}</small>
                                    </td>
                                </c:if>
                                <td>
                                    <span class="badge bg-info">${p.typeFrais}</span>
                                </td>
                                <td><strong>${p.montantTotal} €</strong></td>
                                <td class="text-success">${p.montantPaye} €</td>
                                <td class="text-danger">${p.montantTotal - p.montantPaye} €</td>
                                <td>
                                        <span class="badge
                                            ${p.statut == 'PAYE' ? 'bg-success' :
                                              p.statut == 'PARTIEL' ? 'bg-warning' :
                                              p.statut == 'EN_RETARD' ? 'bg-danger' : 'bg-secondary'}">
                                                ${p.statut}
                                        </span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${p.dateLimite}" pattern="dd/MM/yyyy"/>
                                </td>
                                <c:if test="<%= !isEtudiant %>">
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/paiements/detail/${p.id}"
                                           class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/paiements/supprimer/${p.id}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Supprimer ce paiement ?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer text-muted">
        Total : ${paiements.size()} paiement(s)
    </div>
</div>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/footer-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>