<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../fragments/header.jsp"/>

<div class="card" style="max-width: 900px; margin: 0 auto;">
    <div class="card-header" style="background: var(--card-bg); border-bottom: 1px solid var(--border); padding: 16px 24px;">
        <h4 style="margin-bottom: 0; font-weight: 600; font-size: 18px;">
            <i class="fas fa-user-plus" style="color: #2563EB;"></i> Nouvel utilisateur
        </h4>
        <p style="margin-bottom: 0; color: var(--text-muted); font-size: 14px; margin-top: 4px;">
            Créer un compte pour un enseignant, un personnel ou un étudiant.
        </p>
    </div>
    <div class="card-body" style="padding: 32px;">
        <form:form action="${pageContext.request.contextPath}/utilisateurs/ajouter"
                   method="post" modelAttribute="utilisateur">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Nom d'utilisateur <span style="color: #EF4444;">*</span>
                    </label>
                    <form:input path="username" class="form-control" placeholder="jean.dupont" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                    <form:errors path="username" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Email <span style="color: #EF4444;">*</span>
                    </label>
                    <form:input path="email" type="email" class="form-control" placeholder="jean@email.com" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                    <form:errors path="email" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Mot de passe <span style="color: #EF4444;">*</span>
                    </label>
                    <form:input path="passwordHash" type="password" class="form-control" placeholder="********" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                    <form:errors path="passwordHash" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Confirmer le mot de passe <span style="color: #EF4444;">*</span>
                    </label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="********" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Rôle <span style="color: #EF4444;">*</span>
                    </label>
                    <form:select path="role" class="form-select" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);">
                        <form:option value="">Sélectionner un rôle</form:option>
                        <form:option value="ADMIN">Administrateur</form:option>
                        <form:option value="SCOLARITE">Scolarité</form:option>
                        <form:option value="ENSEIGNANT">Enseignant</form:option>
                        <form:option value="COMPTABLE">Comptable</form:option>
                        <form:option value="BIBLIOTHECAIRE">Bibliothécaire</form:option>
                        <form:option value="ETUDIANT">Étudiant</form:option>
                    </form:select>
                    <form:errors path="role" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Statut
                    </label>
                    <form:select path="estActif" class="form-select" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);">
                        <form:option value="true">Actif</form:option>
                        <form:option value="false">Inactif</form:option>
                    </form:select>
                </div>
            </div>

            <!-- Message d'information sur la création des profils -->
            <div style="background: #EFF6FF; border-radius: 8px; padding: 12px 16px; margin: 16px 0; color: #2563EB; font-size: 14px; border-left: 4px solid #2563EB;">
                <i class="fas fa-info-circle" style="margin-right: 8px;"></i>
                <strong>Information :</strong>
                <ul style="margin: 4px 0 0 20px; color: var(--text-secondary); font-size: 13px;">
                    <li>Un profil <strong>étudiant</strong> sera automatiquement créé pour le rôle ETUDIANT.</li>
                    <li>Un profil <strong>enseignant</strong> sera automatiquement créé pour le rôle ENSEIGNANT.</li>
                    <li>Les autres rôles (ADMIN, SCOLARITE, COMPTABLE, BIBLIOTHECAIRE) n'ont pas de profil spécifique.</li>
                </ul>
            </div>

            <div style="display: flex; gap: 12px; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border);">
                <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-secondary" style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 24px; border-radius: 8px; background: var(--background); color: var(--text-secondary); text-decoration: none; font-weight: 500; border: 1px solid var(--border); transition: all 0.15s;">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
                <button type="submit" class="btn btn-primary" style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 24px; border-radius: 8px; background: #2563EB; color: white; border: none; font-weight: 500; cursor: pointer; transition: all 0.15s;">
                    <i class="fas fa-save"></i> Enregistrer
                </button>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>