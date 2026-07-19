<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h4><i class="fas fa-user-graduate"></i> Détail de l'inscription</h4>
        <div>
            <a href="${pageContext.request.contextPath}/inscriptions" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Informations générales</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>ID</th>
                        <td>${inscription.id}</td>
                    </tr>
                    <tr>
                        <th>Date d'inscription</th>
                        <td>${inscription.dateInscriptionFormatted}</td>
                    </tr>
                    <tr>
                        <th>Statut</th>
                        <td>
                            <span class="badge
                                ${inscription.statut == 'INSCRIT' ? 'bg-success' :
                                  inscription.statut == 'REINSCRIT' ? 'bg-info' :
                                  inscription.statut == 'SUSPENDU' ? 'bg-warning' : 'bg-danger'}">
                                ${inscription.statut}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>Créée le</th>
                        <td>${inscription.createdAt}</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Étudiant</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Matricule</th>
                        <td><strong>${inscription.etudiant.matricule}</strong></td>
                    </tr>
                    <tr>
                        <th>Nom complet</th>
                        <td>${inscription.etudiant.prenom} ${inscription.etudiant.nom}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${inscription.etudiant.email}</td>
                    </tr>
                    <tr>
                        <th>Téléphone</th>
                        <td>${inscription.etudiant.telephone}</td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Filière</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Code</th>
                        <td><strong>${inscription.filiere.code}</strong></td>
                    </tr>
                    <tr>
                        <th>Nom</th>
                        <td>${inscription.filiere.nom}</td>
                    </tr>
                    <tr>
                        <th>Département</th>
                        <td>${inscription.filiere.departement}</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5 class="border-bottom pb-2">Niveau et Année</h5>
                <table class="table table-borderless">
                    <tr>
                        <th>Niveau</th>
                        <td><strong>${inscription.niveau.code}</strong> - ${inscription.niveau.nom}</td>
                    </tr>
                    <tr>
                        <th>Année académique</th>
                        <td>${inscription.anneeAcademique.libelle}</td>
                    </tr>
                    <tr>
                        <th>Année active</th>
                        <td>${inscription.anneeAcademique.estActive ? 'Oui' : 'Non'}</td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/notes?inscriptionId=${inscription.id}" class="btn btn-outline-primary">
                <i class="fas fa-pen"></i> Voir les notes
            </a>
            <a href="${pageContext.request.contextPath}/paiements?inscriptionId=${inscription.id}" class="btn btn-outline-success">
                <i class="fas fa-coins"></i> Voir les paiements
            </a>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>