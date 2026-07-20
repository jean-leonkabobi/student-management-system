<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<!-- Message de bienvenue -->
<div class="alert alert-info">
    <h4><i class="fas fa-user-shield"></i> Bienvenue ${username} !</h4>
    <p>Vous êtes connecté en tant que <strong>${role}</strong>.</p>
</div>

<!-- Statistiques -->
<div class="row g-3 mb-4">
    <div class="col-md-3">
        <div class="card bg-primary text-white">
            <div class="card-body">
                <h6 class="card-title"><i class="fas fa-users"></i> Étudiants</h6>
                <h2 class="mb-0">${totalEtudiants}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-success text-white">
            <div class="card-body">
                <h6 class="card-title"><i class="fas fa-chalkboard-teacher"></i> Enseignants</h6>
                <h2 class="mb-0">${totalEnseignants}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-warning text-white">
            <div class="card-body">
                <h6 class="card-title"><i class="fas fa-book"></i> Matières</h6>
                <h2 class="mb-0">${totalMatieres}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-info text-white">
            <div class="card-body">
                <h6 class="card-title"><i class="fas fa-coins"></i> Paiements</h6>
                <h2 class="mb-0"><fmt:formatNumber value="${totalPaiementsMontant}" type="currency" currencySymbol="€"/></h2>
            </div>
        </div>
    </div>
</div>

<!-- Graphiques -->
<div class="row g-3">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-chart-pie"></i> Étudiants par statut</h5>
            </div>
            <div class="card-body">
                <c:forEach items="${etudiantsParStatut}" var="entry">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span>${entry.key}</span>
                        <span class="badge bg-primary">${entry.value}</span>
                    </div>
                    <div class="progress mb-2" style="height: 8px;">
                        <div class="progress-bar bg-primary"
                             style="width: ${totalEtudiants > 0 ? (entry.value / totalEtudiants * 100) : 0}%;">
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-chart-bar"></i> Paiements par statut</h5>
            </div>
            <div class="card-body">
                <c:forEach items="${paiementsParStatut}" var="entry">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span>${entry.key}</span>
                        <span class="badge bg-success">${entry.value}</span>
                    </div>
                    <div class="progress mb-2" style="height: 8px;">
                        <div class="progress-bar bg-success"
                             style="width: ${totalPaiements > 0 ? (entry.value / totalPaiements * 100) : 0}%;">
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Informations supplémentaires -->
<div class="row g-3 mt-2">
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h6><i class="fas fa-graduation-cap"></i> Inscriptions</h6>
                <h3>${totalInscriptions}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h6><i class="fas fa-layer-group"></i> Filières</h6>
                <h3>${totalFilieres}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h6><i class="fas fa-calculator"></i> Moyenne générale</h6>
                <h3>${moyenneGenerale != null ? moyenneGenerale : '-'}</h3>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>