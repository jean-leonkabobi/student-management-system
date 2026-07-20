<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Récupérer les attributs de session
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";

    if (username == null) username = "Utilisateur";
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Étudiant</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* ==========================================
           STYLES GLOBAUX
           ========================================== */
        :root {
            --primary: #2563EB;
            --primary-dark: #1E40AF;
            --primary-light: #3B82F6;
            --success: #22C55E;
            --warning: #F59E0B;
            --danger: #EF4444;
            --background: #F1F5F9;
            --card-bg: #FFFFFF;
            --text-primary: #0F172A;
            --text-secondary: #475569;
            --text-muted: #94A3B8;
            --border: #E2E8F0;
            --radius: 12px;
            --shadow: 0 1px 3px rgba(0,0,0,0.06);
            --shadow-hover: 0 4px 20px rgba(0,0,0,0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--background);
            color: var(--text-primary);
            min-height: 100vh;
        }

        /* ==========================================
           HEADER
           ========================================== */
        .top-header {
            background: var(--card-bg);
            border-bottom: 1px solid var(--border);
            padding: 0 32px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }

        .top-header .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--text-primary);
        }

        .top-header .brand .logo {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .top-header .brand .brand-text {
            font-size: 18px;
            font-weight: 700;
        }

        .top-header .brand .brand-text span {
            color: var(--primary);
        }

        .top-header .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .top-header .header-right .user-info {
            text-align: right;
        }

        .top-header .header-right .user-info .name {
            font-weight: 600;
            font-size: 14px;
            color: var(--text-primary);
        }

        .top-header .header-right .user-info .role {
            font-size: 12px;
            color: var(--text-muted);
        }

        .top-header .header-right .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            flex-shrink: 0;
        }

        /* ==========================================
           CONTENU PRINCIPAL
           ========================================== */
        .main-content {
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 32px 40px;
        }

        /* ==========================================
           BREADCRUMB
           ========================================== */
        .breadcrumb-custom {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .breadcrumb-custom a {
            color: var(--primary);
            text-decoration: none;
        }

        .breadcrumb-custom a:hover {
            text-decoration: underline;
        }

        .breadcrumb-custom span {
            margin: 0 8px;
        }

        /* ==========================================
           PAGE TITLE
           ========================================== */
        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
            color: var(--text-primary);
        }

        /* ==========================================
           ALERT
           ========================================== */
        .alert-welcome {
            background: linear-gradient(135deg, #2563EB 0%, #1E40AF 100%);
            color: white;
            border-radius: var(--radius);
            padding: 24px 28px;
            margin-bottom: 32px;
            border: none;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.25);
        }

        .alert-welcome h4 {
            margin-bottom: 4px;
            font-weight: 600;
        }

        .alert-welcome p {
            margin-bottom: 0;
            opacity: 0.85;
            font-weight: 400;
        }

        /* ==========================================
           CARDS
           ========================================== */
        .card-modern {
            background: var(--card-bg);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            padding: 32px 24px;
            text-align: center;
            transition: all 0.2s ease;
            height: 100%;
        }

        .card-modern:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }

        .card-modern .icon-wrapper {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .card-modern .icon-wrapper.blue {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary);
        }

        .card-modern .icon-wrapper.green {
            background: rgba(34, 197, 94, 0.1);
            color: var(--success);
        }

        .card-modern .icon-wrapper.orange {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .card-modern .icon-wrapper i {
            font-size: 28px;
        }

        .card-modern h5 {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .card-modern p {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 16px;
        }

        .card-modern .btn-card {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 24px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.15s;
        }

        .card-modern .btn-card.primary {
            background: var(--primary);
            color: white;
        }

        .card-modern .btn-card.primary:hover {
            background: var(--primary-dark);
        }

        .card-modern .btn-card.success {
            background: var(--success);
            color: white;
        }

        .card-modern .btn-card.success:hover {
            background: #16A34A;
        }

        .card-modern .btn-card.warning {
            background: var(--warning);
            color: white;
        }

        .card-modern .btn-card.warning:hover {
            background: #D97706;
        }

        /* ==========================================
           FOOTER
           ========================================== */
        .footer-custom {
            text-align: center;
            color: var(--text-muted);
            margin-top: 48px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
            font-size: 14px;
        }

        .footer-custom i {
            margin-right: 6px;
        }

        /* ==========================================
           RESPONSIVE
           ========================================== */
        @media (max-width: 768px) {
            .top-header {
                padding: 0 16px;
            }

            .top-header .brand .brand-text {
                font-size: 16px;
            }

            .top-header .header-right .user-info {
                display: none;
            }

            .main-content {
                padding: 16px;
            }

            .page-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>

<!-- ========================================== -->
<!-- HEADER -->
<!-- ========================================== -->
<header class="top-header">
    <a href="${pageContext.request.contextPath}/dashboard" class="brand">
        <div class="logo">
            <i class="fas fa-graduation-cap"></i>
        </div>
        <div class="brand-text">
            Gestion<span>Étudiants</span>
        </div>
    </a>

    <div class="header-right">
        <div class="user-info">
            <div class="name"><%= username %></div>
            <div class="role"><%= role %></div>
        </div>
        <div class="avatar">
            <%= username.substring(0, Math.min(2, username.length())).toUpperCase() %>
        </div>
    </div>
</header>

<!-- ========================================== -->
<!-- CONTENU PRINCIPAL -->
<!-- ========================================== -->
<main class="main-content">

    <!-- Breadcrumb -->
    <div class="breadcrumb-custom">
        <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
        <span>/</span>
        <span>Tableau de bord - Étudiant</span>
    </div>

    <!-- Page Title -->
    <h1 class="page-title">Tableau de bord - Étudiant</h1>

    <!-- Message de bienvenue -->
    <div class="alert-welcome">
        <h4><i class="fas fa-user-graduate"></i> Bienvenue <%= username %> !</h4>
        <p>Vous êtes connecté en tant que <strong><%= role %></strong>.</p>
    </div>

    <!-- Cards -->
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card-modern">
                <div class="icon-wrapper blue">
                    <i class="fas fa-id-card"></i>
                </div>
                <h5>Mes informations</h5>
                <p>Consulter vos informations personnelles</p>
                <a href="#" class="btn-card primary">
                    <i class="fas fa-arrow-right"></i> Accéder
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-modern">
                <div class="icon-wrapper green">
                    <i class="fas fa-file-alt"></i>
                </div>
                <h5>Mes notes</h5>
                <p>Consulter vos notes par matière</p>
                <a href="${pageContext.request.contextPath}/notes" class="btn-card success">
                    <i class="fas fa-arrow-right"></i> Accéder
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-modern">
                <div class="icon-wrapper orange">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <h5>Emploi du temps</h5>
                <p>Voir votre emploi du temps</p>
                <a href="#" class="btn-card warning">
                    <i class="fas fa-arrow-right"></i> Accéder
                </a>
            </div>
        </div>
    </div>

    <!-- Section paiements et inscriptions -->
    <div class="row g-4 mt-2">
        <div class="col-md-6">
            <div class="card-modern" style="text-align: left; padding: 24px;">
                <h5 style="margin-bottom: 16px;">
                    <i class="fas fa-coins" style="color: var(--primary);"></i> Mes paiements
                </h5>
                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
                    <span style="color: var(--text-secondary);">Total payé</span>
                    <span style="font-weight: 600; color: var(--success);">0 €</span>
                </div>
                <div style="display: flex; justify-content: space-between; padding: 10px 0;">
                    <span style="color: var(--text-secondary);">Reste à payer</span>
                    <span style="font-weight: 600; color: var(--danger);">0 €</span>
                </div>
                <a href="${pageContext.request.contextPath}/paiements" class="btn-card primary" style="display: inline-flex; margin-top: 12px;">
                    <i class="fas fa-arrow-right"></i> Voir mes paiements
                </a>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card-modern" style="text-align: left; padding: 24px;">
                <h5 style="margin-bottom: 16px;">
                    <i class="fas fa-graduation-cap" style="color: var(--primary);"></i> Mes inscriptions
                </h5>
                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
                    <span style="color: var(--text-secondary);">Filière</span>
                    <span style="font-weight: 500; color: var(--text-muted);">-</span>
                </div>
                <div style="display: flex; justify-content: space-between; padding: 10px 0;">
                    <span style="color: var(--text-secondary);">Niveau</span>
                    <span style="font-weight: 500; color: var(--text-muted);">-</span>
                </div>
                <a href="${pageContext.request.contextPath}/inscriptions" class="btn-card primary" style="display: inline-flex; margin-top: 12px;">
                    <i class="fas fa-arrow-right"></i> Voir mes inscriptions
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-custom">
        <p class="mb-0">
            <i class="fas fa-graduation-cap"></i> Gestion des Étudiants - Espace Étudiant
        </p>
        <small>&copy; 2024 - Projet scolaire</small>
    </footer>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>