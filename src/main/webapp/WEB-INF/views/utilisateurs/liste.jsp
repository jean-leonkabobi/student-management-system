<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="fas fa-users-cog text-primary"></i> Liste des Utilisateurs</h2>
    <a href="${pageContext.request.contextPath}/utilisateurs/ajouter" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouvel utilisateur
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

<!-- Tableau -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Nom d'utilisateur</th>
                    <th>Email</th>
                    <th>Rôle</th>
                    <th>Statut</th>
                    <th>Dernière connexion</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty utilisateurs}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                <i class="fas fa-inbox fa-2x d-block mb-2"></i>
                                Aucun utilisateur trouvé
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${utilisateurs}" var="u" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><strong>${u.username}</strong></td>
                                <td>${u.email}</td>
                                <td>
                                        <span class="badge
                                            ${u.role == 'ADMIN' ? 'bg-danger' :
                                              u.role == 'SCOLARITE' ? 'bg-primary' :
                                              u.role == 'ENSEIGNANT' ? 'bg-success' :
                                              u.role == 'ETUDIANT' ? 'bg-info' :
                                              u.role == 'COMPTABLE' ? 'bg-warning' : 'bg-secondary'}">
                                                ${u.role}
                                        </span>
                                </td>
                                <td>
                                        <span class="badge ${u.estActif ? 'bg-success' : 'bg-danger'}">
                                                ${u.estActif ? 'Actif' : 'Inactif'}
                                        </span>
                                </td>
                                <td>
                                        ${u.derniereConnexion != null ? u.derniereConnexion : 'Jamais'}
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/utilisateurs/toggle/${u.id}"
                                       class="btn btn-sm ${u.estActif ? 'btn-warning' : 'btn-success'}">
                                        <i class="fas ${u.estActif ? 'fa-pause' : 'fa-play'}"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/utilisateurs/supprimer/${u.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Supprimer cet utilisateur ?')">
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
        Total : ${utilisateurs.size()} utilisateur(s)
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>