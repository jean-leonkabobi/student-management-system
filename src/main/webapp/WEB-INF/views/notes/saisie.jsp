<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ENSEIGNANT";
    boolean isEnseignant = "ENSEIGNANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/header-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : SAISIE D'UNE NOTE -->
<!-- ========================================== -->

<div class="card" style="max-width: 900px; margin: 0 auto;">
    <div class="card-header" style="background: var(--card-bg); border-bottom: 1px solid var(--border); padding: 16px 24px;">
        <h4 style="margin-bottom: 0; font-weight: 600; font-size: 18px;">
            <i class="fas fa-pen" style="color: #F59E0B;"></i> Saisie d'une note
        </h4>
    </div>
    <div class="card-body" style="padding: 32px;">
        <form:form action="${pageContext.request.contextPath}/notes/saisie"
                   method="post" modelAttribute="note">

            <!-- Champ caché pour l'ID si modification -->
            <form:hidden path="id"/>

            <div class="row">
                <!-- Inscription -->
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Inscription <span style="color: #EF4444;">*</span>
                    </label>
                    <form:select path="inscription.id" class="form-select" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);">
                        <form:option value="">Sélectionner une inscription</form:option>
                        <c:forEach items="${inscriptions}" var="i">
                            <form:option value="${i.id}">
                                ${i.etudiant.matricule} - ${i.etudiant.prenom} ${i.etudiant.nom}
                            </form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="inscription" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <!-- Matière -->
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Matière <span style="color: #EF4444;">*</span>
                    </label>
                    <form:select path="matiere.id" class="form-select" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);">
                        <form:option value="">Sélectionner une matière</form:option>
                        <c:forEach items="${matieres}" var="m">
                            <form:option value="${m.id}">${m.code} - ${m.nom}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="matiere" cssClass="text-danger" style="font-size: 13px;"/>
                </div>

                <!-- Contrôle continu -->
                <div class="col-md-4 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Contrôle continu (/20)
                    </label>
                    <form:input path="controleContinu" type="number" step="0.01" class="form-control"
                                placeholder="12.50" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                </div>

                <!-- TP -->
                <div class="col-md-4 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        TP (/20)
                    </label>
                    <form:input path="tp" type="number" step="0.01" class="form-control"
                                placeholder="14.00" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                </div>

                <!-- Examen -->
                <div class="col-md-4 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Examen (/20)
                    </label>
                    <form:input path="examen" type="number" step="0.01" class="form-control"
                                placeholder="15.50" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                </div>

                <!-- Session -->
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Session
                    </label>
                    <form:select path="session" class="form-select" style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);">
                        <c:forEach items="${sessions}" var="s">
                            <form:option value="${s}">${s}</form:option>
                        </c:forEach>
                    </form:select>
                </div>

                <!-- Date de saisie -->
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold" style="font-size: 14px; color: var(--text-secondary);">
                        Date de saisie
                    </label>
                    <form:input path="dateSaisie" type="date" class="form-control"
                                style="border-radius: 8px; padding: 10px 14px; border: 1px solid var(--border);"/>
                </div>
            </div>

            <!-- Actions -->
            <div style="display: flex; gap: 12px; margin-top: 16px; padding-top: 20px; border-top: 1px solid var(--border);">
                <a href="${pageContext.request.contextPath}/notes" class="btn btn-secondary"
                   style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 24px; border-radius: 8px; background: var(--background); color: var(--text-secondary); text-decoration: none; font-weight: 500; border: 1px solid var(--border); transition: all 0.15s;">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
                <button type="submit" class="btn btn-primary"
                        style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 24px; border-radius: 8px; background: #2563EB; color: white; border: none; font-weight: 500; cursor: pointer; transition: all 0.15s;">
                    <i class="fas fa-save"></i> Enregistrer
                </button>
            </div>
        </form:form>
    </div>
</div>

<c:choose>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/footer-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>