<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../fragments/header-scolarite.jsp"/>

<!-- Message de bienvenue -->
<div style="background: linear-gradient(135deg, #7C3AED 0%, #8B5CF6 50%, #A78BFA 100%); border-radius: 16px; padding: 24px 28px; margin-bottom: 32px; box-shadow: 0 4px 15px rgba(139, 92, 246, 0.25);">
    <h4 style="margin-bottom: 4px; font-weight: 600; color: white;">
        <i class="fas fa-graduation-cap"></i> Bienvenue ${username} !
    </h4>
    <p style="margin-bottom: 0; opacity: 0.85; font-weight: 400; color: rgba(255,255,255,0.9);">
        Vous êtes connecté en tant que <strong>SCOLARITÉ</strong>.
    </p>
</div>

<!-- Statistiques -->
<div class="row g-3 mb-4">
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 20px 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Étudiants</h6>
                    <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px;">${totalEtudiants}</h3>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 10px; background: #2563EB; display: flex; align-items: center; justify-content: center; color: white;">
                    <i class="fas fa-users" style="font-size: 18px;"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 20px 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Enseignants</h6>
                    <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px;">${totalEnseignants}</h3>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 10px; background: #22C55E; display: flex; align-items: center; justify-content: center; color: white;">
                    <i class="fas fa-chalkboard-teacher" style="font-size: 18px;"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 20px 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Inscriptions</h6>
                    <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px;">${totalInscriptions}</h3>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 10px; background: #F59E0B; display: flex; align-items: center; justify-content: center; color: white;">
                    <i class="fas fa-graduation-cap" style="font-size: 18px;"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 20px 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Matières</h6>
                    <h3 style="font-weight: 700; margin-bottom: 0; font-size: 28px;">${totalMatieres}</h3>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 10px; background: #8B5CF6; display: flex; align-items: center; justify-content: center; color: white;">
                    <i class="fas fa-book-open" style="font-size: 18px;"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Graphiques -->
<div class="row g-3">
    <div class="col-md-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="padding: 16px 20px; border-bottom: 1px solid #E2E8F0;">
                <h5 style="font-weight: 600; margin-bottom: 0; font-size: 15px;">
                    <i class="fas fa-chart-pie" style="color: #2563EB;"></i> Étudiants par statut
                </h5>
            </div>
            <div style="padding: 20px;">
                <c:forEach items="${etudiantsParStatut}" var="entry">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                        <span style="font-size: 13px; color: #475569;">${entry.key}</span>
                        <span style="font-weight: 600; font-size: 13px;">${entry.value}</span>
                    </div>
                    <div style="background: #F1F5F9; border-radius: 4px; height: 6px; margin-bottom: 10px;">
                        <div style="background: #2563EB; border-radius: 4px; height: 6px; width: ${totalEtudiants > 0 ? (entry.value / totalEtudiants * 100) : 0}%;"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
            <div style="padding: 16px 20px; border-bottom: 1px solid #E2E8F0;">
                <h5 style="font-weight: 600; margin-bottom: 0; font-size: 15px;">
                    <i class="fas fa-chart-bar" style="color: #22C55E;"></i> Paiements par statut
                </h5>
            </div>
            <div style="padding: 20px;">
                <c:forEach items="${paiementsParStatut}" var="entry">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                        <span style="font-size: 13px; color: #475569;">${entry.key}</span>
                        <span style="font-weight: 600; font-size: 13px;">${entry.value}</span>
                    </div>
                    <div style="background: #F1F5F9; border-radius: 4px; height: 6px; margin-bottom: 10px;">
                        <div style="background: #22C55E; border-radius: 4px; height: 6px; width: ${totalPaiements > 0 ? (entry.value / totalPaiements * 100) : 0}%;"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Informations supplémentaires -->
<div class="row g-3 mt-2">
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 16px 20px;">
            <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">
                <i class="fas fa-coins" style="color: #8B5CF6;"></i> Total paiements
            </h6>
            <h4 style="font-weight: 700; margin-bottom: 0;">
                <fmt:formatNumber value="${totalPaiementsMontant}" type="currency" currencySymbol="€"/>
            </h4>
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 16px 20px;">
            <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">
                <i class="fas fa-layer-group" style="color: #F59E0B;"></i> Filières
            </h6>
            <h4 style="font-weight: 700; margin-bottom: 0;">${totalFilieres}</h4>
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div style="background: white; border-radius: 12px; border: 1px solid #E2E8F0; padding: 16px 20px;">
            <h6 style="color: #94A3B8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">
                <i class="fas fa-calculator" style="color: #EF4444;"></i> Moyenne générale
            </h6>
            <h4 style="font-weight: 700; margin-bottom: 0;">${moyenneGenerale != null ? moyenneGenerale : '-'}</h4>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer-scolarite.jsp"/>