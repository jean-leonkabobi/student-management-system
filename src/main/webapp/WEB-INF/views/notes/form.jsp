<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${note.id != null ? 'Modifier' : 'Ajouter'} une note</h2>

    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <form action="${pageContext.request.contextPath}/notes/save" method="post" class="col-md-6">
        <input type="hidden" name="id" value="${note.id}">

        <div class="mb-3">
            <label class="form-label">Étudiant *</label>
            <select name="etudiantId" class="form-select" required>
                <option value="">Sélectionner un étudiant</option>
                <c:forEach items="${etudiants}" var="e">
                    <option value="${e.id}" ${note.etudiant != null && note.etudiant.id == e.id ? 'selected' : ''}>${e.matricule} - ${e.nom} ${e.prenom}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Matière *</label>
            <select name="matiereId" class="form-select" required>
                <option value="">Sélectionner une matière</option>
                <c:forEach items="${matieres}" var="m">
                    <option value="${m.id}" ${note.matiere != null && note.matiere.id == m.id ? 'selected' : ''}>${m.code} - ${m.nom} (coef. ${m.coefficient})</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Note (0-20) *</label>
            <input type="number" step="0.25" name="valeur" value="${note.valeur}" class="form-control" min="0" max="20" required>
        </div>

        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Type d'examen *</label>
                <select name="typeExamen" class="form-select" required>
                    <option value="DS" ${note.typeExamen == 'DS' ? 'selected' : ''}>DS</option>
                    <option value="EXAMEN" ${note.typeExamen == 'EXAMEN' ? 'selected' : ''}>Examen</option>
                    <option value="TP" ${note.typeExamen == 'TP' ? 'selected' : ''}>TP</option>
                    <option value="RATTRAPAGE" ${note.typeExamen == 'RATTRAPAGE' ? 'selected' : ''}>Rattrapage</option>
                </select>
            </div>
            <div class="col">
                <label class="form-label">Semestre</label>
                <select name="semestre" class="form-select">
                    <option value="">Sélectionner</option>
                    <option value="S1" ${note.semestre == 'S1' ? 'selected' : ''}>Semestre 1</option>
                    <option value="S2" ${note.semestre == 'S2' ? 'selected' : ''}>Semestre 2</option>
                    <option value="S3" ${note.semestre == 'S3' ? 'selected' : ''}>Semestre 3</option>
                    <option value="S4" ${note.semestre == 'S4' ? 'selected' : ''}>Semestre 4</option>
                    <option value="S5" ${note.semestre == 'S5' ? 'selected' : ''}>Semestre 5</option>
                    <option value="S6" ${note.semestre == 'S6' ? 'selected' : ''}>Semestre 6</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Année universitaire</label>
            <input type="text" name="anneeUniversitaire" value="${note.anneeUniversitaire}" class="form-control" placeholder="2025-2026">
        </div>

        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/notes" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>