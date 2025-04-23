-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-04-2025 a las 22:50:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_hospital`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `reset_intentos` (IN `user_id` INT)   BEGIN
    UPDATE usuarios SET intentos_fallidos = 0, ultima_attempt = NULL WHERE ID_Usuario = user_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `ID_Cita` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `Fecha_Cita` date DEFAULT NULL,
  `Hora_Cita` time DEFAULT NULL,
  `Motivo_Cita` text DEFAULT NULL,
  `Estado_Cita` enum('Pendiente','Confirmada','Cancelada') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `ID_Factura` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `ID_Cita` int(11) DEFAULT NULL,
  `Fecha_Factura` date DEFAULT NULL,
  `pago_Total` decimal(10,2) DEFAULT NULL,
  `Descripción` text DEFAULT NULL,
  `Metodo_Pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formulas_medicas`
--

CREATE TABLE `formulas_medicas` (
  `ID_Formula` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `ID_Medicamento` int(11) DEFAULT NULL,
  `Fecha_Formula` date DEFAULT NULL,
  `Indicaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `ID_Habitacion` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `Numero_Habitacion` varchar(10) DEFAULT NULL,
  `Tipo_Habitacion` enum('Individual','Doble','Suite') DEFAULT NULL,
  `Estado_Habitacion` enum('Disponible','Ocupada','Mantenimiento') DEFAULT NULL,
  `Costo_Habitacion` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_clinico`
--

CREATE TABLE `historial_clinico` (
  `ID_Historial` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `Fecha_Historial` date DEFAULT NULL,
  `Descripción_Historial` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_medicos`
--

