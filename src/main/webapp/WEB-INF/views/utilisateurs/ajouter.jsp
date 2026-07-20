<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-user-plus"></i> Nouvel utilisateur</h4>
    </div>
    <div class="card-body">
        <form:form action="${pageContext.request.contextPath}/utilisateurs/ajouter"
                   method="post" modelAttribute="utilisateur">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nom d'utilisateur *</label>
                    <form:input path="username" class="form-control" placeholder="jean.dupont"/>
                    <form:errors path="username" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Email *</label>
                    <form:input path="email" type="email" class="form-control" placeholder="jean@email.com"/>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Mot de passe *</label>
                    <form:input path="passwordHash" type="password" class="form-control" placeholder="********"/>
                    <form:errors path="passwordHash" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Confirmer le mot de passe *</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="********"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Rôle *</label>
                    <form:select path="role" class="form-select">
                        <form:option value="">Sélectionner</form:option>
                        <c:forEach items="${roles}" var="r">
                            <form:option value="${r}">${r}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="role" cssClass="text-danger"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Statut</label>
                    <form:select path="estActif" class="form-select">
                        <form:option value="true">Actif</form:option>
                        <form:option value="false">Inactif</form:option>
                    </form:select>
                </div>
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-secondary">
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