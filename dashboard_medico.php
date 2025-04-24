<?php
session_start();
if ($_SESSION['rol'] !== 'medico') {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Médico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-success">
    <div class="container-fluid">
        <span class="navbar-brand">Panel del Médico</span>
        <a href="logout.php" class="btn btn-outline-light">Cerrar sesión</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Opciones del Médico</h2>
    <ul class="list-group">
        <li class="list-group-item"><a href="#">Ver Pacientes</a></li>
        <li class="list-group-item"><a href="#">Registrar Diagnóstico</a></li>
        <li class="list-group-item"><a href="#">Ver Citas</a></li>
    </ul>
</div>
</body>
</html>