CREATE TABLE `horarios_medicos` (
  `ID_Horario` int(11) NOT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `Día` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') DEFAULT NULL,
  `Hora_Inicio` time DEFAULT NULL,
  `Hora_Fin` time DEFAULT NULL,
  `Disponibilidad` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `ID_Medicamento` int(11) NOT NULL,
  `Nombre_Medicamento` varchar(100) DEFAULT NULL,
  `Descripción_Medicamento` text DEFAULT NULL,
  `Dosis` varchar(50) DEFAULT NULL,
  `Frecuencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `ID_Medico` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Numero_Licencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `ID_Paciente` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `barrio` varchar(100) DEFAULT NULL,
  `Ciudad` varchar(50) DEFAULT NULL,
  `Teléfono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `tipo_sangre` varchar(5) DEFAULT NULL,
  `eps` varchar(100) DEFAULT NULL,
  `Genero` enum('Masculino','Femenino','Otro') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `ID_Sede` int(11) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Ubicacion` varchar(255) DEFAULT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `Capacidad_Usuarios` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`ID_Sede`, `Nombre`, `Ubicacion`, `Imagen`, `Capacidad_Usuarios`) VALUES
(1, 'Sede Central', 'Centro de la ciudad', NULL, 100),
(2, 'Sede Norte', 'Zona norte', NULL, 150),
(3, 'Sede Sur', 'Zona sur', NULL, 120),
(4, 'Sede Oeste', 'Zona oeste', NULL, 200),
(5, 'Sede Este', 'Zona este', NULL, 250);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `ID_Tratamiento` int(11) NOT NULL,
  `ID_Historial` int(11) DEFAULT NULL,
  `Nombre_Tratamiento` varchar(100) DEFAULT NULL,
  `Descripción_Tratamiento` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre_Usuario` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Contraseña` varchar(255) DEFAULT NULL,
  `Rol` enum('Admin','Usuario') DEFAULT 'Usuario',
  `Sede_ID` int(11) DEFAULT NULL,
  `intentos_fallidos` int(11) DEFAULT 0,
  `ultima_attempt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_Usuario`, `Nombre_Usuario`, `Email`, `Contraseña`, `Rol`, `Sede_ID`, `intentos_fallidos`, `ultima_attempt`) VALUES
(1, 'Juan Pérez', 'juan.perez@ejemplo.com', '$2y$10$IgR5sQtn.JdnlxA1rnR8uK8/Ft6LVKQf1qaBvECvR4bPySKwOqiDi', '', 1, 0, NULL),
(2, 'María González', 'maria.gonzalez@ejemplo.com', '$2y$10$0hXQECrm3uD3XzTZiXnTDeW7qzWc5z3QZ8VrjXnJXDLn4XxuZ.y6a', '', 2, 1, '2025-04-20 14:30:00'),
(3, 'Carlos Ruiz', 'carlos.ruiz@ejemplo.com', '$2y$10$OtwRhz5TOz7fOqPvqfdfPKV5FwOGDzwj1t13v9w4VAEMiHvwZJkQy', '', 3, 0, NULL),
(4, 'Ana López', 'ana.lopez@ejemplo.com', '$2y$10$wG6fi0pS9JSQ9fHzaxmnbeB5L0mH69F2h81Yf8cHfT4FMNkcHwV3i', '', 4, 2, '2025-04-18 11:00:00'),
(5, 'Luis García', 'luis.garcia@ejemplo.com', '$2y$10$ME59mjKzN.o3VqznV0ZX1EXSoA4X21FvD3v0zQxKv5zXmvnwK21F2', '', 5, 0, NULL);

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `trg_limitar_usuarios` BEFORE INSERT ON `usuarios` FOR EACH ROW BEGIN
    DECLARE total INT;
    DECLARE maximo INT;
    SELECT COUNT(*) INTO total FROM usuarios WHERE Sede_ID = NEW.Sede_ID;
    SELECT Capacidad_Usuarios INTO maximo FROM sedes WHERE ID_Sede = NEW.Sede_ID;
    IF total >= maximo THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Capacidad máxima alcanzada para esta sede.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_usuarios_sede`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_usuarios_sede` (
`ID_Usuario` int(11)
,`Nombre_Usuario` varchar(100)
,`Email` varchar(100)
,`Nombre_Sede` varchar(100)
,`Ubicacion` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_usuarios_sede`
--
DROP TABLE IF EXISTS `vista_usuarios_sede`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_usuarios_sede`  AS SELECT `u`.`ID_Usuario` AS `ID_Usuario`, `u`.`Nombre_Usuario` AS `Nombre_Usuario`, `u`.`Email` AS `Email`, `s`.`Nombre` AS `Nombre_Sede`, `s`.`Ubicacion` AS `Ubicacion` FROM (`usuarios` `u` join `sedes` `s` on(`u`.`Sede_ID` = `s`.`ID_Sede`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`ID_Cita`),
  ADD KEY `citas_ibfk_1` (`ID_Paciente`),
  ADD KEY `citas_ibfk_2` (`ID_Medico`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`ID_Factura`),
  ADD KEY `facturacion_ibfk_1` (`ID_Paciente`),
  ADD KEY `facturacion_ibfk_2` (`ID_Medico`),
  ADD KEY `facturacion_ibfk_3` (`ID_Cita`);

--
-- Indices de la tabla `formulas_medicas`
--
ALTER TABLE `formulas_medicas`
  ADD PRIMARY KEY (`ID_Formula`),
  ADD KEY `formulas_medicas_ibfk_1` (`ID_Paciente`),
  ADD KEY `formulas_medicas_ibfk_2` (`ID_Medico`),
  ADD KEY `formulas_medicas_ibfk_3` (`ID_Medicamento`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`ID_Habitacion`),
  ADD KEY `habitaciones_ibfk_1` (`ID_Paciente`);

--
-- Indices de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD PRIMARY KEY (`ID_Historial`),
  ADD KEY `historial_clinico_ibfk_1` (`ID_Paciente`);

--
-- Indices de la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD PRIMARY KEY (`ID_Horario`),
  ADD KEY `horarios_medicos_ibfk_1` (`ID_Medico`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`ID_Medicamento`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`ID_Medico`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`ID_Paciente`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`ID_Sede`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`ID_Tratamiento`),
  ADD KEY `tratamientos_ibfk_1` (`ID_Historial`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `Sede_ID` (`Sede_ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `ID_Sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`);

--
-- Filtros para la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `facturacion_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`),
  ADD CONSTRAINT `facturacion_ibfk_3` FOREIGN KEY (`ID_Cita`) REFERENCES `citas` (`ID_Cita`);

--
-- Filtros para la tabla `formulas_medicas`
--
ALTER TABLE `formulas_medicas`
  ADD CONSTRAINT `formulas_medicas_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `formulas_medicas_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`),
  ADD CONSTRAINT `formulas_medicas_ibfk_3` FOREIGN KEY (`ID_Medicamento`) REFERENCES `medicamentos` (`ID_Medicamento`);

--
-- Filtros para la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD CONSTRAINT `habitaciones_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`) ON DELETE SET NULL;

--
-- Filtros para la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD CONSTRAINT `historial_clinico_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`);

--
-- Filtros para la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD CONSTRAINT `horarios_medicos_ibfk_1` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`);

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`ID_Historial`) REFERENCES `historial_clinico` (`ID_Historial`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Sede_ID`) REFERENCES `sedes` (`ID_Sede`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
