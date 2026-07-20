<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../fragments/header-etudiant.jsp"/>

<!-- Message de bienvenue -->
<div class="alert alert-primary border-0 shadow-sm" style="background: linear-gradient(135deg, #2563EB, #1E40AF); color: white; border-radius: 12px; padding: 24px; margin-bottom: 32px;">
    <h4 style="margin-bottom: 4px;"><i class="fas fa-user-graduate"></i> Bienvenue ${username} !</h4>
    <p style="margin-bottom: 0; opacity: 0.85;">Vous êtes connecté en tant que <strong>${role}</strong>.</p>
</div>

<!-- Cards -->
<div class="row g-4">
    <div class="col-md-4">
        <div class="card-modern text-center" style="padding: 32px 24px;">
            <div style="width: 64px; height: 64px; background: rgba(37, 99, 235, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <i class="fas fa-id-card" style="font-size: 28px; color: #2563EB;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px;">Mes informations</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Consulter vos informations personnelles</p>
            <a href="#" class="btn btn-primary" style="background: #2563EB; border: none; padding: 8px 24px; border-radius: 8px; color: white; text-decoration: none; font-weight: 500; transition: all 0.15s;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-modern text-center" style="padding: 32px 24px;">
            <div style="width: 64px; height: 64px; background: rgba(34, 197, 94, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <i class="fas fa-file-alt" style="font-size: 28px; color: #22C55E;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px;">Mes notes</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Consulter vos notes par matière</p>
            <a href="${pageContext.request.contextPath}/notes" class="btn btn-success" style="background: #22C55E; border: none; padding: 8px 24px; border-radius: 8px; color: white; text-decoration: none; font-weight: 500; transition: all 0.15s;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-modern text-center" style="padding: 32px 24px;">
            <div style="width: 64px; height: 64px; background: rgba(245, 158, 11, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                <i class="fas fa-calendar-alt" style="font-size: 28px; color: #F59E0B;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px;">Emploi du temps</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Voir votre emploi du temps</p>
            <a href="#" class="btn btn-warning" style="background: #F59E0B; border: none; padding: 8px 24px; border-radius: 8px; color: white; text-decoration: none; font-weight: 500; transition: all 0.15s;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>
</div>

<!-- Section paiements -->
<div class="row mt-4">
    <div class="col-md-6">
        <div class="card-modern">
            <h5 style="font-weight: 600; margin-bottom: 16px;">
                <i class="fas fa-coins" style="color: #2563EB;"></i> Mes paiements
            </h5>
            <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--border);">
                <span style="color: var(--text-secondary);">Total payé</span>
                <span style="font-weight: 600; color: #22C55E;">0 €</span>
            </div>
            <div style="display: flex; justify-content: space-between; padding: 12px 0;">
                <span style="color: var(--text-secondary);">Reste à payer</span>
                <span style="font-weight: 600; color: #EF4444;">0 €</span>
            </div>
            <a href="${pageContext.request.contextPath}/paiements" class="btn btn-outline-primary w-100 mt-2" style="border-color: #2563EB; color: #2563EB; border-radius: 8px; padding: 10px; text-decoration: none; text-align: center; font-weight: 500;">
                Voir tous mes paiements
            </a>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card-modern">
            <h5 style="font-weight: 600; margin-bottom: 16px;">
                <i class="fas fa-graduation-cap" style="color: #2563EB;"></i> Mes inscriptions
            </h5>
            <div style="padding: 12px 0; border-bottom: 1px solid var(--border);">
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: var(--text-secondary);">Filière</span>
                    <span style="font-weight: 500;">-</span>
                </div>
            </div>
            <div style="padding: 12px 0;">
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: var(--text-secondary);">Niveau</span>
                    <span style="font-weight: 500;">-</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/inscriptions" class="btn btn-outline-primary w-100 mt-2" style="border-color: #2563EB; color: #2563EB; border-radius: 8px; padding: 10px; text-decoration: none; text-align: center; font-weight: 500;">
                Voir mes inscriptions
            </a>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer-etudiant.jsp"/>