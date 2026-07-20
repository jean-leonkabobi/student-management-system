<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Styles personnalisés -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        :root {
            --primary-color: #2563EB;
            --primary-dark: #1E40AF;
            --primary-light: #3B82F6;
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
            --transition: 150ms cubic-bezier(0.4, 0, 0.2, 1);
            --header-height: 70px;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--background);
            color: var(--text-primary);
            min-height: 100vh;
        }

        /* Header */
        .top-header {
            height: var(--header-height);
            background: var(--card-bg);
            border-bottom: 1px solid var(--border);
            padding: 0 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.9);
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
            background: var(--primary-color);
            border-radius: var(--radius-sm);
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
            color: var(--primary-color);
        }

        .top-header .header-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .top-header .header-right .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
        }

        .top-header .header-right .user-info {
            text-align: right;
        }

        .top-header .header-right .user-info .name {
            font-weight: 600;
            font-size: 14px;
        }

        .top-header .header-right .user-info .role {
            font-size: 12px;
            color: var(--text-muted);
        }

        /* Menu utilisateur */
        .user-menu {
            position: relative;
        }

        .user-menu .dropdown-menu {
            position: absolute;
            top: 50px;
            right: 0;
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 8px 0;
            min-width: 200px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.12);
            display: none;
        }

        .user-menu .dropdown-menu.show {
            display: block;
        }

        .user-menu .dropdown-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 16px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            transition: background var(--transition);
        }

        .user-menu .dropdown-menu a:hover {
            background: var(--background);
            color: var(--text-primary);
        }

        .user-menu .dropdown-menu .divider {
            height: 1px;
            background: var(--border);
            margin: 4px 0;
        }

        .user-menu .dropdown-menu .text-danger {
            color: #EF4444 !important;
        }

        .user-menu .dropdown-menu .text-danger:hover {
            background: #FEF2F2;
        }

        /* Layout principal */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px 32px 40px;
        }

        /* Page content */
        .page-content {
            background: transparent;
            padding: 0;
        }

        /* Breadcrumb */
        .breadcrumb-custom {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .breadcrumb-custom a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb-custom span {
            margin: 0 8px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
        }

        /* Cards */
        .card-modern {
            background: var(--card-bg);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            padding: 24px;
            transition: all var(--transition);
        }

        .card-modern:hover {
            box-shadow: var(--shadow-hover);
        }

        /* Responsive */
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
            <div class="name">${username}</div>
            <div class="role">${role}</div>
        </div>

        <div class="user-menu" id="userMenu">
            <div class="avatar" onclick="toggleDropdown()">
                ${username != null ? username.substring(0, 2).toUpperCase() : 'U'}
            </div>
            <div class="dropdown-menu" id="dropdownMenu">
                <a href="${pageContext.request.contextPath}/dashboard">
                    <i class="fas fa-th-large"></i> Tableau de bord
                </a>
                <a href="#">
                    <i class="fas fa-user"></i> Mon profil
                </a>
                <div class="divider"></div>
                <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                </a>
            </div>
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
        <span>${pageTitle}</span>
    </div>

    <!-- Page Title -->
    <h1 class="page-title">${pageTitle}</h1>

    <!-- CONTENU DE LA PAGE -->
    <div class="page-content">