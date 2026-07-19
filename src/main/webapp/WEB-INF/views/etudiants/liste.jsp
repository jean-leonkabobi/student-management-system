<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-users text-primary"></i> Liste des Étudiants</h2>
    <a href="${pageContext.request.contextPath}/etudiants/ajouter" class="btn btn-primary">
        <i class="fas fa-user-plus"></i> Nouvel étudiant
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

<!-- Filtres -->
<div class="card mb-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/etudiants" method="get" class="row g-2">
            <div class="col-md-5">
                <input type="text" name="search" class="form-control"
                       placeholder="Rechercher par nom ou prénom..."
                       value="${param.search}">
            </div>
            <div class="col-md-3">
                <select name="statut" class="form-select">
                    <option value="">Tous les statuts</option>
                    <option value="ACTIF" ${param.statut == 'ACTIF' ? 'selected' : ''}>ACTIF</option>
                    <option value="SUSPENDU" ${param.statut == 'SUSPENDU' ? 'selected' : ''}>SUSPENDU</option>
                    <option value="DIPLOME" ${param.statut == 'DIPLOME' ? 'selected' : ''}>DIPLOME</option>
                    <option value="ABANDONNE" ${param.statut == 'ABANDONNE' ? 'selected' : ''}>ABANDONNE</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-filter"></i> Filtrer
                </button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary w-100">
                    <i class="fas fa-undo"></i> Réinitialiser
                </a>
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
                    <th>Statut</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty etudiants}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucun étudiant trouvé
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${etudiants}" var="e" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><strong>${e.matricule}</strong></td>
                                <td>${e.nom}</td>
                                <td>${e.prenom}</td>
                                <td>${e.email}</td>
                                <td>${e.telephone}</td>
                                <td>
                                        <span class="badge
                                            ${e.statut == 'ACTIF' ? 'bg-success' :
                                              e.statut == 'SUSPENDU' ? 'bg-warning' :
                                              e.statut == 'DIPLOME' ? 'bg-info' : 'bg-danger'}">
                                                ${e.statut}
                                        </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/etudiants/detail/${e.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/etudiants/modifier/${e.id}"
                                       class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/etudiants/supprimer/${e.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cet étudiant ?')">
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
        Total : ${etudiants.size()} étudiant(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>