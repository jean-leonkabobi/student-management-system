<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>Détails de la classe : ${classe.nom}</h2>
    <p><strong>Niveau :</strong> ${classe.niveau} | <strong>Filière :</strong> ${classe.filiere.nom}</p>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header"><h5>Étudiants inscrits (${classe.etudiants.size()})</h5></div>
                <div class="card-body">
                    <c:if test="${not empty classe.etudiants}">
                        <ul class="list-group">
                            <c:forEach items="${classe.etudiants}" var="e">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${e.prenom} ${e.nom} (${e.matricule})
                                    <a href="${pageContext.request.contextPath}/classes/${classe.id}/retirer-etudiant/${e.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Retirer cet étudiant ?')"><i class="bi bi-x-circle"></i></a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty classe.etudiants}"><p class="text-muted">Aucun étudiant dans cette classe</p></c:if>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header"><h5>Ajouter un étudiant</h5></div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/classes/${classe.id}/ajouter-etudiant" method="post">
                        <select name="etudiantId" class="form-select mb-2">
                            <option value="">Sélectionner...</option>
                            <c:forEach items="${etudiantsLibres}" var="e">
                                <option value="${e.id}">${e.matricule} - ${e.prenom} ${e.nom}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-plus"></i> Ajouter</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/classes" class="btn btn-secondary mt-3">Retour</a>
</main>
<%@ include file="../fragments/footer.jsp" %>