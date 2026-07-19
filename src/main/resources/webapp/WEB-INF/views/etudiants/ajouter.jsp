<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<!-- ========================================== -->
<!-- PAGE : AJOUTER UN ÉTUDIANT -->
<!-- ========================================== -->

<div style="max-width: 900px; margin: 0 auto;">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 style="font-size: 20px; font-weight: 700;">
            <i class="fas fa-user-plus" style="color: var(--primary);"></i>
            Nouvel étudiant
        </h2>
        <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-outline">
            <i class="fas fa-arrow-left"></i> Retour
        </a>
    </div>

    <div class="form-container">
        <h3 class="form-title">Ajouter un étudiant</h3>
        <p class="form-subtitle">Remplissez tous les champs obligatoires (*) pour inscrire un nouvel étudiant.</p>

        <form:form action="${pageContext.request.contextPath}/etudiants/ajouter"
                   method="post" modelAttribute="etudiant">

            <div class="form-grid">

                <!-- État civil -->
                <div class="form-group full-width">
                    <h4 style="font-size: 14px; font-weight: 600; color: var(--text-secondary); margin-bottom: 4px;">
                        <i class="fas fa-id-card" style="color: var(--primary);"></i>
                        État civil
                    </h4>
                    <hr style="border-color: var(--border); margin: 4px 0 12px 0;">
                </div>

                <div class="form-group">
                    <label for="nom">Nom *</label>
                    <form:input path="nom" class="form-control ${status.error ? 'is-invalid' : ''}"
                                placeholder="Dupont" required="true"/>
                    <form:errors path="nom" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="form-group">
                    <label for="postnom">Postnom</label>
                    <form:input path="postnom" class="form-control" placeholder="Jean"/>
                </div>

                <div class="form-group">
                    <label for="prenom">Prénom *</label>
                    <form:input path="prenom" class="form-control ${status.error ? 'is-invalid' : ''}"
                                placeholder="Marie" required="true"/>
                    <form:errors path="prenom" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="form-group">
                    <label for="sexe">Sexe</label>
                    <form:select path="sexe" class="form-control">
                        <form:option value="">Sélectionner</form:option>
                        <form:option value="M">Masculin</form:option>
                        <form:option value="F">Féminin</form:option>
                    </form:select>
                </div>

                <div class="form-group">
                    <label for="dateNaissance">Date de naissance</label>
                    <form:input path="dateNaissance" type="date" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="lieuNaissance">Lieu de naissance</label>
                    <form:input path="lieuNaissance" class="form-control" placeholder="Paris"/>
                </div>

                <div class="form-group">
                    <label for="nationalite">Nationalité</label>
                    <form:input path="nationalite" class="form-control" placeholder="Française"/>
                </div>

                <div class="form-group">
                    <label for="etatCivil">État civil</label>
                    <form:input path="etatCivil" class="form-control" placeholder="Célibataire"/>
                </div>

                <!-- Coordonnées -->
                <div class="form-group full-width">
                    <h4 style="font-size: 14px; font-weight: 600; color: var(--text-secondary); margin-bottom: 4px; margin-top: 8px;">
                        <i class="fas fa-address-book" style="color: var(--primary);"></i>
                        Coordonnées
                    </h4>
                    <hr style="border-color: var(--border); margin: 4px 0 12px 0;">
                </div>

                <div class="form-group">
                    <label for="email">Email *</label>
                    <form:input path="email" type="email" class="form-control ${status.error ? 'is-invalid' : ''}"
                                placeholder="jean.dupont@email.com" required="true"/>
                    <form:errors path="email" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="form-group">
                    <label for="telephone">Téléphone</label>
                    <form:input path="telephone" class="form-control" placeholder="+33 6 12 34 56 78"/>
                </div>

                <div class="form-group full-width">
                    <label for="adresse">Adresse</label>
                    <form:textarea path="adresse" class="form-control" rows="2"
                                   placeholder="12 rue de Paris, 75001 Paris"/>
                </div>

                <div class="form-group">
                    <label for="ville">Ville</label>
                    <form:input path="ville" class="form-control" placeholder="Paris"/>
                </div>

                <div class="form-group">
                    <label for="pays">Pays</label>
                    <form:input path="pays" class="form-control" placeholder="France"/>
                </div>

                <!-- Actions -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-outline">
                        <i class="fas fa-times"></i> Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Enregistrer
                    </button>
                </div>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>