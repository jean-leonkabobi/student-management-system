<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h1 class="h2">Gestion des Notes</h1>
        <a href="${pageContext.request.contextPath}/notes/ajouter" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Ajouter</a>
    </div>

    <form class="row g-2 mb-3" method="get">
        <div class="col-md-3">
            <select name="etudiantId" class="form-select">
                <option value="">Tous les étudiants</option>
                <c:forEach items="${etudiants}" var="e">
                    <option value="${e.id}" ${selectedEtudiant == e.id ? 'selected' : ''}>${e.matricule} - ${e.nom}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <select name="semestre" class="form-select">
                <option value="">Semestre</option>
                <option value="S1" ${selectedSemestre == 'S1' ? 'selected' : ''}>S1</option>
                <option value="S2" ${selectedSemestre == 'S2' ? 'selected' : ''}>S2</option>
                <option value="S3" ${selectedSemestre == 'S3' ? 'selected' : ''}>S3</option>
                <option value="S4" ${selectedSemestre == 'S4' ? 'selected' : ''}>S4</option>
            </select>
        </div>
        <div class="col-md-2"><button type="submit" class="btn btn-outline-primary w-100">Filtrer</button></div>
    </form>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr><th>Étudiant</th><th>Matière</th><th>Type</th><th>Note</th><th>Semestre</th><th>Année</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${notes}" var="n">
                <tr>
                    <td>${n.etudiant.nom} ${n.etudiant.prenom}</td>
                    <td>${n.matiere.nom}</td>
                    <td>${n.typeExamen}</td>
                    <td><span class="badge bg-${n.valeur >= 10 ? 'success' : 'danger'}">${n.valeur}/20</span></td>
                    <td>${n.semestre}</td><td>${n.anneeUniversitaire}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/notes/modifier/${n.id}" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                        <a href="${pageContext.request.contextPath}/notes/supprimer/${n.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer ?')"><i class="bi bi-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty notes}"><tr><td colspan="7" class="text-center">Aucune note</td></tr></c:if>
            </tbody>
        </table>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>