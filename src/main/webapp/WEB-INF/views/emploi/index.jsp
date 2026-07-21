<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Object roleObj = session.getAttribute("role");
    String role = roleObj != null ? roleObj.toString() : "ETUDIANT";
    boolean isEtudiant = "ETUDIANT".equals(role);
    boolean isEnseignant = "ENSEIGNANT".equals(role);
%>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/header-commun.jsp"/>
    </c:when>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/header-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/header.jsp"/>
    </c:otherwise>
</c:choose>

<!-- ========================================== -->
<!-- PAGE : EMPLOI DU TEMPS -->
<!-- ========================================== -->

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2 style="font-size: 20px; font-weight: 700;">
        <i class="fas fa-calendar-alt" style="color: #F59E0B;"></i>
        <c:choose>
            <c:when test="<%= isEnseignant %>">Mon Emploi du Temps (Enseignant)</c:when>
            <c:when test="<%= isEtudiant %>">Mon Emploi du Temps (Étudiant)</c:when>
            <c:otherwise>Emploi du Temps</c:otherwise>
        </c:choose>
    </h2>
</div>

<c:choose>
    <c:when test="${hasEmploi}">
        <!-- Tableau de l'emploi du temps -->
        <div class="card">
            <div class="card-header">
                <h5>Semaine du <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/></h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th style="width: 120px;">Horaire</th>
                            <th>Lundi</th>
                            <th>Mardi</th>
                            <th>Mercredi</th>
                            <th>Jeudi</th>
                            <th>Vendredi</th>
                            <c:if test="<%= isEnseignant %>">
                                <th>Samedi</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="horaires" value="08:00-10:00,10:00-12:00,12:00-14:00,14:00-16:00,16:00-18:00" />
                        <c:forEach var="horaire" items="${horaires.split(',')}">
                            <tr>
                                <td><strong>${horaire}</strong></td>
                                <c:set var="jours" value="LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI" />
                                <c:if test="<%= isEnseignant %>">
                                    <c:set var="jours" value="LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI" />
                                </c:if>
                                <c:forEach var="jour" items="${jours.split(',')}">
                                    <td>
                                        <c:set var="coursTrouve" value="false" />
                                        <c:forEach items="${emploiParJour[jour]}" var="emploi">
                                            <c:if test="${emploi.heureDebut.toString().substring(0,5) == horaire.substring(0,5)}">
                                                <c:set var="coursTrouve" value="true" />
                                                <div style="background: #EFF6FF; border-radius: 6px; padding: 6px 10px; margin: 2px 0;">
                                                    <strong>${emploi.matiere.nom}</strong>
                                                    <br>
                                                    <small style="color: var(--text-muted);">
                                                            ${emploi.heureDebut} - ${emploi.heureFin}
                                                        <c:if test="${not empty emploi.salle}">
                                                            <br><i class="fas fa-door-open"></i> ${emploi.salle}
                                                        </c:if>
                                                    </small>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${coursTrouve == false}">
                                            <span style="color: var(--text-muted); font-size: 13px;">-</span>
                                        </c:if>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Message si pas d'emploi du temps -->
        <div class="alert alert-info" style="border-radius: var(--radius); border: none; background: #EFF6FF; color: #2563EB; padding: 24px;">
            <i class="fas fa-info-circle" style="font-size: 20px;"></i>
            <c:choose>
                <c:when test="<%= isEnseignant %>">
                    Aucun cours n'a été programmé pour vous.
                    <br>Contactez l'administration pour mettre à jour votre emploi du temps.
                </c:when>
                <c:when test="<%= isEtudiant %>">
                    Votre emploi du temps sera disponible prochainement.
                    <br>Consultez votre scolarité pour plus d'informations.
                </c:when>
                <c:otherwise>
                    La gestion complète de l'emploi du temps sera disponible dans une prochaine version.
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Exemple de structure d'emploi du temps (à compléter plus tard) -->
        <div class="card">
            <div class="card-header">
                <h5>Semaine du <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/></h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Horaire</th>
                            <th>Lundi</th>
                            <th>Mardi</th>
                            <th>Mercredi</th>
                            <th>Jeudi</th>
                            <th>Vendredi</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>08:00 - 10:00</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                        </tr>
                        <tr>
                            <td>10:00 - 12:00</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                        </tr>
                        <tr>
                            <td>12:00 - 14:00</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                        </tr>
                        <tr>
                            <td>14:00 - 16:00</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                        </tr>
                        <tr>
                            <td>16:00 - 18:00</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                            <td class="text-muted text-center">-</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="text-muted text-center mt-3">
                    <small><i class="fas fa-clock"></i> Aucun cours programmé pour cette semaine</small>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="<%= isEtudiant %>">
        <jsp:include page="../fragments/footer-commun.jsp"/>
    </c:when>
    <c:when test="<%= isEnseignant %>">
        <jsp:include page="../fragments/footer-enseignant.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../fragments/footer.jsp"/>
    </c:otherwise>
</c:choose>