<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Tableau de bord</h1>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}</div>
    </c:if>

    <div class="row">
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="card-title">Étudiants</h5>
                            <h2>${nbEtudiants}</h2>
                        </div>
                        <i class="bi bi-people-fill" style="font-size: 3rem; opacity: 0.4;"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/etudiants" class="text-white">Voir plus →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="card-title">Enseignants</h5>
                            <h2>${nbEnseignants}</h2>
                        </div>
                        <i class="bi bi-person-workspace" style="font-size: 3rem; opacity: 0.4;"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/enseignants" class="text-white">Voir plus →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="card-title">Filières</h5>
                            <h2>${nbFilieres}</h2>
                        </div>
                        <i class="bi bi-diagram-3-fill" style="font-size: 3rem; opacity: 0.4;"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/filieres" class="text-white">Voir plus →</a>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="card-title">Classes</h5>
                            <h2>${nbClasses}</h2>
                        </div>
                        <i class="bi bi-easel-fill" style="font-size: 3rem; opacity: 0.4;"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/classes" class="text-white">Voir plus →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-secondary">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="card-title">Matières</h5>
                            <h2>${nbMatieres}</h2>
                        </div>
                        <i class="bi bi-book-fill" style="font-size: 3rem; opacity: 0.4;"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/matieres" class="text-white">Voir plus →</a>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="fragments/footer.jsp" %>