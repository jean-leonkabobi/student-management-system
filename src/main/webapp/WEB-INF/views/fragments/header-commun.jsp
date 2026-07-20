<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
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
            --background: #F1F5F9;
            --card-bg: #FFFFFF;
            --text-primary: #0F172A;
            --text-secondary: #475569;
            --text-muted: #94A3B8;
            --border: #E2E8F0;
            --radius: 12px;
            --shadow: 0 1px 3px rgba(0,0,0,0.06);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background: var(--background);
            color: var(--text-primary);
            min-height: 100vh;
        }

        /* Header */
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

        .top-header .header-right .logout-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.15s;
        }

        .top-header .header-right .logout-link:hover {
            color: var(--primary);
        }

        /* Contenu */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px 32px 40px;
        }

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

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
        }

        /* Cards */
        .card {
            border-radius: var(--radius);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
        }

        .card-header {
            background: var(--card-bg);
            border-bottom: 1px solid var(--border);
        }

        /* Alertes */
        .alert {
            border-radius: var(--radius);
            border: none;
        }

        .alert-success {
            background: #F0FDF4;
            color: #16A34A;
        }

        .alert-danger {
            background: #FEF2F2;
            color: #DC2626;
        }

        .alert-info {
            background: #EFF6FF;
            color: #2563EB;
        }

        /* Footer */
        .footer-custom {
            text-align: center;
            color: var(--text-muted);
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .top-header { padding: 0 16px; }
            .top-header .brand .brand-text { font-size: 16px; }
            .top-header .header-right .user-info { display: none; }
            .main-content { padding: 16px; }
            .page-title { font-size: 20px; }
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
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i>
        </a>
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
        <span>${pageTitle}</span>
    </div>

    <!-- Page Title -->
    <h1 class="page-title">${pageTitle}</h1>