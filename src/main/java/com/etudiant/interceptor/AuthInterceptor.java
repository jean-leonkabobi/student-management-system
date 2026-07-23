package com.etudiant.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String path = request.getRequestURI();
        String contextPath = request.getContextPath();

        // Pages publiques
        if (path.equals(contextPath + "/login") || path.equals(contextPath + "/logout")) {
            return true;
        }

        // Ressources statiques
        if (path.startsWith(contextPath + "/css/") ||
                path.startsWith(contextPath + "/js/") ||
                path.startsWith(contextPath + "/images/") ||
                path.startsWith(contextPath + "/uploads/") ||
                path.startsWith(contextPath + "/static/")) {
            return true;
        }

        // Vérifier l'authentification
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(contextPath + "/login");
            return false;
        }

        // Vérifier les restrictions de rôle
        String role = (String) session.getAttribute("role");

        // Scolarité ne peut pas accéder aux utilisateurs
        if ("SCOLARITE".equals(role) && path.startsWith(contextPath + "/utilisateurs")) {
            response.sendRedirect(contextPath + "/");
            return false;
        }

        return true;
    }
}