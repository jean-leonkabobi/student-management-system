<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h1 class="h2">Liste des Enseignants</h1>
        <a href="${pageContext.request.contextPath}/enseignants/ajouter" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Ajouter</a>
    </div>

    <form class="row g-2 mb-3" method="get">
        <div class="col-md-3"><input type="text" name="search" class="form-control" placeholder="Rechercher..." value="${search}"></div>
        <div class="col-md-3">
            <select name="departement" class="form-select">
                <option value="">Tous les départements</option>
                <option value="Informatique" ${departement == 'Informatique' ? 'selected' : ''}>Informatique</option>
                <option value="Mathématiques" ${departement == 'Mathématiques' ? 'selected' : ''}>Mathématiques</option>
                <option value="Physique" ${departement == 'Physique' ? 'selected' : ''}>Physique</option>
            </select>
        </div>
        <div class="col-md-2"><button type="submit" class="btn btn-outline-primary w-100">Filtrer</button></div>
    </form>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr><th>Matricule</th><th>Nom</th><th>Prénom</th><th>Email</th><th>Département</th><th>Grade</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${enseignants}" var="e">
                <tr>
                    <td>${e.matricule}</td><td>${e.nom}</td><td>${e.prenom}</td>
                    <td>${e.email}</td><td>${e.departement}</td><td>${e.grade}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/enseignants/details/${e.id}" class="btn btn-sm btn-info"><i class="bi bi-eye"></i></a>
                        <a href="${pageContext.request.contextPath}/enseignants/modifier/${e.id}" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/enseignants/supprimer/${e.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty enseignants}"><tr><td colspan="7" class="text-center">Aucun enseignant</td></tr></c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>