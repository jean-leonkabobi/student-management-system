<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-user-graduate"></i> Nouvelle inscription</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/inscriptions/ajouter"
                   method="post" modelAttribute="inscription">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Étudiant *</label>
                    <form:select path="etudiant.id" class="form-select">
                        <form:option value="">Sélectionner un étudiant</form:option>
                        <c:forEach items="${etudiants}" var="e">
                            <form:option value="${e.id}">
                                ${e.matricule} - ${e.prenom} ${e.nom}
                            </form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="etudiant" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Filière *</label>
                    <form:select path="filiere.id" class="form-select">
                        <form:option value="">Sélectionner une filière</form:option>
                        <c:forEach items="${filieres}" var="f">
                            <form:option value="${f.id}">${f.code} - ${f.nom}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="filiere" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Niveau *</label>
                    <form:select path="niveau.id" class="form-select">
                        <form:option value="">Sélectionner un niveau</form:option>
                        <c:forEach items="${niveaux}" var="n">
                            <form:option value="${n.id}">${n.code} - ${n.nom}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="niveau" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Année académique *</label>
                    <form:select path="anneeAcademique.id" class="form-select">
                        <form:option value="">Sélectionner une année</form:option>
                        <c:forEach items="${anneesAcademiques}" var="a">
                            <form:option value="${a.id}">
                                ${a.libelle} ${a.estActive ? '(Active)' : ''}
                            </form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="anneeAcademique" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Date d'inscription</label>
                    <form:input path="dateInscription" type="date" class="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Statut</label>
                    <form:select path="statut" class="form-select">
                        <form:option value="INSCRIT">Inscrit</form:option>
                        <form:option value="REINSCRIT">Réinscrit</form:option>
                        <form:option value="SUSPENDU">Suspendu</form:option>
                        <form:option value="DIPLOME">Diplômé</form:option>
                    </form:select>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/inscriptions" class="btn btn-secondary">
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