<%@ page contentType="text/html;charset=UTF-8" language="java" %>

</div> <!-- Fin page-content -->

<!-- Footer -->
<footer class="text-center text-muted mt-5 pt-3 border-top">
    <p class="mb-1">
        <i class="fas fa-graduation-cap"></i> Gestion des Étudiants - Espace Étudiant
    </p>
    <small>&copy; 2024 - Projet scolaire</small>
</footer>
</main>

<script>
    // Toggle du dropdown
    function toggleDropdown() {
        const menu = document.getElementById('dropdownMenu');
        menu.classList.toggle('show');
    }

    // Fermer le dropdown en cliquant ailleurs
    document.addEventListener('click', function(event) {
        const userMenu = document.getElementById('userMenu');
        if (!userMenu.contains(event.target)) {
            document.getElementById('dropdownMenu').classList.remove('show');
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>