<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h2>Classe : ${classe.nom}</h2>
        <span class="badge bg-info fs-6">${classe.niveau} - ${classe.filiere.nom}</span>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="row">
        <div class="col-md-7">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-people-fill"></i> Étudiants inscrits</h5>
                    <span class="badge bg-light text-dark">${classe.etudiants.size()} étudiant(s)</span>
                </div>
                <div class="card-body">
                    <c:if test="${not empty classe.etudiants}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead><tr><th>Matricule</th><th>Nom</th><th>Prénom</th><th>Action</th></tr></thead>
                                <tbody>
                                <c:forEach items="${classe.etudiants}" var="e">
                                    <tr>
                                        <td>${e.matricule}</td>
                                        <td>${e.nom}</td>
                                        <td>${e.prenom}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/classes/${classe.id}/retirer-etudiant/${e.id}"
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Retirer ${e.prenom} ${e.nom} de cette classe ?')">
                                                <i class="bi bi-x-circle"></i> Retirer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty classe.etudiants}">
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-people" style="font-size: 3rem;"></i>
                            <p>Aucun étudiant dans cette classe</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-md-5">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="bi bi-plus-circle"></i> Ajouter un étudiant</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/classes/${classe.id}/ajouter-etudiant" method="post">
                        <div class="mb-3">
                            <select name="etudiantId" class="form-select" required>
                                <option value="">Sélectionner un étudiant...</option>
                                <c:forEach items="${etudiantsDisponibles}" var="e">
                                    <option value="${e.id}">${e.matricule} - ${e.prenom} ${e.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success w-100">
                            <i class="bi bi-plus"></i> Ajouter à la classe
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/classes" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Retour à la liste
        </a>
    </div>
</main>
<%@ include file="../fragments/footer.jsp" %>