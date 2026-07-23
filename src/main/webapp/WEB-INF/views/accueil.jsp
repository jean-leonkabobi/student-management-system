<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/sidebar.jsp" %>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="page-header">
        <h2><i class="bi bi-speedometer2 me-2"></i>Tableau de bord</h2>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i>${error}</div></c:if>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="stat-card primary">
                <div class="stat-info">
                    <h3>${nbEtudiants}</h3>
                    <p><i class="bi bi-people-fill me-1"></i>Étudiants</p>
                </div>
                <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card success">
                <div class="stat-info">
                    <h3>${nbEnseignants}</h3>
                    <p><i class="bi bi-person-workspace me-1"></i>Enseignants</p>
                </div>
                <div class="stat-icon"><i class="bi bi-person-workspace"></i></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card warning">
                <div class="stat-info">
                    <h3>${nbFilieres}</h3>
                    <p><i class="bi bi-diagram-3-fill me-1"></i>Filières</p>
                </div>
                <div class="stat-icon"><i class="bi bi-diagram-3-fill"></i></div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-md-4">
            <div class="stat-card info">
                <div class="stat-info">
                    <h3>${nbClasses}</h3>
                    <p><i class="bi bi-easel-fill me-1"></i>Classes</p>
                </div>
                <div class="stat-icon"><i class="bi bi-easel-fill"></i></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card accent">
                <div class="stat-info">
                    <h3>${nbMatieres}</h3>
                    <p><i class="bi bi-book-fill me-1"></i>Matières</p>
                </div>
                <div class="stat-icon"><i class="bi bi-book-fill"></i></div>
            </div>
        </div>
    </div>
</main>
<%@ include file="fragments/footer.jsp" %>