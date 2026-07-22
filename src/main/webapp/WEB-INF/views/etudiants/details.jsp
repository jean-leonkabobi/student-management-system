<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>Détails de l'étudiant</h2>
    <div class="card col-md-6">
        <div class="card-body text-center">
            <img src="${pageContext.request.contextPath}/images/default-avatar.png" width="100" class="rounded-circle mb-3">
            <h4>${etudiant.prenom} ${etudiant.nom}</h4>
            <p><strong>Matricule :</strong> ${etudiant.matricule}</p>
            <p><strong>Date naissance :</strong> ${etudiant.dateNaissance}</p>
            <p><strong>Email :</strong> ${etudiant.email}</p>
            <p><strong>Téléphone :</strong> ${etudiant.telephone}</p>
            <p><strong>Adresse :</strong> ${etudiant.adresse}</p>
            <p><strong>Inscrit le :</strong> ${etudiant.dateInscription}</p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary mt-3">Retour</a>
</main>
<%@ include file="../fragments/footer.jsp" %>