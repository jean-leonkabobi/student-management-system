<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ADMIN";
    if (username == null) username = "Administrateur";
%>

<jsp:include page="../fragments/header.jsp"/>

<!-- ========================================== -->
<!-- EN-TÊTE DE LA PAGE -->
<!-- ========================================== -->
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 12px;">
    <div>
        <h2 style="font-size: 22px; font-weight: 700; color: #0F172A; margin-bottom: 4px;">
            <i class="fas fa-th-large" style="color: #2563EB;"></i> Tableau de bord
        </h2>
        <p style="color: #94A3B8; font-size: 14px; margin-bottom: 0;">
            Vue d'ensemble de votre établissement
        </p>
    </div>
    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
        <a href="${pageContext.request.contextPath}/etudiants"
           style="display: inline-flex; align-items: center; gap: 6px; padding: 8px 18px; background: #2563EB; color: white; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.15s;">
            <i class="fas fa-users"></i> Étudiants
        </a>
        <a href="${pageContext.request.contextPath}/enseignants"
           style="display: inline-flex; align-items: center; gap: 6px; padding: 8px 18px; background: #22C55E; color: white; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.15s;">
            <i class="fas fa-chalkboard-teacher"></i> Enseignants
        </a>
    </div>
</div>

<!-- ========================================== -->
<!-- MESSAGE DE BIENVENUE AMÉLIORÉ -->
<!-- ========================================== -->
<div style="background: linear-gradient(135deg, #1E40AF 0%, #2563EB 50%, #3B82F6 100%); border-radius: 16px; padding: 28px 32px; margin-bottom: 32px; box-shadow: 0 8px 30px rgba(37, 99, 235, 0.25); position: relative; overflow: hidden;">

    <!-- Effet de fond décoratif -->
    <div style="position: absolute; top: -50px; right: -50px; width: 200px; height: 200px; border-radius: 50%; background: rgba(255,255,255,0.05);"></div>
    <div style="position: absolute; bottom: -80px; left: 30%; width: 300px; height: 300px; border-radius: 50%; background: rgba(255,255,255,0.03);"></div>

    <div style="position: relative; z-index: 1; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px;">
        <div>
            <div style="display: flex; align-items: center; gap: 14px;">
                <div style="width: 56px; height: 56px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; border: 2px solid rgba(255,255,255,0.3);">
                    <i class="fas fa-user-shield" style="font-size: 26px; color: white;"></i>
                </div>
                <div>
                    <h4 style="margin-bottom: 2px; font-weight: 700; color: white; font-size: 22px;">
                        Bonjour, <%= username %> <span style="font-weight: 300;">👋</span>
                    </h4>
                    <p style="margin-bottom: 0; color: rgba(255,255,255,0.8); font-size: 14px;">
                        <i class="fas fa-circle" style="font-size: 8px; color: #22C55E; margin-right: 8px; vertical-align: middle;"></i>
                        Administrateur · <span style="opacity: 0.7;">Aujourd'hui, <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/></span>
                    </p>
                </div>
            </div>
        </div>
        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
            <span style="background: rgba(255,255,255,0.15); padding: 6px 16px; border-radius: 20px; color: white; font-size: 13px; display: flex; align-items: center; gap: 6px;">
                <i class="fas fa-calendar-alt"></i>
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/>
            </span>
            <span style="background: rgba(255,255,255,0.15); padding: 6px 16px; border-radius: 20px; color: white; font-size: 13px; display: flex; align-items: center; gap: 6px;">
                <i class="fas fa-clock"></i>
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="HH:mm"/>
            </span>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- STATISTIQUES -->
<!-- ========================================== -->
<div class="row g-3 mb-4">
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 20px 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; margin-bottom: 4px; text-transform: uppercase; letter-spacing: 0.5px;">Étudiants</h6>
                        <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px; color: #0F172A;">${totalEtudiants}</h3>
                        <span style="font-size: 12px; color: #22C55E; font-weight: 500;">
                            <i class="fas fa-arrow-up"></i> +12%
                        </span>
                    </div>
                    <div style="width: 44px; height: 44px; border-radius: 10px; background: #2563EB; display: flex; align-items: center; justify-content: center; color: white;">
                        <i class="fas fa-users" style="font-size: 18px;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 20px 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; margin-bottom: 4px; text-transform: uppercase; letter-spacing: 0.5px;">Enseignants</h6>
                        <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px; color: #0F172A;">${totalEnseignants}</h3>
                        <span style="font-size: 12px; color: #22C55E; font-weight: 500;">
                            <i class="fas fa-arrow-up"></i> +5%
                        </span>
                    </div>
                    <div style="width: 44px; height: 44px; border-radius: 10px; background: #22C55E; display: flex; align-items: center; justify-content: center; color: white;">
                        <i class="fas fa-chalkboard-teacher" style="font-size: 18px;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 20px 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; margin-bottom: 4px; text-transform: uppercase; letter-spacing: 0.5px;">Inscriptions</h6>
                        <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px; color: #0F172A;">${totalInscriptions}</h3>
                        <span style="font-size: 12px; color: #F59E0B; font-weight: 500;">
                            <i class="fas fa-minus"></i> Stable
                        </span>
                    </div>
                    <div style="width: 44px; height: 44px; border-radius: 10px; background: #F59E0B; display: flex; align-items: center; justify-content: center; color: white;">
                        <i class="fas fa-graduation-cap" style="font-size: 18px;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 20px 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; margin-bottom: 4px; text-transform: uppercase; letter-spacing: 0.5px;">Paiements</h6>
                        <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px; color: #0F172A;">
                            <fmt:formatNumber value="${totalPaiementsMontant}" type="currency" currencySymbol="€"/>
                        </h3>
                        <span style="font-size: 12px; color: #22C55E; font-weight: 500;">
                            <i class="fas fa-arrow-up"></i> +8%
                        </span>
                    </div>
                    <div style="width: 44px; height: 44px; border-radius: 10px; background: #8B5CF6; display: flex; align-items: center; justify-content: center; color: white;">
                        <i class="fas fa-coins" style="font-size: 18px;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- GRAPHIQUES -->
