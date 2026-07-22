<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Gestion des Utilisateurs</h1>
        <a href="${pageContext.request.contextPath}/utilisateurs/ajouter" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Nouvel utilisateur
        </a>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Email</th>
                <th>Rôle</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${utilisateurs}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.nom}</td>
                    <td>${u.prenom}</td>
                    <td>${u.email}</td>
                    <td><span class="badge bg-${u.role == 'ADMIN' ? 'danger' : 'primary'}">${u.role}</span></td>
                    <td><span class="badge bg-${u.actif ? 'success' : 'secondary'}">${u.actif ? 'Actif' : 'Inactif'}</span></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/utilisateurs/details/${u.id}" class="btn btn-sm btn-info"><i class="bi bi-eye"></i></a>
                        <a href="${pageContext.request.contextPath}/utilisateurs/modifier/${u.id}" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/utilisateurs/supprimer/${u.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer cet utilisateur ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty utilisateurs}">
                <tr><td colspan="8" class="text-center">Aucun utilisateur trouvé</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>