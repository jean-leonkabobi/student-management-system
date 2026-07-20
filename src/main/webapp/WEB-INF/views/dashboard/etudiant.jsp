<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Récupérer les attributs de session
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";

    if (username == null) username = "Utilisateur";
%>

<jsp:include page="../fragments/header-commun.jsp"/>

<!-- ========================================== -->
<!-- CONTENU : TABLEAU DE BORD ÉTUDIANT -->
<!-- ========================================== -->

<!-- Message de bienvenue -->
<div class="alert-welcome" style="background: linear-gradient(135deg, #2563EB 0%, #1E40AF 100%); color: white; border-radius: 12px; padding: 24px 28px; margin-bottom: 32px; border: none; box-shadow: 0 4px 15px rgba(37, 99, 235, 0.25);">
    <h4 style="margin-bottom: 4px; font-weight: 600;">
        <i class="fas fa-user-graduate"></i> Bienvenue <%= username %> !
    </h4>
    <p style="margin-bottom: 0; opacity: 0.85; font-weight: 400;">
        Vous êtes connecté en tant que <strong><%= role %></strong>.
    </p>
</div>

<!-- Cards -->
<div class="row g-4">
    <div class="col-md-4">
        <div class="card-modern" style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(37, 99, 235, 0.1); color: #2563EB;">
                <i class="fas fa-id-card" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Mes informations</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Consulter vos informations personnelles</p>
            <a href="${pageContext.request.contextPath}/etudiants/detail/${sessionScope.utilisateur.etudiant.id}"
               class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #2563EB; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-modern" style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(34, 197, 94, 0.1); color: #22C55E;">
                <i class="fas fa-file-alt" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Mes notes</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Consulter vos notes par matière</p>
            <a href="${pageContext.request.contextPath}/notes" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #22C55E; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-modern" style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(245, 158, 11, 0.1); color: #F59E0B;">
                <i class="fas fa-calendar-alt" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Emploi du temps</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Voir votre emploi du temps personnel</p>
            <a href="${pageContext.request.contextPath}/emploi" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #F59E0B; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>
</div>

<!-- Section paiements -->
<div class="row g-4 mt-2">
    <div class="col-md-6">
        <div class="card-modern" style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 24px; text-align: left; transition: all 0.2s ease; height: 100%;">
            <h5 style="margin-bottom: 16px; font-weight: 600; color: var(--text-primary);">
                <i class="fas fa-coins" style="color: #2563EB;"></i> Mes paiements
            </h5>
            <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
                <span style="color: var(--text-secondary);">Total payé</span>
                <span style="font-weight: 600; color: #22C55E;">0 €</span>
            </div>
            <div style="display: flex; justify-content: space-between; padding: 10px 0;">
                <span style="color: var(--text-secondary);">Reste à payer</span>
                <span style="font-weight: 600; color: #EF4444;">0 €</span>
            </div>
            <a href="${pageContext.request.contextPath}/paiements" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; margin-top: 12px; background: #2563EB; color: white;">
                <i class="fas fa-arrow-right"></i> Voir mes paiements
            </a>
        </div>
    </div>

</div>

<jsp:include page="../fragments/footer-commun.jsp"/>