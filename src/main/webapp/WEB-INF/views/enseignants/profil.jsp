<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ENSEIGNANT";
    boolean isEnseignant = "ENSEIGNANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/header-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : PROFIL ENSEIGNANT -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-user" style="color: #22C55E;"></i> Mon Profil
    </h2>
</div>

<!-- Carte principale -->
<div style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); overflow: hidden; box-shadow: var(--shadow);">

    <!-- En-tête avec photo/avatar -->
    <div style="background: linear-gradient(135deg, #22C55E 0%, #16A34A 100%); padding: 32px 40px; display: flex; align-items: center; gap: 24px; flex-wrap: wrap;">
        <div style="width: 90px; height: 90px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; color: white; font-size: 36px; font-weight: 700; flex-shrink: 0; border: 3px solid rgba(255,255,255,0.3);">
            ${enseignant.prenom.charAt(0)}${enseignant.nom.charAt(0)}
        </div>
        <div style="color: white;">
            <h2 style="font-weight: 700; margin-bottom: 4px; font-size: 24px;">${enseignant.prenom} ${enseignant.nom}</h2>
            <div style="opacity: 0.85; font-size: 14px; display: flex; gap: 16px; flex-wrap: wrap;">
                <span><i class="fas fa-id-card" style="margin-right: 4px;"></i> ${enseignant.matricule}</span>
                <span><i class="fas fa-envelope" style="margin-right: 4px;"></i> ${enseignant.email}</span>
                <span><i class="fas fa-graduation-cap" style="margin-right: 4px;"></i> ${enseignant.grade}</span>
            </div>
        </div>
    </div>

    <!-- Corps -->
    <div style="padding: 32px 40px;">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 32px;">

            <!-- Colonne gauche : Informations personnelles -->
            <div>
                <h5 style="font-weight: 600; color: var(--text-primary); margin-bottom: 16px; border-bottom: 2px solid #22C55E; padding-bottom: 8px; display: inline-block;">
                    <i class="fas fa-id-card" style="color: #22C55E;"></i> Informations personnelles
                </h5>
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="padding: 8px 0; color: var(--text-muted); width: 40%;">Matricule</td>
                        <td style="padding: 8px 0; font-weight: 500; color: var(--text-primary);"><strong>${enseignant.matricule}</strong></td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Nom complet</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); font-weight: 500; color: var(--text-primary);">${enseignant.prenom} ${enseignant.nom}</td>
                    </tr>
                    <c:if test="${not empty enseignant.postnom}">
                        <tr>
                            <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Postnom</td>
                            <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${enseignant.postnom}</td>
                        </tr>
                    </c:if>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Grade</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${enseignant.grade}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Spécialité</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${enseignant.specialite}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Département</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${enseignant.departement}</td>
                    </tr>
                </table>
            </div>

            <!-- Colonne droite : Coordonnées -->
            <div>
                <h5 style="font-weight: 600; color: var(--text-primary); margin-bottom: 16px; border-bottom: 2px solid #22C55E; padding-bottom: 8px; display: inline-block;">
                    <i class="fas fa-address-book" style="color: #22C55E;"></i> Coordonnées
                </h5>
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="padding: 8px 0; color: var(--text-muted); width: 40%;">Email</td>
                        <td style="padding: 8px 0; font-weight: 500; color: var(--text-primary);">${enseignant.email}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Téléphone</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${enseignant.telephone}</td>
                    </tr>
                </table>
            </div>

        </div>

        <!-- Lien de retour -->
        <div style="margin-top: 32px; padding-top: 20px; border-top: 1px solid var(--border);">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary" style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 24px; border-radius: 8px; background: var(--background); color: var(--text-secondary); text-decoration: none; font-weight: 500; border: 1px solid var(--border); transition: all 0.15s;">
                <i class="fas fa-arrow-left"></i> Retour au tableau de bord
            </a>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/footer-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>