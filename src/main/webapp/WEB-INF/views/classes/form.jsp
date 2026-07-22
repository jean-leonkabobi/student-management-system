<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${classe.id != null ? 'Modifier' : 'Ajouter'} une classe</h2>
    <form action="${pageContext.request.contextPath}/classes/save" method="post" class="col-md-6">
        <input type="hidden" name="id" value="${classe.id}">
        <div class="mb-3"><label class="form-label">Nom</label><input type="text" name="nom" value="${classe.nom}" class="form-control" required></div>
        <div class="mb-3">
            <label class="form-label">Niveau</label>
            <select name="niveau" class="form-select" required>
                <option value="L1" ${classe.niveau == 'L1' ? 'selected' : ''}>L1</option>
                <option value="L2" ${classe.niveau == 'L2' ? 'selected' : ''}>L2</option>
                <option value="L3" ${classe.niveau == 'L3' ? 'selected' : ''}>L3</option>
                <option value="M1" ${classe.niveau == 'M1' ? 'selected' : ''}>M1</option>
                <option value="M2" ${classe.niveau == 'M2' ? 'selected' : ''}>M2</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Filière</label>
            <select name="filiere.id" class="form-select" required>
                <option value="">Sélectionner une filière</option>
                <c:forEach items="${filieres}" var="f">
                    <option value="${f.id}" ${classe.filiere.id == f.id ? 'selected' : ''}>${f.nom}</option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/classes" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>