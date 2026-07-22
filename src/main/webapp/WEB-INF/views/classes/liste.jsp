<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h1 class="h2">Liste des Classes</h1>
        <a href="${pageContext.request.contextPath}/classes/ajouter" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Ajouter</a>
    </div>

    <form class="row g-2 mb-3" method="get">
        <div class="col-md-4">
            <select name="filiereId" class="form-select">
                <option value="">Toutes les filières</option>
                <c:forEach items="${filieres}" var="f">
                    <option value="${f.id}" ${selectedFiliere == f.id ? 'selected' : ''}>${f.nom}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2"><button type="submit" class="btn btn-outline-primary w-100">Filtrer</button></div>
    </form>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr><th>Nom</th><th>Niveau</th><th>Filière</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${classes}" var="c">
                <tr>
                    <td>${c.nom}</td>
                    <td><span class="badge bg-info">${c.niveau}</span></td>
                    <td>${c.filiere.nom}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/classes/details/${c.id}" class="btn btn-sm btn-info"><i class="bi bi-eye"></i></a>
                        <a href="${pageContext.request.contextPath}/classes/modifier/${c.id}" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/classes/supprimer/${c.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer cette classe ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty classes}"><tr><td colspan="4" class="text-center">Aucune classe</td></tr></c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>