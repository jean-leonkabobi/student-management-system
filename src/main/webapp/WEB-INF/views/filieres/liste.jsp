<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h1 class="h2">Liste des Filières</h1>
        <a href="${pageContext.request.contextPath}/filieres/ajouter" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Ajouter</a>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr><th>Code</th><th>Nom</th><th>Description</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${filieres}" var="f">
                <tr>
                    <td><span class="badge bg-secondary">${f.code}</span></td>
                    <td>${f.nom}</td>
                    <td>${f.description}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/filieres/modifier/${f.id}" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/filieres/supprimer/${f.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer cette filière ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty filieres}"><tr><td colspan="4" class="text-center">Aucune filière</td></tr></c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>