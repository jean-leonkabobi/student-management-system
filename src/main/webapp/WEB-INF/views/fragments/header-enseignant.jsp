<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String username = (String) session.getAttribute("username");
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ENSEIGNANT";
    if (username == null) username = "Utilisateur";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Gestion des Étudiants'}</title>

    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #2563EB;
            --primary-dark: #1E40AF;
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
            --radius-sm: 8px;
            --shadow: 0 1px 3px rgba(0,0,0,0.06);
            --shadow-hover: 0 4px 20px rgba(0,0,0,0.08);
            --sidebar-width: 260px;
            --header-height: 70px;
            --transition: 150ms cubic-bezier(0.4, 0, 0.2, 1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background: var(--background);
            color: var(--text-primary);
            min-height: 100vh;
        }

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
            background: var(--success);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .sidebar-brand .brand-text {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
        }

        .sidebar-brand .brand-text span {
            color: var(--success);
        }

        .sidebar-nav {
            list-style: none;
            padding: 0;
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
        }

        .sidebar-nav .nav-link i {
            width: 20px;
            font-size: 16px;
            color: var(--text-muted);
            transition: color var(--transition);
        }

        .sidebar-nav .nav-link:hover {
            background: var(--background);
            color: var(--text-primary);
        }

        .sidebar-nav .nav-link:hover i {
            color: var(--success);
        }

        .sidebar-nav .nav-link.active {
            background: var(--success);
            color: white;
            box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
        }

        .sidebar-nav .nav-link.active i {
            color: white;
        }

        /* ========================================== */
        /* HEADER */
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
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
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

        .top-header .header-left .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--text-primary);
        }

        .top-header .header-left .brand .logo {
            width: 40px;
            height: 40px;
            background: var(--success);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .top-header .header-left .brand .brand-text {
            font-size: 18px;
            font-weight: 700;
        }

        .top-header .header-left .brand .brand-text span {
            color: var(--success);
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

        .top-header .header-right .logout-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.15s;
        }

        .top-header .header-right .logout-link:hover {
            color: var(--danger);
        }

        .top-header .header-right .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: var(--success);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            flex-shrink: 0;
        }

        /* ========================================== */
        /* MAIN CONTENT */
        /* ========================================== */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 0;
            min-height: 100vh;
        }

        .page-content {
            padding: 24px 32px 40px;
        }

        .breadcrumb-custom {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .breadcrumb-custom a {
            color: var(--success);
            text-decoration: none;
        }

        .breadcrumb-custom a:hover {
            text-decoration: underline;
        }

        .breadcrumb-custom span {
            margin: 0 8px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
            color: var(--text-primary);
        }

        /* ========================================== */
        /* OVERLAY & RESPONSIVE */
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

            .top-header .header-left .brand .brand-text {
                font-size: 16px;
            }

            .top-header {
                padding: 0 16px;
            }

            .top-header .header-right .user-info {
                display: none;
            }

            .page-content {
                padding: 16px;
            }

            .page-title {
                font-size: 20px;
            }
        }
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
                <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <div class="brand-text">
                Gestion<span>Enseignant</span>
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
                    <a href="${pageContext.request.contextPath}/cours"
                       class="nav-link ${pageActive == 'cours' ? 'active' : ''}">
                        <i class="fas fa-book-open"></i>
                        Mes cours
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/notes/saisie"
                       class="nav-link ${pageActive == 'notes' ? 'active' : ''}">
                        <i class="fas fa-pen-fancy"></i>
                        Saisir notes
                    </a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/emploi"
                       class="nav-link ${pageActive == 'emploi' ? 'active' : ''}">
                        <i class="fas fa-calendar-alt"></i>
                        Emploi du temps
                    </a>
                </li>

                <li class="nav-label">Mon Compte</li>

                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-user"></i>
                        Mon profil
                    </a>
                </li>

                <li style="padding: 8px 0; list-style: none;"></li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout"
                       class="nav-link" style="color: var(--danger); border-top: 1px solid var(--border); padding-top: 12px;">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- ========================================== -->
    <!-- MAIN CONTENT -->
    <!-- ========================================== -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="top-header">
            <div class="header-left">
                <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">
                    <i class="fas fa-bars"></i>
                </button>
                <a href="${pageContext.request.contextPath}/dashboard" class="brand">
                    <div class="logo">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <div class="brand-text">
                        Gestion<span>Enseignant</span>
                    </div>
                </a>
            </div>

            <div class="header-right">
                <div class="user-info">
                    <div class="name"><%= username %></div>
                    <div class="role"><%= role %></div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
                <div class="avatar">
                    <%= username.substring(0, Math.min(2, username.length())).toUpperCase() %>
                </div>
            </div>
        </header>

        <!-- CONTENU DE LA PAGE -->
        <div class="page-content">

            <!-- Breadcrumb -->
            <div class="breadcrumb-custom">
                <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
                <span>/</span>
                <span>${pageTitle}</span>
            </div>

            <!-- Page Title -->
            <h1 class="page-title">${pageTitle}</h1>