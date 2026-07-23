<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${matiere.id != null ? 'Modifier' : 'Ajouter'} une matière</h2>

    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <form action="${pageContext.request.contextPath}/matieres/save" method="post" class="col-md-6">
        <input type="hidden" name="id" value="${matiere.id}">

        <div class="mb-3">
            <label class="form-label">Code</label>
            <input type="text" name="code" value="${matiere.code}" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Nom</label>
            <input type="text" name="nom" value="${matiere.nom}" class="form-control" required>
        </div>
        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Coefficient</label>
                <input type="number" name="coefficient" value="${matiere.coefficient}" class="form-control" required>
            </div>
            <div class="col">
                <label class="form-label">Nombre d'heures</label>
                <input type="number" name="nombreHeures" value="${matiere.nombreHeures}" class="form-control">
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Enseignant</label>
            <select name="enseignantId" class="form-select">
                <option value="">Aucun</option>
                <c:forEach items="${enseignants}" var="e">
                    <option value="${e.id}" ${matiere.enseignant != null && matiere.enseignant.id == e.id ? 'selected' : ''}>${e.prenom} ${e.nom}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Filière</label>
            <select name="filiereId" class="form-select" required>
                <option value="">Sélectionner</option>
                <c:forEach items="${filieres}" var="f">
                    <option value="${f.id}" ${matiere.filiere != null && matiere.filiere.id == f.id ? 'selected' : ''}>${f.nom}</option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/matieres" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>