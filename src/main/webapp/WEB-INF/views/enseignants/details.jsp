<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>Détails de l'enseignant</h2>
    <div class="card col-md-6">
        <div class="card-body">
            <p><strong>Matricule :</strong> ${enseignant.matricule}</p>
            <p><strong>Nom complet :</strong> ${enseignant.prenom} ${enseignant.nom}</p>
            <p><strong>Email :</strong> ${enseignant.email}</p>
            <p><strong>Téléphone :</strong> ${enseignant.telephone}</p>
            <p><strong>Spécialité :</strong> ${enseignant.specialite}</p>
            <p><strong>Département :</strong> ${enseignant.departement}</p>
            <p><strong>Grade :</strong> ${enseignant.grade}</p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/enseignants" class="btn btn-secondary mt-3">Retour</a>
</main>
<%@ include file="../fragments/footer.jsp" %>