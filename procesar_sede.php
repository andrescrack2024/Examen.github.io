<?php
$conexion = new mysqli("localhost", "root", "", "db_hospital");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$nombre = $_POST['nombre'];
$ubicacion = $_POST['ubicacion'];
$capacidad = $_POST['capacidad'];

// Subida de la imagen
$directorio = "imagenes/";
$nombreImagen = basename($_FILES["imagen"]["name"]);
$rutaImagen = $directorio . uniqid() . "_" . $nombreImagen;

if (move_uploaded_file($_FILES["imagen"]["tmp_name"], $rutaImagen)) {
    // Insertar en la base de datos
    $stmt = $conexion->prepare("INSERT INTO sedes (nombre_sede, ubicacion, imagen, capacidad_usuarios) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("sssi", $nombre, $ubicacion, $rutaImagen, $capacidad);

    if ($stmt->execute()) {
        echo "<script>alert('Sede registrada exitosamente'); window.location.href='agregar_sede.php';</script>";
    } else {
        echo "Error al registrar sede: " . $conexion->error;
    }

    $stmt->close();
} else {
    echo "Error al subir la imagen.";
}

$conexion->close();
?>
