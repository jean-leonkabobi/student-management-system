<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Gestion Universitaire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body { background: linear-gradient(135deg, #1a2744 0%, #2c3e50 100%); min-height: 100vh; display: flex; align-items: center; }
        .login-card { background: #fff; border-radius: 8px; box-shadow: 0 10px 40px rgba(0,0,0,0.3); padding: 40px; width: 420px; max-width: 90%; margin: 0 auto; }
        .login-card .icon { font-size: 3rem; color: #c9a84c; text-align: center; margin-bottom: 10px; }
        .login-card h3 { text-align: center; color: #1a2744; font-weight: 700; margin-bottom: 25px; }
        .login-card .btn-primary { background: #1a2744; border: none; padding: 10px; font-weight: 600; }
        .login-card .btn-primary:hover { background: #243356; }
        .login-card .form-control { padding: 10px 14px; }
    </style>
</head>
<body>
<div class="login-card">
    <div class="icon"><i class="bi bi-mortarboard-fill"></i></div>
    <h3>Gestion Universitaire</h3>
    <c:if test="${param.error != null}"><div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> Identifiants incorrects</div></c:if>
    <c:if test="${param.logout != null}"><div class="alert alert-success"><i class="bi bi-check-circle"></i> Déconnexion réussie</div></c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="mb-3">
            <label class="form-label">Nom d'utilisateur</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="username" class="form-control" required>
            </div>
        </div>
        <div class="mb-4">
            <label class="form-label">Mot de passe</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="password" class="form-control" required>
            </div>
        </div>
        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-box-arrow-in-right"></i> Se connecter</button>
    </form>
</div>
</body>
</html>