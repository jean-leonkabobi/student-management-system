<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ENSEIGNANT";
    if (username == null) username = "Utilisateur";
%>

<jsp:include page="../fragments/header-enseignant.jsp"/>

<!-- Message de bienvenue -->
<div style="background: linear-gradient(135deg, #22C55E 0%, #16A34A 100%); color: white; border-radius: 12px; padding: 24px 28px; margin-bottom: 32px; border: none; box-shadow: 0 4px 15px rgba(34, 197, 94, 0.25);">
    <h4 style="margin-bottom: 4px; font-weight: 600;">
        <i class="fas fa-chalkboard-teacher"></i> Bienvenue <%= username %> !
    </h4>
    <p style="margin-bottom: 0; opacity: 0.85; font-weight: 400;">
        Vous êtes connecté en tant que <strong><%= role %></strong>.
    </p>
</div>

<!-- Cartes -->
<div class="row g-4">
    <div class="col-md-4">
        <div style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(37, 99, 235, 0.1); color: #2563EB;">
                <i class="fas fa-book-open" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Mes cours</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Voir la liste de vos cours</p>
            <a href="${pageContext.request.contextPath}/cours" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #2563EB; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(245, 158, 11, 0.1); color: #F59E0B;">
                <i class="fas fa-pen-fancy" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Notes</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Saisir les notes des étudiants</p>
            <a href="${pageContext.request.contextPath}/notes/saisie" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #F59E0B; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); padding: 32px 24px; text-align: center; transition: all 0.2s ease; height: 100%;">
            <div style="width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; background: rgba(139, 92, 246, 0.1); color: #8B5CF6;">
                <i class="fas fa-calendar-alt" style="font-size: 28px;"></i>
            </div>
            <h5 style="font-weight: 600; margin-bottom: 8px; color: var(--text-primary);">Emploi du temps</h5>
            <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 16px;">Voir votre emploi du temps</p>
            <a href="${pageContext.request.contextPath}/emploi" class="btn-card" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 24px; border-radius: 8px; font-weight: 500; font-size: 14px; text-decoration: none; transition: all 0.15s; background: #8B5CF6; color: white;">
                <i class="fas fa-arrow-right"></i> Accéder
            </a>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer-enseignant.jsp"/>