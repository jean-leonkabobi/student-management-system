<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "SCOLARITE";
    if (username == null) username = "Scolarité";
%>
<!DOCTYPE html>
<html lang="fr" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Gestion des Étudiants'}</title>

    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #8B5CF6;
            --primary-dark: #7C3AED;
            --primary-light: #A78BFA;
            --success: #22C55E;
            --warning: #F59E0B;
            --danger: #EF4444;
            --background: #F1F5F9;
            --card-bg: #FFFFFF;
            --text-primary: #0F172A;
            --text-secondary: #475569;
            --text-muted: #94A3B8;
            --border: #E2E8F0;
            --shadow: 0 1px 3px rgba(0,0,0,0.06);
            --shadow-hover: 0 4px 20px rgba(0,0,0,0.08);
            --radius: 12px;
            --radius-sm: 8px;
            --transition: 150ms cubic-bezier(0.4, 0, 0.2, 1);
            --sidebar-width: 260px;
            --header-height: 70px;
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

        /* ========================================== */
        /* LAYOUT PRINCIPAL */
        /* ========================================== */
        .app-container {
            display: flex;
            min-height: 100vh;
        }

        /* ========================================== */
        /* SIDEBAR */
        /* ========================================== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: var(--sidebar-width);
            background: var(--card-bg);
            border-right: 1px solid var(--border);
            padding: 24px 16px;
            overflow-y: auto;
            transition: all var(--transition);
            z-index: 1000;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 12px 24px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 24px;
        }

        .sidebar-brand .logo {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 700;
        }

        .sidebar-brand .brand-text {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.5px;
        }

        .sidebar-brand .brand-text span {
            color: var(--primary);
        }

        /* Navigation */
        .sidebar-nav {
            list-style: none;
        }

        .sidebar-nav .nav-label {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            padding: 16px 12px 8px;
        }

        .sidebar-nav .nav-item {
            margin-bottom: 2px;
        }

        .sidebar-nav .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 10px 14px;
            border-radius: var(--radius-sm);
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all var(--transition);
            cursor: pointer;
        }

        .sidebar-nav .nav-link i {
            width: 20px;
            font-size: 18px;
            color: var(--text-muted);
            transition: color var(--transition);
        }

        .sidebar-nav .nav-link:hover {
            background: var(--background);
            color: var(--text-primary);
        }

        .sidebar-nav .nav-link:hover i {
            color: var(--primary);
        }

        .sidebar-nav .nav-link.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
        }

        .sidebar-nav .nav-link.active i {
            color: white;
        }

        .sidebar-nav .nav-link .badge {
            margin-left: auto;
            background: var(--danger);
            color: white;
            font-size: 11px;
            font-weight: 600;
            padding: 2px 8px;
            border-radius: 20px;
        }

        /* ========================================== */
        /* CONTENU PRINCIPAL */
        /* ========================================== */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 0;
            min-height: 100vh;
        }

        /* ========================================== */
        /* HEADER DU HAUT */
        /* ========================================== */
        .top-header {
            background: var(--card-bg);
            border-bottom: 1px solid var(--border);
            padding: 0 32px;
            height: var(--header-height);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.9);
        }

        .top-header .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .top-header .header-left .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: var(--text-primary);
            cursor: pointer;
            padding: 4px;
        }

        .top-header .header-left .page-title h1 {
            font-size: 20px;
            font-weight: 700;
            letter-spacing: -0.3px;
            margin: 0;
        }

        .top-header .header-left .page-title .breadcrumb {
            font-size: 13px;
            color: var(--text-muted);
        }

        .top-header .header-left .page-title .breadcrumb a {
            color: var(--primary);
            text-decoration: none;
        }

        .top-header .header-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .top-header .header-right .search-box {
            display: flex;
            align-items: center;
            background: var(--background);
            border-radius: var(--radius-sm);
            padding: 8px 14px;
            gap: 10px;
            border: 1px solid var(--border);
            transition: all var(--transition);
        }

        .top-header .header-right .search-box:focus-within {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
        }

        .top-header .header-right .search-box input {
            border: none;
            background: transparent;
            outline: none;
            color: var(--text-primary);
            font-size: 14px;
            width: 200px;
        }

        .top-header .header-right .search-box input::placeholder {
            color: var(--text-muted);
        }

        .top-header .header-right .search-box i {
            color: var(--text-muted);
        }

        .top-header .header-right .notifications {
            position: relative;
            cursor: pointer;
            padding: 8px;
            color: var(--text-secondary);
        }

        .top-header .header-right .notifications .dot {
            position: absolute;
            top: 4px;
            right: 4px;
            width: 8px;
            height: 8px;
            background: var(--danger);
            border-radius: 50%;
            border: 2px solid var(--card-bg);
        }

        .top-header .header-right .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            cursor: pointer;
            text-transform: uppercase;
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

        /* ========================================== */
        /* CONTENU DES PAGES */
        /* ========================================== */
        .page-content {
            padding: 32px;
        }

        /* ========================================== */
        /* OVERLAY (pour mobile) */
        /* ========================================== */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .sidebar-overlay.active {
            display: block;
        }

        /* ========================================== */
        /* RESPONSIVE */
        /* ========================================== */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .top-header .header-left .menu-toggle {
                display: block;
            }

            .top-header {
                padding: 0 16px;
            }

            .top-header .header-right .search-box input {
                width: 120px;
            }

            .top-header .header-right .search-box {
                padding: 6px 12px;
            }

            .top-header .header-right .user-info {
                display: none;
            }

            .page-content {
                padding: 16px;
            }
        }

        @media (max-width: 480px) {
            .top-header .header-right .search-box {
                display: none;
            }
        }

        /* ========================================== */
        /* UTILITIES */
        /* ========================================== */
        .text-muted { color: var(--text-muted); }
        .text-primary { color: var(--primary); }
        .text-success { color: var(--success); }
        .text-danger { color: var(--danger); }
        .text-warning { color: var(--warning); }
    </style>
