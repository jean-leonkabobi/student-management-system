<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${etudiant.id != null ? 'Modifier' : 'Ajouter'} un étudiant</h2>

    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <form action="${pageContext.request.contextPath}/etudiants/save" method="post" class="col-md-8" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${etudiant.id}">

        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Nom *</label>
                <input type="text" name="nom" value="${etudiant.nom}" class="form-control" required>
            </div>
            <div class="col">
                <label class="form-label">Prénom *</label>
                <input type="text" name="prenom" value="${etudiant.prenom}" class="form-control" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Date de naissance</label>
            <input type="date" name="dateNaissance" value="${etudiant.dateNaissance}" class="form-control">
        </div>

        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="${etudiant.email}" class="form-control">
            </div>
            <div class="col">
                <label class="form-label">Téléphone</label>
                <input type="text" name="telephone" value="${etudiant.telephone}" class="form-control">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Adresse</label>
            <textarea name="adresse" class="form-control" rows="2">${etudiant.adresse}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Photo</label>
            <input type="file" name="photoFile" class="form-control" accept="image/*">
            <c:if test="${etudiant.photo != null}">
                <img src="${pageContext.request.contextPath}${etudiant.photo}" width="50" class="mt-2 rounded">
            </c:if>
        </div>

        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>