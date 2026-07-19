<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-pen"></i> Saisie d'une note</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/notes/saisie"
                   method="post" modelAttribute="note">

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
                    <label class="form-label">Matière *</label>
                    <form:select path="matiere.id" class="form-select">
                        <form:option value="">Sélectionner une matière</form:option>
                        <c:forEach items="${matieres}" var="m">
                            <form:option value="${m.id}">${m.code} - ${m.nom}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="matiere" cssClass="text-danger"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Contrôle continu (/20)</label>
                    <form:input path="controleContinu" type="number" step="0.01" class="form-control" placeholder="12.50"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">TP (/20)</label>
                    <form:input path="tp" type="number" step="0.01" class="form-control" placeholder="14.00"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Examen (/20)</label>
                    <form:input path="examen" type="number" step="0.01" class="form-control" placeholder="15.50"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Session</label>
                    <form:select path="session" class="form-select">
                        <c:forEach items="${sessions}" var="s">
                            <form:option value="${s}">${s}</form:option>
                        </c:forEach>
                    </form:select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Date de saisie</label>
                    <form:input path="dateSaisie" type="date" class="form-control"/>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/notes" class="btn btn-secondary">
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