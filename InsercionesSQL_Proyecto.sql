USE `taller_mecanico_u1_modelo_final`;

START TRANSACTION;

-- Propietario | 5 registros
INSERT INTO `Propietario` (`id_propietario`, `nombres`, `apellidos`) VALUES
(1, 'Ana', 'Torres'),
(2, 'Carlos', 'Vega'),
(3, 'Maria', 'Paredes'),
(4, 'Luis', 'Jimenez'),
(5, 'Diana', 'Rojas');

-- Teléfono_Propietario | 8 registros
INSERT INTO `Teléfono_Propietario` (`id_propietario`, `teléfono`) VALUES
(1, '0991112233'),
(1, '072555001'),
(2, '0992223344'),
(3, '0993334455'),
(3, '072555003'),
(4, '0994445566'),
(5, '0995556677'),
(5, '072555005');

-- Mecánico | 5 registros
INSERT INTO `Mecánico` (`id_mecánico`, `nombre`) VALUES
(1, 'Jose Lopez'),
(2, 'Pedro Leon'),
(3, 'Elena Silva'),
(4, 'Marco Ruiz'),
(5, 'Sofia Castro');

-- Especialidad_Mecánico | 10 registros
INSERT INTO `Especialidad_Mecánico` (`id_mecánico`, `especialidad`) VALUES
(1, 'Frenos'),
(1, 'Suspension'),
(2, 'Mantenimiento'),
(2, 'Cambio de filtros'),
(3, 'Electricidad'),
(3, 'Diagnostico'),
(4, 'Suspension'),
(4, 'Frenos'),
(5, 'Refrigeracion'),
(5, 'Mantenimiento');

-- Distribuidor | 5 registros
INSERT INTO `Distribuidor` (`id_distribuidor`, `nombre`, `teléfono`, `calle`, `ciudad`) VALUES
(1, 'AutoPartes Loja', '072555101', 'Av. Universitaria 125', 'Loja'),
(2, 'Filtros del Sur', '072555102', 'Calle Colon 42', 'Loja'),
(3, 'Energia Automotriz', '072555103', 'Av. Central 87', 'Catamayo'),
(4, 'Suspension Andina', '072555104', 'Calle Azuay 210', 'Loja'),
(5, 'Repuestos Express', '072555105', 'Av. Zamora 55', 'Zamora');

-- Vehículo | 10 registros
INSERT INTO `Vehículo` (`id_vehículo`, `placa`, `tipo`, `marca`, `modelo`, `año_fabricación`, `id_propietario`) VALUES
(1, 'LBA-1023', 'Automovil', 'Toyota', 'Corolla', 2017, 1),
(2, 'LCA-2045', 'Camioneta', 'Chevrolet', 'D-Max', 2022, 2),
(3, 'LBD-3078', 'Camion', 'Hino', '300', 2018, 3),
(4, 'LCA-4090', 'Furgoneta', 'Hyundai', 'H1', 2019, 4),
(5, 'LBA-5012', 'Automovil', 'Kia', 'Rio', 2020, 5),
(6, 'LBA-6099', 'Automovil', 'Mazda', '3', 2023, 1),
(7, 'LBD-7100', 'Camion', 'Isuzu', 'NPR', 2015, 2),
(8, 'LBD-8101', 'Camion', 'Mitsubishi', 'Fuso', 2016, 3),
(9, 'LBD-9102', 'Camion', 'Freightliner', 'M2', 2017, 4),
(10, 'LBD-0103', 'Camion', 'Hino', '500', 2021, 5);

-- Vehículo_Liviano | 5 registros
INSERT INTO `Vehículo_Liviano` (`id_vehículo`, `capacidad_pasajeros`) VALUES
(1, 5),
(2, 5),
(4, 12),
(5, 5),
(6, 5);

-- Vehículo_Pesado | 5 registros
INSERT INTO `Vehículo_Pesado` (`id_vehículo`, `capacidad_carga`) VALUES
(3, 3.5),
(7, 4),
(8, 5),
(9, 8),
(10, 10);

-- Repuesto | 6 registros
INSERT INTO `Repuesto` (`id_repuesto`, `nombre`, `precio`, `stock`, `id_distribuidor`) VALUES
(1, 'Pastillas de freno', 36, 18, 1),
(2, 'Filtro de aceite', 12, 40, 2),
(3, 'Bateria 12 V', 95, 12, 3),
(4, 'Amortiguador', 65, 16, 4),
(5, 'Refrigerante 1 L', 9, 50, 5),
(6, 'Disco de freno', 55, 14, 1);

-- Reparacion | 8 registros
INSERT INTO `Reparacion` (`id_reparación`, `fecha`, `fallas`, `estado`, `costo`, `id_vehículo`, `id_mecánico`) VALUES
(1, '2026-10-05', 'Frenos desgastados', 'Finalizada', 45, 1, 1),
(2, '2026-10-06', 'Cambio de aceite', 'Finalizada', 20, 2, 2),
(3, '2026-10-07', 'Bateria descargada', 'Finalizada', 25, 3, 3),
(4, '2026-10-09', 'Problemas de suspension', 'En proceso', 60, 4, 4),
(5, '2026-10-10', 'Fuga de refrigerante', 'Pendiente', 30, 5, 5),
(6, '2026-10-12', 'Revision de frenos', 'En proceso', 40, 1, 1),
(7, '2026-10-15', 'Cambio de filtro', 'Finalizada', 35, 7, 2),
(8, '2026-10-17', 'Amortiguadores desgastados', 'En proceso', 75, 9, 4);

-- Detalle_Reparación | 10 registros
INSERT INTO `Detalle_Reparación` (`id_reparación`, `id_repuesto`, `cantidad`) VALUES
(1, 1, 1),
(1, 6, 2),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 1, 1),
(6, 6, 2),
(7, 2, 2),
(8, 4, 4);

COMMIT;