</head>
<body>

<div class="app-container">

    <!-- Overlay pour mobile -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- ========================================== -->
    <!-- SIDEBAR -->
    <!-- ========================================== -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <div class="logo">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <div class="brand-text">
                Gestion<span>Scolarité</span>
            </div>
        </div>

        <nav>
            <ul class="sidebar-nav">
                <li class="nav-label">Menu Principal</li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard"
                       class="nav-link ${pageActive == 'dashboard' ? 'active' : ''}">
                        <i class="fas fa-th-large"></i>
                        Tableau de bord
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/etudiants"
                       class="nav-link ${pageActive == 'etudiants' ? 'active' : ''}">
                        <i class="fas fa-user-graduate"></i>
                        Étudiants
                        <span class="badge">${totalEtudiants != null ? totalEtudiants : '0'}</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/enseignants"
                       class="nav-link ${pageActive == 'enseignants' ? 'active' : ''}">
                        <i class="fas fa-chalkboard-teacher"></i>
                        Enseignants
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/inscriptions"
                       class="nav-link ${pageActive == 'inscriptions' ? 'active' : ''}">
                        <i class="fas fa-graduation-cap"></i>
                        Inscriptions
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/matieres"
                       class="nav-link ${pageActive == 'matieres' ? 'active' : ''}">
                        <i class="fas fa-book-open"></i>
                        Matières
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/notes"
                       class="nav-link ${pageActive == 'notes' ? 'active' : ''}">
                        <i class="fas fa-pen-fancy"></i>
                        Notes
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/paiements"
                       class="nav-link ${pageActive == 'paiements' ? 'active' : ''}">
                        <i class="fas fa-coins"></i>
                        Paiements
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/emploi"
                       class="nav-link ${pageActive == 'emploi' ? 'active' : ''}">
                        <i class="fas fa-calendar-alt"></i>
                        Emplois du temps
                    </a>
                </li>

                <li class="nav-label">Mon Compte</li>

                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-user"></i>
                        Mon profil
                    </a>
                </li>

                <li class="nav-label">Système</li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout"
                       class="nav-link text-danger">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- ========================================== -->
    <!-- CONTENU PRINCIPAL -->
    <!-- ========================================== -->
    <main class="main-content">

        <!-- HEADER DU HAUT -->
        <header class="top-header">
            <div class="header-left">
                <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="page-title">
                    <h1>${pageTitle != null ? pageTitle : 'Tableau de bord'}</h1>
                    <div class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
                        <span> / </span>
                        <span>${pageTitle != null ? pageTitle : 'Tableau de bord'}</span>
                    </div>
                </div>
            </div>

            <div class="header-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Rechercher...">
                </div>

                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="dot"></span>
                </div>

                <div class="user-info">
                    <div class="name"><%= username %></div>
                    <div class="role"><%= role %></div>
                </div>

                <div class="avatar">
                    <%= username.substring(0, Math.min(2, username.length())).toUpperCase() %>
                </div>
            </div>
        </header>

        <!-- CONTENU DE LA PAGE -->
        <div class="page-content">