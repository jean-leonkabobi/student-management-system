<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>${utilisateur.id != null ? 'Modifier' : 'Ajouter'} un utilisateur</h2>

    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <form action="${pageContext.request.contextPath}/utilisateurs/save" method="post" class="col-md-6">
        <input type="hidden" name="id" value="${utilisateur.id}">

        <div class="mb-3">
            <label class="form-label">Nom d'utilisateur</label>
            <input type="text" name="username" value="${utilisateur.username}" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mot de passe</label>
            <input type="password" name="password" class="form-control" ${utilisateur.id == null ? 'required' : ''}>
            <c:if test="${utilisateur.id != null}"><small class="text-muted">Laisser vide pour ne pas changer</small></c:if>
        </div>

        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" value="${utilisateur.nom}" class="form-control" required>
            </div>
            <div class="col">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" value="${utilisateur.prenom}" class="form-control" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" value="${utilisateur.email}" class="form-control">
        </div>

        <div class="mb-3">
            <label class="form-label">Rôle</label>
            <select name="role" class="form-select" required>
                <option value="ADMIN" ${utilisateur.role == 'ADMIN' ? 'selected' : ''}>Administrateur</option>
                <option value="SCOLARITE" ${utilisateur.role == 'SCOLARITE' ? 'selected' : ''}>Scolarité</option>
            </select>
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" name="actif" value="true" class="form-check-input" id="actif" ${utilisateur.actif == null || utilisateur.actif ? 'checked' : ''}>
            <label class="form-check-label" for="actif">Actif</label>
        </div>

        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer</button>
        <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-secondary">Annuler</a>
    </form>
</main>
<%@ include file="../fragments/footer.jsp" %>