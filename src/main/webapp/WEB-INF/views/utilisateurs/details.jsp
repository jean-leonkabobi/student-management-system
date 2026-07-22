<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>Détails de l'utilisateur</h2>

    <div class="card col-md-6">
        <div class="card-body">
            <p><strong>ID :</strong> ${utilisateur.id}</p>
            <p><strong>Username :</strong> ${utilisateur.username}</p>
            <p><strong>Nom complet :</strong> ${utilisateur.prenom} ${utilisateur.nom}</p>
            <p><strong>Email :</strong> ${utilisateur.email}</p>
            <p><strong>Rôle :</strong> <span class="badge bg-${utilisateur.role == 'ADMIN' ? 'danger' : 'primary'}">${utilisateur.role}</span></p>
            <p><strong>Statut :</strong> <span class="badge bg-${utilisateur.actif ? 'success' : 'secondary'}">${utilisateur.actif ? 'Actif' : 'Inactif'}</span></p>
            <p><strong>Date de création :</strong> ${utilisateur.dateCreation}</p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-secondary mt-3">Retour</a>
</main>
<%@ include file="../fragments/footer.jsp" %>