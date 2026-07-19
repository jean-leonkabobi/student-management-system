<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-search"></i> Recherche avancée</h4>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/etudiants/recherche" method="get" class="row g-3">
            <div class="col-md-4">
                <label class="form-label">Matricule</label>
                <input type="text" name="matricule" class="form-control" value="${matricule}" placeholder="ETU-2024-001">
            </div>
            <div class="col-md-4">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" class="form-control" value="${nom}" placeholder="Dupont">
            </div>
            <div class="col-md-4">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" class="form-control" value="${prenom}" placeholder="Jean">
            </div>
            <div class="col-md-6">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="${email}" placeholder="jean@email.com">
            </div>
            <div class="col-md-6">
                <label class="form-label">Statut</label>
                <select name="statut" class="form-select">
                    <option value="">Tous les statuts</option>
                    <option value="ACTIF" ${statut == 'ACTIF' ? 'selected' : ''}>ACTIF</option>
                    <option value="SUSPENDU" ${statut == 'SUSPENDU' ? 'selected' : ''}>SUSPENDU</option>
                    <option value="DIPLOME" ${statut == 'DIPLOME' ? 'selected' : ''}>DIPLOME</option>
                    <option value="ABANDONNE" ${statut == 'ABANDONNE' ? 'selected' : ''}>ABANDONNE</option>
                </select>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Rechercher
                </button>
                <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">
                    <i class="fas fa-undo"></i> Réinitialiser
                </a>
            </div>
        </form>
    </div>
</div>

<!-- Résultats -->
<c:if test="${not empty etudiants}">
    <div class="card mt-3">
        <div class="card-header">
            <h5>Résultats (${etudiants.size()})</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Matricule</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Email</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${etudiants}" var="e">
                        <tr>
                            <td><strong>${e.matricule}</strong></td>
                            <td>${e.nom}</td>
                            <td>${e.prenom}</td>
                            <td>${e.email}</td>
                            <td>
                                    <span class="badge
                                        ${e.statut == 'ACTIF' ? 'bg-success' :
                                          e.statut == 'SUSPENDU' ? 'bg-warning' :
                                          e.statut == 'DIPLOME' ? 'bg-info' : 'bg-danger'}">
                                            ${e.statut}
                                    </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/etudiants/detail/${e.id}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="../fragments/footer.jsp"/>