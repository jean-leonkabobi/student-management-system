<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <h2>Relevé de notes</h2>
    <h4>${etudiant.prenom} ${etudiant.nom} (${etudiant.matricule})</h4>

    <div class="table-responsive mt-4">
        <table class="table table-bordered">
            <thead class="table-primary">
            <tr><th>Matière</th><th>Type</th><th>Note</th><th>Semestre</th><th>Année</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${notes}" var="n">
                <tr>
                    <td>${n.matiere.nom} (coef. ${n.matiere.coefficient})</td>
                    <td>${n.typeExamen}</td>
                    <td><span class="badge bg-${n.valeur >= 10 ? 'success' : 'danger'}">${n.valeur}/20</span></td>
                    <td>${n.semestre}</td><td>${n.anneeUniversitaire}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty notes}"><tr><td colspan="5" class="text-center">Aucune note</td></tr></c:if>
            </tbody>
        </table>
    </div>
    <a href="${pageContext.request.contextPath}/notes" class="btn btn-secondary">Retour</a>
    <button class="btn btn-success" onclick="window.print()"><i class="bi bi-printer"></i> Imprimer</button>
</main>
<%@ include file="../fragments/footer.jsp" %>