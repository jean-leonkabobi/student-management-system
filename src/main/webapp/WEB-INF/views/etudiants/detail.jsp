<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";
    boolean isEtudiant = "ETUDIANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/header-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : DÉTAIL DE L'ÉTUDIANT (MON PROFIL) -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-user" style="color: #2563EB;"></i>
        <c:choose>
            <c:when test="<%= isEtudiant %>">Mon Profil</c:when>
            <c:otherwise>Détail de l'Étudiant</c:otherwise>
        </c:choose>
    </h2>
    <c:if test="<%= !isEtudiant %>">
        <div>
            <a href="${pageContext.request.contextPath}/etudiants/modifier/${etudiant.id}" class="btn btn-warning">
                <i class="fas fa-edit"></i> Modifier
            </a>
            <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </c:if>
</div>

<!-- Carte principale -->
<div style="background: var(--card-bg); border-radius: var(--radius); border: 1px solid var(--border); overflow: hidden; box-shadow: var(--shadow);">

    <!-- En-tête avec photo/avatar -->
    <div style="background: linear-gradient(135deg, #2563EB 0%, #1E40AF 100%); padding: 32px 40px; display: flex; align-items: center; gap: 24px; flex-wrap: wrap;">
        <div style="width: 90px; height: 90px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; color: white; font-size: 36px; font-weight: 700; flex-shrink: 0; border: 3px solid rgba(255,255,255,0.3);">
            ${etudiant.prenom.charAt(0)}${etudiant.nom.charAt(0)}
        </div>
        <div style="color: white;">
            <h2 style="font-weight: 700; margin-bottom: 4px; font-size: 24px;">${etudiant.prenom} ${etudiant.nom}</h2>
            <div style="opacity: 0.85; font-size: 14px; display: flex; gap: 16px; flex-wrap: wrap;">
                <span><i class="fas fa-id-card" style="margin-right: 4px;"></i> ${etudiant.matricule}</span>
                <span><i class="fas fa-envelope" style="margin-right: 4px;"></i> ${etudiant.email}</span>
                <span>
                    <span style="display: inline-block; padding: 2px 12px; border-radius: 20px; background: rgba(255,255,255,0.2); font-size: 12px; font-weight: 600;">
                        ${etudiant.statut}
                    </span>
                </span>
            </div>
        </div>
    </div>

    <!-- Corps -->
    <div style="padding: 32px 40px;">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 32px;">

            <!-- Colonne gauche : Informations personnelles -->
            <div>
                <h5 style="font-weight: 600; color: var(--text-primary); margin-bottom: 16px; border-bottom: 2px solid #2563EB; padding-bottom: 8px; display: inline-block;">
                    <i class="fas fa-id-card" style="color: #2563EB;"></i> Informations personnelles
                </h5>
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="padding: 8px 0; color: var(--text-muted); width: 40%;">Matricule</td>
                        <td style="padding: 8px 0; font-weight: 500; color: var(--text-primary);"><strong>${etudiant.matricule}</strong></td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Nom complet</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); font-weight: 500; color: var(--text-primary);">${etudiant.prenom} ${etudiant.nom}</td>
                    </tr>
                    <c:if test="${not empty etudiant.postnom}">
                        <tr>
                            <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Postnom</td>
                            <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.postnom}</td>
                        </tr>
                    </c:if>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Sexe</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.sexe == 'M' ? 'Masculin' : 'Féminin'}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Date de naissance</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">
                            ${etudiant.dateNaissanceFormatted}
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Lieu de naissance</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.lieuNaissance}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Nationalité</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.nationalite}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">État civil</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.etatCivil}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Statut</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border);">
                            <span style="display: inline-block; padding: 2px 12px; border-radius: 20px; font-size: 12px; font-weight: 600;
                                    background: ${etudiant.statut == 'ACTIF' ? 'rgba(34, 197, 94, 0.1)' :
                                    etudiant.statut == 'SUSPENDU' ? 'rgba(245, 158, 11, 0.1)' :
                                            etudiant.statut == 'DIPLOME' ? 'rgba(14, 165, 233, 0.1)' : 'rgba(239, 68, 68, 0.1)'};
                                    color: ${etudiant.statut == 'ACTIF' ? '#22C55E' :
                                    etudiant.statut == 'SUSPENDU' ? '#F59E0B' :
                                            etudiant.statut == 'DIPLOME' ? '#0EA5E9' : '#EF4444'};">
                                ${etudiant.statut}
                            </span>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Colonne droite : Coordonnées -->
            <div>
                <h5 style="font-weight: 600; color: var(--text-primary); margin-bottom: 16px; border-bottom: 2px solid #2563EB; padding-bottom: 8px; display: inline-block;">
                    <i class="fas fa-address-book" style="color: #2563EB;"></i> Coordonnées
                </h5>
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="padding: 8px 0; color: var(--text-muted); width: 40%;">Email</td>
                        <td style="padding: 8px 0; font-weight: 500; color: var(--text-primary);">${etudiant.email}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Téléphone</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.telephone}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Adresse</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.adresse}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Ville</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.ville}</td>
                    </tr>
                    <tr>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-muted);">Pays</td>
                        <td style="padding: 8px 0; border-top: 1px solid var(--border); color: var(--text-primary);">${etudiant.pays}</td>
                    </tr>
                </table>
            </div>

        </div>

        <!-- Lien de retour pour l'étudiant -->
        <c:if test="<%= isEtudiant %>">
            <div style="margin-top: 32px; padding-top: 20px; border-top: 1px solid var(--border);">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour au tableau de bord
                </a>
            </div>
        </c:if>
    </div>
</div>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/footer-commun.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>