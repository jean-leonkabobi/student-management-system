<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";
    boolean isEtudiant = "ETUDIANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/header-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : EMPLOI DU TEMPS -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-calendar-alt" style="color: #F59E0B;"></i>
        <c:choose>
            <c:when test="<%= isEtudiant %>">Mon Emploi du Temps</c:when>
            <c:otherwise>Emploi du Temps - Administration</c:otherwise>
        </c:choose>
    </h2>
</div>

<!-- Message si pas d'emploi du temps -->
<div class="alert alert-info">
    <i class="fas fa-info-circle"></i>
    <c:choose>
        <c:when test="<%= isEtudiant %>">
            Votre emploi du temps sera disponible prochainement.
            Consultez votre scolarité pour plus d'informations.
        </c:when>
        <c:otherwise>
            La gestion complète de l'emploi du temps sera disponible dans une prochaine version.
        </c:otherwise>
    </c:choose>
</div>

<!-- Exemple de structure d'emploi du temps (à compléter plus tard) -->
<div class="card">
    <div class="card-header">
        <h5>Semaine du <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/></h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Horaire</th>
                    <th>Lundi</th>
                    <th>Mardi</th>
                    <th>Mercredi</th>
                    <th>Jeudi</th>
                    <th>Vendredi</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>08:00 - 10:00</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                </tr>
                <tr>
                    <td>10:00 - 12:00</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                </tr>
                <tr>
                    <td>14:00 - 16:00</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                </tr>
                <tr>
                    <td>16:00 - 18:00</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                    <td class="text-muted text-center">-</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="text-muted text-center mt-3">
            <small><i class="fas fa-clock"></i> Aucun cours programmé pour cette semaine</small>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/footer-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>