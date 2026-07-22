<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${enseignant.id != null ? 'Modifier' : 'Ajouter'} un enseignant</h2>
    <form action="${pageContext.request.contextPath}/enseignants/save" method="post" class="col-md-8">
        <input type="hidden" name="id" value="${enseignant.id}">
        <div class="row mb-3">
            <div class="col"><label class="form-label">Nom</label><input type="text" name="nom" value="${enseignant.nom}" class="form-control" required></div>
            <div class="col"><label class="form-label">Prénom</label><input type="text" name="prenom" value="${enseignant.prenom}" class="form-control" required></div>
        </div>
        <div class="row mb-3">
            <div class="col"><label class="form-label">Email</label><input type="email" name="email" value="${enseignant.email}" class="form-control"></div>
            <div class="col"><label class="form-label">Téléphone</label><input type="text" name="telephone" value="${enseignant.telephone}" class="form-control"></div>
        </div>
        <div class="mb-3"><label class="form-label">Spécialité</label><input type="text" name="specialite" value="${enseignant.specialite}" class="form-control"></div>
        <div class="row mb-3">
            <div class="col"><label class="form-label">Département</label><input type="text" name="departement" value="${enseignant.departement}" class="form-control"></div>
            <div class="col"><label class="form-label">Grade</label><input type="text" name="grade" value="${enseignant.grade}" class="form-control"></div>
        </div>
        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/enseignants" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>