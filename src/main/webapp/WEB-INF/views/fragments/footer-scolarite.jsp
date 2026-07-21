<%@ page contentType="text/html;charset=UTF-8" language="java" %>

</div> <!-- Fin page-content -->

<!-- Footer -->
<footer style="text-align: center; color: #94A3B8; font-size: 13px; padding: 20px 32px; border-top: 1px solid #E2E8F0; margin-top: 20px;">
    <p style="margin-bottom: 4px;">
        <i class="fas fa-graduation-cap" style="color: #8B5CF6;"></i>
        Gestion des Étudiants - Espace Scolarité
    </p>
    <p style="margin-bottom: 0; font-size: 12px;">
        &copy; 2026 - Projet scolaire - Tous droits réservés
    </p>
</footer>

</main>
</div>

<!-- ========================================== -->
<!-- JAVASCRIPT -->
<!-- ========================================== -->
<script>
    // Toggle du menu sur mobile
    document.getElementById('menuToggle').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('sidebarOverlay');
        sidebar.classList.toggle('open');
        overlay.classList.toggle('active');
    });

    // Fermer le menu en cliquant sur l'overlay
    document.getElementById('sidebarOverlay').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('sidebarOverlay');
        sidebar.classList.remove('open');
        overlay.classList.remove('active');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>