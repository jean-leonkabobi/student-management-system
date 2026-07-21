<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ENSEIGNANT";
    boolean isEnseignant = "ENSEIGNANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/header-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : MES COURS -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-book-open" style="color: #2563EB;"></i> Mes Cours
    </h2>
</div>

<!-- Messages -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle"></i> ${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle"></i> ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Liste des cours -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Code</th>
                    <th>Nom</th>
                    <th>Filière</th>
                    <th>Niveau</th>
                    <th>Semestre</th>
                    <th>Coefficient</th>
                    <th>Crédits</th>
                    <th>Volume Horaire</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty mesCours}">
                        <tr>
                            <td colspan="9" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucun cours assigné.
                                <br>
                                <small>Contactez l'administration pour assigner des cours.</small>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${mesCours}" var="m" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><strong>${m.code}</strong></td>
                                <td>${m.nom}</td>
                                <td>${m.filiere != null ? m.filiere.nom : '-'}</td>
                                <td>${m.niveau != null ? m.niveau.nom : '-'}</td>
                                <td><span class="badge bg-info">${m.semestre}</span></td>
                                <td>${m.coefficient}</td>
                                <td>${m.credit}</td>
                                <td>${m.volumeHoraire}h</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer text-muted">
        Total : ${mesCours.size()} cours
    </div>
</div>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/footer-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>