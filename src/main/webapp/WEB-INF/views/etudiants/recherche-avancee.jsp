<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header">
        <h4><i class="fas fa-search-plus"></i> Recherche multicritère avancée</h4>
    </div>
    <div class="card-body">
        <form id="rechercheForm" method="get" class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Matricule</label>
                <input type="text" name="matricule" class="form-control" placeholder="ETU-2024-001"
                       value="${param.matricule}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" class="form-control" placeholder="Dupont"
                       value="${param.nom}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" class="form-control" placeholder="Jean"
                       value="${param.prenom}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="jean@email.com"
                       value="${param.email}">
            </div>
            <div class="col-md-3">
                <label class="form-label">Statut</label>
                <select name="statut" class="form-select">
                    <option value="">Tous</option>
                    <option value="ACTIF" ${param.statut == 'ACTIF' ? 'selected' : ''}>ACTIF</option>
                    <option value="SUSPENDU" ${param.statut == 'SUSPENDU' ? 'selected' : ''}>SUSPENDU</option>
                    <option value="DIPLOME" ${param.statut == 'DIPLOME' ? 'selected' : ''}>DIPLOME</option>
                    <option value="ABANDONNE" ${param.statut == 'ABANDONNE' ? 'selected' : ''}>ABANDONNE</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Filière</label>
                <select name="filiereId" class="form-select">
                    <option value="">Toutes</option>
                    <c:forEach items="${filieres}" var="f">
                        <option value="${f.id}" ${param.filiereId == f.id ? 'selected' : ''}>${f.nom}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Niveau</label>
                <select name="niveauId" class="form-select">
                    <option value="">Tous</option>
                    <c:forEach items="${niveaux}" var="n">
                        <option value="${n.id}" ${param.niveauId == n.id ? 'selected' : ''}>${n.nom}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-search"></i> Rechercher
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Résultats -->
<c:if test="${not empty etudiants}">
    <div class="card mt-3">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5>Résultats de la recherche (${etudiants.size()})</h5>
            <div>
                <button class="btn btn-sm btn-success" onclick="exporterExcel()">
                    <i class="fas fa-file-excel"></i> Exporter Excel
                </button>
                <button class="btn btn-sm btn-danger" onclick="exporterPDF()">
                    <i class="fas fa-file-pdf"></i> Exporter PDF
                </button>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="resultatsTable">
                    <thead>
                    <tr>
                        <th>Matricule</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Email</th>
                        <th>Téléphone</th>
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
                            <td>${e.telephone}</td>
                            <td>
                                    <span class="badge
                                        ${e.statut == 'ACTIF' ? 'bg-success' :
                                          e.statut == 'SUSPENDU' ? 'bg-warning' :
                                          e.statut == 'DIPLOME' ? 'bg-info' : 'bg-danger'}">
                                            ${e.statut}
                                    </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/etudiants/detail/${e.id}"
                                   class="btn btn-sm btn-outline-primary">
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

<script>
    function exporterExcel() {
        alert('Fonctionnalité d\'export Excel à implémenter');
    }

    function exporterPDF() {
        alert('Fonctionnalité d\'export PDF à implémenter');
    }
</script>

<jsp:include page="../fragments/footer.jsp"/>