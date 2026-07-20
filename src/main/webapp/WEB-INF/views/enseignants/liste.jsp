<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-chalkboard-teacher text-primary"></i> Liste des Enseignants</h2>
    <a href="${pageContext.request.contextPath}/enseignants/ajouter" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouvel enseignant
    </a>
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

<!-- Barre de recherche -->
<div class="card mb-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/enseignants" method="get" class="row g-2">
            <div class="col-md-8">
                <input type="text" name="search" class="form-control"
                       placeholder="Rechercher par nom ou prénom..."
                       value="${param.search}">
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-search"></i> Rechercher
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Tableau -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Matricule</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Email</th>
                    <th>Téléphone</th>
                    <th>Grade</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty enseignants}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucun enseignant trouvé
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${enseignants}" var="e" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><strong>${e.matricule}</strong></td>
                                <td>${e.nom}</td>
                                <td>${e.prenom}</td>
                                <td>${e.email}</td>
                                <td>${e.telephone}</td>
                                <td>${e.grade}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/enseignants/modifier/${e.id}"
                                       class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/enseignants/supprimer/${e.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cet enseignant ?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer text-muted">
        Total : ${enseignants.size()} enseignant(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>