<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${filiere.id != null ? 'Modifier' : 'Ajouter'} une filière</h2>
    <form action="${pageContext.request.contextPath}/filieres/save" method="post" class="col-md-6">
        <input type="hidden" name="id" value="${filiere.id}">
        <div class="mb-3"><label class="form-label">Code</label><input type="text" name="code" value="${filiere.code}" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Nom</label><input type="text" name="nom" value="${filiere.nom}" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Description</label><textarea name="description" class="form-control" rows="3">${filiere.description}</textarea></div>
        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/filieres" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>