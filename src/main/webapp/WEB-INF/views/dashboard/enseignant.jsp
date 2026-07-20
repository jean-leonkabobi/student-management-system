<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header.jsp"/>

<!-- Message de bienvenue -->
<div class="alert alert-success">
    <h4><i class="fas fa-chalkboard-teacher"></i> Bienvenue ${username} !</h4>
    <p>Vous êtes connecté en tant que <strong>${role}</strong>.</p>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-tasks"></i> Espace Enseignant</h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <i class="fas fa-book-open fa-3x text-primary mb-2"></i>
                                <h5>Mes cours</h5>
                                <p class="text-muted">Voir la liste de vos cours</p>
                                <a href="#" class="btn btn-outline-primary">Accéder</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <i class="fas fa-pen fa-3x text-warning mb-2"></i>
                                <h5>Notes</h5>
                                <p class="text-muted">Saisir les notes des étudiants</p>
                                <a href="${pageContext.request.contextPath}/notes/saisie" class="btn btn-outline-warning">Accéder</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <i class="fas fa-calendar-alt fa-3x text-info mb-2"></i>
                                <h5>Emploi du temps</h5>
                                <p class="text-muted">Voir votre emploi du temps</p>
                                <a href="#" class="btn btn-outline-info">Accéder</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>