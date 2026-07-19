<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-pen text-primary"></i> Liste des Notes</h2>
    <a href="${pageContext.request.contextPath}/notes/saisie" class="btn btn-primary">
        <i class="fas fa-plus"></i> Saisir une note
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
        <form action="${pageContext.request.contextPath}/notes" method="get" class="row g-2">
            <div class="col-md-4">
                <select name="inscriptionId" class="form-select">
                    <option value="">Toutes les inscriptions</option>
                    <c:forEach items="${inscriptions}" var="i">
                        <option value="${i.id}" ${param.inscriptionId == i.id ? 'selected' : ''}>
                                ${i.etudiant.matricule} - ${i.etudiant.prenom} ${i.etudiant.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4">
                <select name="matiereId" class="form-select">
                    <option value="">Toutes les matières</option>
                    <c:forEach items="${matieres}" var="m">
                        <option value="${m.id}" ${param.matiereId == m.id ? 'selected' : ''}>
                                ${m.code} - ${m.nom}
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
                <a href="${pageContext.request.contextPath}/notes" class="btn btn-secondary w-100">
                    <i class="fas fa-undo"></i> Réinitialiser
                </a>
            </div>
        </form>
    </div>
</div>

<!-- Moyenne générale -->
<c:if test="${not empty inscription and not empty moyenneGenerale}">
    <div class="alert alert-info">
        <strong>Moyenne générale de ${inscription.etudiant.prenom} ${inscription.etudiant.nom} :</strong>
        <span class="badge bg-primary" style="font-size: 16px;">${moyenneGenerale}/20</span>
    </div>
</c:if>

<!-- Tableau -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Étudiant</th>
                    <th>Matière</th>
                    <th>Contrôle continu</th>
                    <th>TP</th>
                    <th>Examen</th>
                    <th>Moyenne</th>
                    <th>Mention</th>
                    <th>Session</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty notes}">
                        <tr>
                            <td colspan="10" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucune note trouvée
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${notes}" var="n" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                        ${n.inscription.etudiant.prenom} ${n.inscription.etudiant.nom}
                                    <br>
                                    <small class="text-muted">${n.inscription.etudiant.matricule}</small>
                                </td>
                                <td>${n.matiere.nom}</td>
                                <td>${n.controleContinu}</td>
                                <td>${n.tp}</td>
                                <td>${n.examen}</td>
                                <td>
                                    <strong class="text-primary">${n.moyenne}</strong>
                                </td>
                                <td>
                                        <span class="badge
                                            ${n.mention == 'Très Bien' ? 'bg-success' :
                                              n.mention == 'Bien' ? 'bg-info' :
                                              n.mention == 'Assez Bien' ? 'bg-primary' :
                                              n.mention == 'Passable' ? 'bg-warning' : 'bg-danger'}">
                                                ${n.mention}
                                        </span>
                                </td>
                                <td>${n.session}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/notes/modifier/${n.id}"
                                       class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/notes/supprimer/${n.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cette note ?')">
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
        Total : ${notes.size()} note(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>