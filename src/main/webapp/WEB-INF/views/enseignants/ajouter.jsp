<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-chalkboard-teacher"></i> Nouvel enseignant</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/enseignants/ajouter"
                   method="post" modelAttribute="enseignant">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Matricule *</label>
                    <form:input path="matricule" class="form-control" placeholder="ENS-0001"/>
                    <form:errors path="matricule" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Nom *</label>
                    <form:input path="nom" class="form-control" placeholder="Dupont"/>
                    <form:errors path="nom" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Postnom</label>
                    <form:input path="postnom" class="form-control" placeholder="Jean"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Prénom *</label>
                    <form:input path="prenom" class="form-control" placeholder="Marie"/>
                    <form:errors path="prenom" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Email *</label>
                    <form:input path="email" type="email" class="form-control" placeholder="jean.dupont@univ.com"/>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Téléphone</label>
                    <form:input path="telephone" class="form-control" placeholder="0612345678"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Grade</label>
                    <form:input path="grade" class="form-control" placeholder="Professeur"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Spécialité</label>
                    <form:input path="specialite" class="form-control" placeholder="Algorithmique"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Département</label>
                    <form:input path="departement" class="form-control" placeholder="Informatique"/>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Mot de passe</label>
                <input type="text" name="motDePasse" class="form-control" placeholder="Laisser vide pour générer automatiquement">
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/enseignants" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Enregistrer
                </button>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>