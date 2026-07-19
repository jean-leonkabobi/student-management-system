<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-edit"></i> Modifier un étudiant</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/etudiants/modifier"
                   method="post" modelAttribute="etudiant">

            <form:hidden path="id"/>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Matricule</label>
                    <form:input path="matricule" class="form-control" readonly="true"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nom *</label>
                    <form:input path="nom" class="form-control" placeholder="Dupont"/>
                    <form:errors path="nom" cssClass="text-danger"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Prénom *</label>
                    <form:input path="prenom" class="form-control" placeholder="Jean"/>
                    <form:errors path="prenom" cssClass="text-danger"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Postnom</label>
                    <form:input path="postnom" class="form-control" placeholder="Marie"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Email *</label>
                    <form:input path="email" type="email" class="form-control" placeholder="jean.dupont@email.com"/>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Téléphone</label>
                    <form:input path="telephone" class="form-control" placeholder="0612345678"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Date de naissance</label>
                    <form:input path="dateNaissance" type="date" class="form-control"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Sexe</label>
                    <form:select path="sexe" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <form:option value="M">Masculin</form:option>
                        <form:option value="F">Féminin</form:option>
                    </form:select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Lieu de naissance</label>
                    <form:input path="lieuNaissance" class="form-control" placeholder="Paris"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nationalité</label>
                    <form:input path="nationalite" class="form-control" placeholder="Française"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">État civil</label>
                    <form:input path="etatCivil" class="form-control" placeholder="Célibataire"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Statut</label>
                    <form:select path="statut" class="form-select">
                        <form:option value="ACTIF">Actif</form:option>
                        <form:option value="SUSPENDU">Suspendu</form:option>
                        <form:option value="DIPLOME">Diplômé</form:option>
                        <form:option value="ABANDONNE">Abandonné</form:option>
                    </form:select>
                </div>
                <div class="col-12 mb-3">
                    <label class="form-label">Adresse</label>
                    <form:textarea path="adresse" class="form-control" rows="2" placeholder="Adresse complète"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Ville</label>
                    <form:input path="ville" class="form-control" placeholder="Paris"/>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Pays</label>
                    <form:input path="pays" class="form-control" placeholder="France"/>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Mettre à jour
                </button>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>