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

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <!-- Styles personnalisés -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                Gestion<span>Étudiants</span>
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

                <!-- Menu ADMIN uniquement -->
                <c:if test="${role == 'ADMIN' || role == 'SCOLARITE'}">
                    <li class="nav-label">Gestion</li>

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

                    <li class="nav-label">Administration</li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/utilisateurs"
                           class="nav-link ${pageActive == 'utilisateurs' ? 'active' : ''}">
                            <i class="fas fa-users-cog"></i>
                            Utilisateurs
                        </a>
                    </li>
                </c:if>

                <!-- Menu ENSEIGNANT -->
                <c:if test="${role == 'ENSEIGNANT'}">
                    <li class="nav-label">Enseignant</li>

                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-book-open"></i>
                            Mes cours
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/notes/saisie" class="nav-link">
                            <i class="fas fa-pen-fancy"></i>
                            Saisir notes
                        </a>
                    </li>
                </c:if>

                <!-- Menu ETUDIANT -->
                <c:if test="${role == 'ETUDIANT'}">
                    <li class="nav-label">Étudiant</li>

                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-id-card"></i>
                            Mon profil
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/notes" class="nav-link">
                            <i class="fas fa-file-alt"></i>
                            Mes notes
                        </a>
                    </li>
                </c:if>

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

        <!-- HEADER -->
        <header class="top-header">
            <div class="header-left">
                <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="page-title">
                    <h1>${pageTitle}</h1>
                    <div class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
                        <span> / </span>
                        <span>${pageTitle}</span>
                    </div>
                </div>
            </div>

            <div class="header-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Rechercher...">
                </div>

                <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme">
                    <i class="fas fa-moon"></i>
                </button>

                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="dot"></span>
                </div>

                <div class="avatar" title="Utilisateur: ${username}">
                    <span>${username != null ? username.substring(0, 2).toUpperCase() : 'U'}</span>
                </div>
            </div>
        </header>

        <!-- CONTENU DE LA PAGE -->
        <div class="page-content">