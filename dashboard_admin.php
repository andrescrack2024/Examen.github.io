<?php
session_start();
if ($_SESSION['rol'] !== 'admin') {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand">Bienvenido Admin</span>
        <a href="logout.php" class="btn btn-outline-light">Cerrar sesión</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Gestión del Sistema</h2>
    <ul class="list-group">
        <li class="list-group-item"><a href="#">Gestionar Usuarios</a></li>
        <li class="list-group-item"><a href="#">Ver Reportes</a></li>
        <li class="list-group-item"><a href="#">Configurar Sistema</a></li>
    </ul>
</div>
</body>
</html>
