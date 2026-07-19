<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h4><i class="fas fa-user"></i> Détail de l'étudiant</h4>
        <div>
            <a href="${pageContext.request.contextPath}/etudiants/modifier/${etudiant.id}" class="btn btn-warning">
                <i class="fas fa-edit"></i> Modifier
            </a>
            <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Informations personnelles</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Matricule</th>
                        <td><strong>${etudiant.matricule}</strong></td>
                    </tr>
                    <tr>
                        <th>Nom complet</th>
                        <td>${etudiant.prenom} ${etudiant.nom}</td>
                    </tr>
                    <tr>
                        <th>Postnom</th>
                        <td>${etudiant.postnom}</td>
                    </tr>
                    <tr>
                        <th>Sexe</th>
                        <td>${etudiant.sexe == 'M' ? 'Masculin' : 'Féminin'}</td>
                    </tr>
                    <tr>
                        <th>Date de naissance</th>
                        <td><fmt:formatDate value="${etudiant.dateNaissance}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    <tr>
                        <th>Lieu de naissance</th>
                        <td>${etudiant.lieuNaissance}</td>
                    </tr>
                    <tr>
                        <th>Nationalité</th>
                        <td>${etudiant.nationalite}</td>
                    </tr>
                    <tr>
                        <th>État civil</th>
                        <td>${etudiant.etatCivil}</td>
                    </tr>
                    <tr>
                        <th>Statut</th>
                        <td>
                            <span class="badge
                                ${etudiant.statut == 'ACTIF' ? 'bg-success' :
                                  etudiant.statut == 'SUSPENDU' ? 'bg-warning' :
                                  etudiant.statut == 'DIPLOME' ? 'bg-info' : 'bg-danger'}">
                                ${etudiant.statut}
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Coordonnées</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Email</th>
                        <td>${etudiant.email}</td>
                    </tr>
                    <tr>
                        <th>Téléphone</th>
                        <td>${etudiant.telephone}</td>
                    </tr>
                    <tr>
                        <th>Adresse</th>
                        <td>${etudiant.adresse}</td>
                    </tr>
                    <tr>
                        <th>Ville</th>
                        <td>${etudiant.ville}</td>
                    </tr>
                    <tr>
                        <th>Pays</th>
                        <td>${etudiant.pays}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>