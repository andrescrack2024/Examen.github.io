<?php
session_start();

// Función para conectar a la base de datos
function conectarBD() {
    $conexion = new mysqli("localhost", "root", "", "db_hospital");
    if ($conexion->connect_error) {
        die("Conexión fallida: " . $conexion->connect_error);
    }
    return $conexion;
}

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validación básica de los datos del formulario
    if (empty($_POST['correo']) || empty($_POST['contrasena'])) {
        $error = "Por favor, complete todos los campos.";
    } else {
        $correo = filter_var($_POST['correo'], FILTER_SANITIZE_EMAIL);
        $contrasena = $_POST['contrasena'];

        // Validación del correo
        if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
            $error = "Correo electrónico no válido.";
        } else {
            // Conectar a la base de datos
            $conexion = conectarBD();

            // Usar una consulta preparada para prevenir inyecciones SQL
            $stmt = $conexion->prepare("SELECT ID_Usuario, Contraseña, Rol, intentos_fallidos, ultima_attempt FROM usuarios WHERE Email = ?");
            $stmt->bind_param("s", $correo);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows > 0) {
                $stmt->bind_result($id, $hash_contrasena, $rol, $intentos, $ultima_attempt);
                $stmt->fetch();

                $ahora = new DateTime();
                $ultimo_intento = new DateTime($ultima_attempt ?? '2000-01-01');
                $diferencia = $ahora->getTimestamp() - $ultimo_intento->getTimestamp();

                if ($intentos >= 3 && $diferencia < 120) {
                    $error = "Cuenta bloqueada. Intenta de nuevo en " . (120 - $diferencia) . " segundos.";
                } else {
                    if (password_verify($contrasena, $hash_contrasena)) {
                        // Reiniciar intentos fallidos y última tentativa
                        $reset = $conexion->prepare("UPDATE usuarios SET intentos_fallidos = 0, ultima_attempt = NULL WHERE ID_Usuario = ?");
                        $reset->bind_param("i", $id);
                        $reset->execute();

                        // Establecer variables de sesión
                        $_SESSION['usuario_id'] = $id;
                        $_SESSION['correo'] = $correo;
                        $_SESSION['rol'] = $rol;

                        // Redirigir según el rol
                        header("Location: dashboard_$rol.php");
                        exit();
                    } else {
                        // Actualizar intentos fallidos
                        $nuevo_intento = ($diferencia >= 120) ? 1 : $intentos + 1;
                        $ahora_str = $ahora->format('Y-m-d H:i:s');

                        $update = $conexion->prepare("UPDATE usuarios SET intentos_fallidos = ?, ultima_attempt = ? WHERE ID_Usuario = ?");
                        $update->bind_param("isi", $nuevo_intento, $ahora_str, $id);
                        $update->execute();

                        $error = ($nuevo_intento >= 3)
                            ? "Cuenta bloqueada por 2 minutos debido a intentos fallidos."
                            : "Contraseña incorrecta. Intento $nuevo_intento de 3.";
                    }
                }
            } else {
                $error = "Correo no registrado.";
            }

            $stmt->close();
            $conexion->close();
        }
    }
}
?>

<!-- HTML del login -->
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg">
                <div class="card-body">
                    <h3 class="text-center mb-4">Iniciar Sesión</h3>
                    <?php if (!empty($error)): ?>
                        <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
                    <?php endif; ?>
                    <form method="POST">
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo</label>
                            <input type="email" class="form-control" name="correo" required>
                        </div>
                        <div class="mb-3">
                            <label for="contrasena" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" name="contrasena" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Entrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
