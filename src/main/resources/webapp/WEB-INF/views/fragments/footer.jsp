<%@ page contentType="text/html;charset=UTF-8" language="java" %>

</div> <!-- Fin page-content -->

<!-- Footer -->
<footer style="
            padding: 20px 32px;
            border-top: 1px solid var(--border);
            color: var(--text-muted);
            font-size: 13px;
            text-align: center;">
    <p>
        <i class="fas fa-graduation-cap"></i>
        Gestion des Étudiants - Spring MVC avec JSP &amp; JSTL
        <br>
        <span style="font-size: 12px;">
                    &copy; 2024 - Projet scolaire - Tous droits réservés
                </span>
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

    // Thème clair/sombre
    const themeToggle = document.getElementById('themeToggle');
    const html = document.documentElement;

    // Vérifier le thème sauvegardé
    const savedTheme = localStorage.getItem('theme') || 'light';
    html.setAttribute('data-theme', savedTheme);
    updateThemeIcon(savedTheme);

    themeToggle.addEventListener('click', function() {
        const currentTheme = html.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        html.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeIcon(newTheme);
    });

    function updateThemeIcon(theme) {
        const icon = themeToggle.querySelector('i');
        if (theme === 'dark') {
            icon.className = 'fas fa-sun';
        } else {
            icon.className = 'fas fa-moon';
        }
    }
</script>

<!-- Bootstrap JS (pour les composants interactifs) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>