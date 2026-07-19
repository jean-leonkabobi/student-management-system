<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-book"></i> Nouvelle matière</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/matieres/ajouter"
                   method="post" modelAttribute="matiere">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Code *</label>
                    <form:input path="code" class="form-control" placeholder="INFO101"/>
                    <form:errors path="code" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Nom *</label>
                    <form:input path="nom" class="form-control" placeholder="Algorithmique"/>
                    <form:errors path="nom" cssClass="text-danger"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Filière</label>
                    <form:select path="filiere.id" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <c:forEach items="${filieres}" var="f">
                            <form:option value="${f.id}">${f.code} - ${f.nom}</form:option>
                        </c:forEach>
                    </form:select>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Niveau</label>
                    <form:select path="niveau.id" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <c:forEach items="${niveaux}" var="n">
                            <form:option value="${n.id}">${n.code} - ${n.nom}</form:option>
                        </c:forEach>
                    </form:select>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Semestre *</label>
                    <form:select path="semestre" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <c:forEach items="${semestres}" var="s">
                            <form:option value="${s}">${s}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="semestre" cssClass="text-danger"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Coefficient</label>
                    <form:input path="coefficient" type="number" step="0.5" class="form-control" placeholder="1.0"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Crédits</label>
                    <form:input path="credit" type="number" class="form-control" placeholder="6"/>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="form-label">Volume horaire (heures)</label>
                    <form:input path="volumeHoraire" type="number" class="form-control" placeholder="60"/>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/matieres" class="btn btn-secondary">
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