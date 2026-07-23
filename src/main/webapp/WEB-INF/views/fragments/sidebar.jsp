<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="col-md-3 col-lg-2 d-md-block sidebar">
    <div class="pt-2">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/">
                    <i class="bi bi-speedometer2"></i> Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/etudiants">
                    <i class="bi bi-people-fill"></i> Étudiants
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/enseignants">
                    <i class="bi bi-person-workspace"></i> Enseignants
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/filieres">
                    <i class="bi bi-diagram-3-fill"></i> Filières
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/classes">
                    <i class="bi bi-easel-fill"></i> Classes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/matieres">
                    <i class="bi bi-book-fill"></i> Matières
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/notes">
                    <i class="bi bi-journal-check"></i> Notes
                </a>
            </li>
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/utilisateurs">
                        <i class="bi bi-shield-lock-fill"></i> Utilisateurs
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
</nav>