<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-coins"></i> Nouveau paiement</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/paiements/ajouter"
                   method="post" modelAttribute="paiement">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Inscription *</label>
                    <form:select path="inscription.id" class="form-select">
                        <form:option value="">Sélectionner une inscription</form:option>
                        <c:forEach items="${inscriptions}" var="i">
                            <form:option value="${i.id}">
                                ${i.etudiant.matricule} - ${i.etudiant.prenom} ${i.etudiant.nom}
                            </form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="inscription" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Type de frais *</label>
                    <form:select path="typeFrais" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <c:forEach items="${typesFrais}" var="t">
                            <form:option value="${t}">${t}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="typeFrais" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Montant total *</label>
                    <form:input path="montantTotal" type="number" step="0.01" class="form-control" placeholder="500.00"/>
                    <form:errors path="montantTotal" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Montant payé</label>
                    <form:input path="montantPaye" type="number" Mercistep="0.01" class="form-control" placeholder="0.00"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Date limite</label>
                    <form:input path="dateLimite" type="date" class="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Statut</label>
                    <form:select path="statut" class="form-select">
                        <form:option value="IMPRE">Impayé</form:option>
                        <form:option value="PARTIEL">Partiel</form:option>
                        <form:option value="PAYE">Payé</form:option>
                        <form:option value="EN_RETARD">En retard</form:option>
                    </form:select>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/paiements" class="btn btn-secondary">
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