<!-- ========================================== -->
<div class="row g-3">
    <div class="col-md-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="padding: 16px 20px; border-bottom: 1px solid #E2E8F0;">
                <h5 style="font-weight: 600; margin-bottom: 0; font-size: 15px; color: #0F172A;">
                    <i class="fas fa-chart-pie" style="color: #2563EB;"></i> Étudiants par statut
                </h5>
            </div>
            <div style="padding: 20px;">
                <c:forEach items="${etudiantsParStatut}" var="entry">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                        <span style="font-size: 13px; color: #475569;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 3px; margin-right: 8px;
                                    background: ${entry.key == 'ACTIF' ? '#22C55E' :
                                    entry.key == 'SUSPENDU' ? '#F59E0B' :
                                            entry.key == 'DIPLOME' ? '#3B82F6' : '#EF4444'};"></span>
                            ${entry.key}
                        </span>
                        <span style="font-weight: 600; font-size: 13px; color: #0F172A;">${entry.value}</span>
                    </div>
                    <div style="background: #F1F5F9; border-radius: 4px; height: 6px; margin-bottom: 10px; overflow: hidden;">
                        <div style="border-radius: 4px; height: 6px; width: ${totalEtudiants > 0 ? (entry.value / totalEtudiants * 100) : 0}%;
                                background: ${entry.key == 'ACTIF' ? '#22C55E' :
                                entry.key == 'SUSPENDU' ? '#F59E0B' :
                                        entry.key == 'DIPLOME' ? '#3B82F6' : '#EF4444'};"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="padding: 16px 20px; border-bottom: 1px solid #E2E8F0;">
                <h5 style="font-weight: 600; margin-bottom: 0; font-size: 15px; color: #0F172A;">
                    <i class="fas fa-chart-bar" style="color: #22C55E;"></i> Paiements par statut
                </h5>
            </div>
            <div style="padding: 20px;">
                <c:forEach items="${paiementsParStatut}" var="entry">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                        <span style="font-size: 13px; color: #475569;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 3px; margin-right: 8px;
                                    background: ${entry.key == 'PAYE' ? '#22C55E' :
                                    entry.key == 'PARTIEL' ? '#F59E0B' :
                                            entry.key == 'EN_RETARD' ? '#EF4444' : '#94A3B8'};"></span>
                            ${entry.key}
                        </span>
                        <span style="font-weight: 600; font-size: 13px; color: #0F172A;">${entry.value}</span>
                    </div>
                    <div style="background: #F1F5F9; border-radius: 4px; height: 6px; margin-bottom: 10px; overflow: hidden;">
                        <div style="border-radius: 4px; height: 6px; width: ${totalPaiements > 0 ? (entry.value / totalPaiements * 100) : 0}%;
                                background: ${entry.key == 'PAYE' ? '#22C55E' :
                                entry.key == 'PARTIEL' ? '#F59E0B' :
                                        entry.key == 'EN_RETARD' ? '#EF4444' : '#94A3B8'};"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- INFORMATIONS SUPPLÉMENTAIRES -->
<!-- ========================================== -->
<div class="row g-3 mt-2">
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 16px 20px; display: flex; align-items: center; gap: 14px;">
                <div style="width: 40px; height: 40px; border-radius: 10px; background: rgba(245, 158, 11, 0.1); display: flex; align-items: center; justify-content: center; color: #F59E0B;">
                    <i class="fas fa-book-open"></i>
                </div>
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 500; margin-bottom: 2px; text-transform: uppercase; letter-spacing: 0.5px;">Matières</h6>
                    <h4 style="font-weight: 700; margin-bottom: 0; font-size: 20px; color: #0F172A;">${totalMatieres}</h4>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 16px 20px; display: flex; align-items: center; gap: 14px;">
                <div style="width: 40px; height: 40px; border-radius: 10px; background: rgba(139, 92, 246, 0.1); display: flex; align-items: center; justify-content: center; color: #8B5CF6;">
                    <i class="fas fa-layer-group"></i>
                </div>
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 500; margin-bottom: 2px; text-transform: uppercase; letter-spacing: 0.5px;">Filières</h6>
                    <h4 style="font-weight: 700; margin-bottom: 0; font-size: 20px; color: #0F172A;">${totalFilieres}</h4>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: all 0.2s;">
            <div style="padding: 16px 20px; display: flex; align-items: center; gap: 14px;">
                <div style="width: 40px; height: 40px; border-radius: 10px; background: rgba(239, 68, 68, 0.1); display: flex; align-items: center; justify-content: center; color: #EF4444;">
                    <i class="fas fa-calculator"></i>
                </div>
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 500; margin-bottom: 2px; text-transform: uppercase; letter-spacing: 0.5px;">Moyenne générale</h6>
                    <h4 style="font-weight: 700; margin-bottom: 0; font-size: 20px; color: #0F172A;">${moyenneGenerale != null ? moyenneGenerale : '-'}</h4>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>