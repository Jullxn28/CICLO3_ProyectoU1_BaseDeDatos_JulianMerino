CREATE DATABASE TallerMecanico_db;
USE TallerMecanico_db;

-- 1. PROPIETARIO
CREATE TABLE PROPIETARIO (
    id_propietario VARCHAR(10) NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_propietario)
);

-- 2. TELEFONO_PROPIETARIO (atributo multivaluado)
CREATE TABLE TELEFONO_PROPIETARIO (
    id_propietario VARCHAR(10) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_propietario, telefono),
    FOREIGN KEY (id_propietario) 
        REFERENCES PROPIETARIO (id_propietario)
);

-- 3. MECANICO
CREATE TABLE MECANICO (
    id_mecanico VARCHAR(10) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_mecanico)
);

-- 4. ESPECIALIDAD_MECANICO (atributo multivaluado)
CREATE TABLE ESPECIALIDAD_MECANICO (
    id_mecanico VARCHAR(10) NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_mecanico, especialidad),
    FOREIGN KEY (id_mecanico) 
        REFERENCES MECANICO (id_mecanico)
);

-- 5. DISTRIBUIDOR
CREATE TABLE DISTRIBUIDOR (
    id_distribuidor VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_distribuidor)
);

-- 6. VEHICULO
CREATE TABLE VEHICULO (
    id_vehiculo VARCHAR(10) NOT NULL,
    placa VARCHAR(12) NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio_fabricacion INT NOT NULL,
    id_propietario VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_vehiculo),
    FOREIGN KEY (id_propietario) 
        REFERENCES PROPIETARIO (id_propietario)
);

-- 7. VEHICULO_LIVIANO (subtipo)
CREATE TABLE VEHICULO_LIVIANO (
    id_vehiculo VARCHAR(10) NOT NULL,
    capacidad_pasajeros INT NOT NULL,
    PRIMARY KEY (id_vehiculo),
    FOREIGN KEY (id_vehiculo) 
        REFERENCES VEHICULO (id_vehiculo)
);

-- 8. VEHICULO_PESADO (subtipo)
CREATE TABLE VEHICULO_PESADO (
    id_vehiculo VARCHAR(10) NOT NULL,
    capacidad_carga DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_vehiculo),
    FOREIGN KEY (id_vehiculo) 
        REFERENCES VEHICULO (id_vehiculo)
);

-- 9. REPUESTO
CREATE TABLE REPUESTO (
    id_repuesto VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_distribuidor VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_repuesto),
    FOREIGN KEY (id_distribuidor) 
        REFERENCES DISTRIBUIDOR (id_distribuidor)
);

-- 10. REPARACION
CREATE TABLE REPARACION (
    id_reparacion VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    fallas VARCHAR(250) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    id_vehiculo VARCHAR(10) NOT NULL,
    id_mecanico VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_reparacion),
    FOREIGN KEY (id_vehiculo) 
        REFERENCES VEHICULO (id_vehiculo),
    FOREIGN KEY (id_mecanico) 
        REFERENCES MECANICO (id_mecanico)
);

-- 11. DETALLE_REPARACION
CREATE TABLE DETALLE_REPARACION (
    id_reparacion VARCHAR(10) NOT NULL,
    id_repuesto VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_reparacion, id_repuesto),
    FOREIGN KEY (id_reparacion) 
        REFERENCES REPARACION (id_reparacion),
    FOREIGN KEY (id_repuesto) 
        REFERENCES REPUESTO (id_repuesto)
);
