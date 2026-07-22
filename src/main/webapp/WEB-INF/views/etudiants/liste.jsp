<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h1 class="h2">Liste des Étudiants</h1>
        <a href="${pageContext.request.contextPath}/etudiants/ajouter" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Ajouter</a>
    </div>

    <form class="row g-2 mb-3" method="get">
        <div class="col-md-4">
            <input type="text" name="search" class="form-control" placeholder="Rechercher par nom ou prénom..." value="${search}">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-outline-primary w-100"><i class="bi bi-search"></i> Rechercher</button>
        </div>
    </form>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr><th>Matricule</th><th>Photo</th><th>Nom</th><th>Prénom</th><th>Email</th><th>Téléphone</th><th>Date Inscription</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${etudiants}" var="e">
                <tr>
                    <td>${e.matricule}</td>
                    <td><img src="${pageContext.request.contextPath}/images/default-avatar.png" width="30" height="30" class="rounded-circle"></td>
                    <td>${e.nom}</td>
                    <td>${e.prenom}</td>
                    <td>${e.email}</td>
                    <td>${e.telephone}</td>
                    <td>${e.dateInscription}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/etudiants/details/${e.id}" class="btn btn-sm btn-info" title="Détails"><i class="bi bi-eye"></i></a>
                        <a href="${pageContext.request.contextPath}/etudiants/modifier/${e.id}" class="btn btn-sm btn-warning" title="Modifier"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/etudiants/supprimer/${e.id}" class="btn btn-sm btn-danger" title="Supprimer" onclick="return confirm('Supprimer cet étudiant ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty etudiants}"><tr><td colspan="8" class="text-center">Aucun étudiant</td></tr></c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>