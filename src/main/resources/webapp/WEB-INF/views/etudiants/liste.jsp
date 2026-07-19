<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<!-- ========================================== -->
<!-- PAGE : LISTE DES ÉTUDIANTS -->
<!-- ========================================== -->

<!-- En-tête et actions -->
<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-users" style="color: var(--primary);"></i>
        Liste des Étudiants
        <span style="font-size: 14px; font-weight: 400; color: var(--text-muted); margin-left: 8px;">
            (${etudiants.size()} étudiants)
        </span>
    </h2>
    <a href="${pageContext.request.contextPath}/etudiants/ajouter"
       class="btn btn-primary">
        <i class="fas fa-user-plus"></i> Nouvel étudiant
    </a>
</div>

<!-- Filtres -->
<div class="card-modern mb-4">
    <form action="${pageContext.request.contextPath}/etudiants" method="get"
          class="d-flex flex-wrap gap-2 align-items-center">
        <div style="flex: 1; min-width: 200px;">
            <input type="text" name="search" class="form-control"
                   placeholder="🔍 Rechercher par nom ou prénom..."
                   value="${param.search}">
        </div>
        <div style="min-width: 150px;">
            <select name="statut" class="form-control">
                <option value="">Tous les statuts</option>
                <c:forEach items="${statuts}" var="s">
                    <option value="${s}" ${param.statut == s ? 'selected' : ''}>
                            ${s}
                    </option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-filter"></i> Filtrer
        </button>
        <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-outline">
            <i class="fas fa-undo"></i> Réinitialiser
        </a>
    </form>
</div>

<!-- Messages -->
<c:if test="${not empty success}">
    <div class="toast-container" style="position: static; margin-bottom: 16px;">
        <div class="toast success" style="border-color: var(--success);">
            <i class="fas fa-check-circle"></i>
            <div class="toast-content">
                <div class="toast-title">Succès</div>
                <div class="toast-message">${success}</div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="toast-container" style="position: static; margin-bottom: 16px;">
        <div class="toast error" style="border-color: var(--danger);">
            <i class="fas fa-exclamation-circle"></i>
            <div class="toast-content">
                <div class="toast-title">Erreur</div>
                <div class="toast-message">${error}</div>
            </div>
        </div>
    </div>
</c:if>

<!-- Tableau -->
<div class="table-container">
    <div class="table-wrapper">
        <table class="table-modern">
            <thead>
            <tr>
                <th style="width: 40px;">#</th>
                <th>Matricule</th>
                <th>Étudiant</th>
                <th>Email</th>
                <th>Téléphone</th>
                <th>Statut</th>
                <th style="text-align: center; width: 180px;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty etudiants}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 48px 20px; color: var(--text-muted);">
                            <i class="fas fa-inbox" style="font-size: 36px; display: block; margin-bottom: 12px; opacity: 0.5;"></i>
                            Aucun étudiant trouvé
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${etudiants}" var="e" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                    <span style="font-weight: 600; color: var(--primary); font-size: 13px;">
                                            ${e.matricule}
                                    </span>
                            </td>
                            <td>
                                <div class="avatar-cell">
                                    <div class="avatar-small" style="background:
                                        ${status.index % 2 == 0 ? 'var(--primary)' : 'var(--success)'};">
                                            ${e.prenom.charAt(0)}${e.nom.charAt(0)}
                                    </div>
                                    <div>
                                        <div class="name">${e.prenom} ${e.nom}</div>
                                        <div style="font-size: 12px; color: var(--text-muted);">
                                                ${e.postnom != null ? e.postnom : ''}
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>${e.email}</td>
                            <td>${e.telephone}</td>
                            <td>
                                    <span class="badge
                                        ${e.statut == 'ACTIF' ? 'badge-success' :
                                          e.statut == 'SUSPENDU' ? 'badge-warning' :
                                          e.statut == 'DIPLOME' ? 'badge-info' : 'badge-danger'}">
                                            ${e.statut}
                                    </span>
                            </td>
                            <td style="text-align: center;">
                                <div style="display: flex; gap: 6px; justify-content: center;">
                                    <a href="${pageContext.request.contextPath}/etudiants/detail/${e.id}"
                                       class="btn btn-sm btn-outline"
                                       title="Voir les détails">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/etudiants/modifier/${e.id}"
                                       class="btn btn-sm btn-primary"
                                       title="Modifier">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/etudiants/supprimer/${e.id}"
                                       class="btn btn-sm btn-danger"
                                       title="Supprimer"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet étudiant ? Cette action est irréversible.')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <!-- Pied de tableau -->
    <div style="padding: 16px 24px; border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px;">
        <span style="font-size: 14px; color: var(--text-muted);">
            <i class="fas fa-info-circle"></i>
            Affichage de <strong>${etudiants.size()}</strong> étudiant(s)
        </span>
        <div style="display: flex; gap: 8px;">
            <a href="${pageContext.request.contextPath}/etudiants/recherche"
               class="btn btn-sm btn-outline">
                <i class="fas fa-search-plus"></i> Recherche avancée
            </a>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>