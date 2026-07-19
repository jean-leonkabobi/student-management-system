<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-graduation-cap text-primary"></i> Liste des Inscriptions</h2>
    <a href="${pageContext.request.contextPath}/inscriptions/ajouter" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouvelle inscription
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
        <form action="${pageContext.request.contextPath}/inscriptions" method="get" class="row g-2">
            <div class="col-md-4">
                <select name="etudiantId" class="form-select">
                    <option value="">Tous les étudiants</option>
                    <c:forEach items="${etudiants}" var="e">
                        <option value="${e.id}" ${param.etudiantId == e.id ? 'selected' : ''}>
                                ${e.matricule} - ${e.prenom} ${e.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>
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
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-filter"></i> Filtrer
                </button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/inscriptions" class="btn btn-secondary w-100">
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
                    <th>Étudiant</th>
                    <th>Filière</th>
                    <th>Niveau</th>
                    <th>Année</th>
                    <th>Date</th>
                    <th>Statut</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty inscriptions}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucune inscription trouvée
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${inscriptions}" var="i" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <strong>${i.etudiant.prenom} ${i.etudiant.nom}</strong>
                                    <br>
                                    <small class="text-muted">${i.etudiant.matricule}</small>
                                </td>
                                <td>${i.filiere.nom}</td>
                                <td>${i.niveau.nom}</td>
                                <td>${i.anneeAcademique.libelle}</td>
                                <td>${i.dateInscriptionFormatted}</td>
                                <td>
                                        <span class="badge
                                            ${i.statut == 'INSCRIT' ? 'bg-success' :
                                              i.statut == 'REINSCRIT' ? 'bg-info' :
                                              i.statut == 'SUSPENDU' ? 'bg-warning' : 'bg-danger'}">
                                                ${i.statut}
                                        </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/inscriptions/detail/${i.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/inscriptions/supprimer/${i.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cette inscription ?')">
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
        Total : ${inscriptions.size()} inscription(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>