<%@ page contentType="text/html;charset=UTF-8" language="java" %>

</div> <!-- Fin page-content -->

<!-- Footer -->
<footer style="text-align: center; color: var(--text-muted); margin-top: 40px; padding-top: 20px; border-top: 1px solid var(--border); font-size: 14px;">
    <p class="mb-0">
        <i class="fas fa-graduation-cap"></i> Gestion des Étudiants - Espace Scolarité
    </p>
    <small>&copy; 2024 - Projet scolaire</small>
</footer>
</main>
</div>

<!-- Scripts -->
<script>
    document.getElementById('menuToggle').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('sidebarOverlay');
        sidebar.classList.toggle('open');
        overlay.classList.toggle('active');
    });

    document.getElementById('sidebarOverlay').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('sidebarOverlay');
        sidebar.classList.remove('open');
        overlay.classList.remove('active');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>