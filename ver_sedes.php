<?php
$conexion = new mysqli("localhost", "root", "", "db_hospital");
if ($conexion->connect_error) {
    die("Conexión fallida: " . $conexion->connect_error);
}

$resultado = $conexion->query("SELECT * FROM sedes");
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Listado de Sedes</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="mb-4 text-center">Sedes Registradas</h2>
  <div class="row g-4">
    <?php while ($fila = $resultado->fetch_assoc()): ?>
      <div class="col-md-4">
        <div class="card shadow rounded-4 h-100">
          <img src="<?php echo $fila['imagen']; ?>" class="card-img-top" style="height: 200px; object-fit: cover;" alt="Imagen de la sede">
          <div class="card-body">
            <h5 class="card-title"><?php echo htmlspecialchars($fila['nombre_sede']); ?></h5>
            <p class="card-text"><strong>Ubicación:</strong> <?php echo $fila['ubicacion']; ?></p>
            <p class="card-text"><strong>Capacidad:</strong> <?php echo $fila['capacidad_usuarios']; ?> personas</p>
          </div>
        </div>
      </div>
    <?php endwhile; ?>
  </div>
</div>

</body>
</html>

<?php
$conexion->close();
?>
