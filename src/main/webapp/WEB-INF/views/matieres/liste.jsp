<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-book text-primary"></i> Liste des Matières</h2>
    <a href="${pageContext.request.contextPath}/matieres/ajouter" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouvelle matière
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
        <form action="${pageContext.request.contextPath}/matieres" method="get" class="row g-2">
            <div class="col-md-4">
                <select name="filiereId" class="form-select">
                    <option value="">Toutes les filières</option>
                    <c:forEach items="${filieres}" var="f">
                        <option value="${f.id}" ${param.filiereId == f.id ? 'selected' : ''}>
                                ${f.code} - ${f.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4">
                <select name="niveauId" class="form-select">
                    <option value="">Tous les niveaux</option>
                    <c:forEach items="${niveaux}" var="n">
                        <option value="${n.id}" ${param.niveauId == n.id ? 'selected' : ''}>
                                ${n.code} - ${n.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-filter"></i> Filtrer
                </button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/matieres" class="btn btn-secondary w-100">
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
                    <th>Code</th>
                    <th>Nom</th>
                    <th>Filière</th>
                    <th>Niveau</th>
                    <th>Semestre</th>
                    <th>Coeff</th>
                    <th>Crédits</th>
                    <th>Volume Horaire</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty matieres}">
                        <tr>
                            <td colspan="10" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucune matière trouvée
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${matieres}" var="m" varStatus="status">
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
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/matieres/modifier/${m.id}"
                                       class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/matieres/supprimer/${m.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cette matière ?')">
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
        Total : ${matieres.size()} matière(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>