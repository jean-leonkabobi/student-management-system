<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Gestion Étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', sans-serif;
        }
        .register-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 480px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .register-card .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-card .logo i {
            font-size: 48px;
            color: #667eea;
        }
        .register-card .logo h3 {
            font-weight: 700;
            color: #1a1a2e;
            margin-top: 10px;
        }
        .register-card .logo span {
            color: #667eea;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        .input-group-text {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px 0 0 10px;
        }
        .form-control {
            border-radius: 0 10px 10px 0;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
    </style>
</head>
<body>

<div class="register-card">
    <div class="logo">
        <i class="fas fa-graduation-cap"></i>
        <h3>Gestion <span>Étudiants</span></h3>
        <p class="text-muted">Créer un compte</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="mb-3">
            <label class="form-label fw-semibold">Nom d'utilisateur *</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" name="username" class="form-control" placeholder="Entrez un nom d'utilisateur" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Email *</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="Entrez votre email" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Mot de passe *</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" name="passwordHash" class="form-control" placeholder="Entrez un mot de passe" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Confirmer le mot de passe *</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Confirmez le mot de passe" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Rôle</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-users-cog"></i></span>
                <select name="role" class="form-control">
                    <option value="ETUDIANT">Étudiant</option>
                    <option value="ENSEIGNANT">Enseignant</option>
                    <option value="SCOLARITE">Scolarité</option>
                </select>
            </div>
        </div>

        <button type="submit" class="btn-register">
            <i class="fas fa-user-plus"></i> S'inscrire
        </button>
    </form>

    <div class="text-center mt-3">
        <small class="text-muted">
            Déjà un compte ? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Se connecter</a>
        </small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>