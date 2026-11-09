# Implementación de una base de datos relacional para la gestión de reparaciones en un taller mecánico de vehículos

**Informe de fin de unidad — Base de Datos, Unidad 1**

| Dato | Información |
|---|---|
| Institución | Universidad Nacional de Loja — Carrera de Computación |
| Ciclo | 3A |
| Docente | Edwin René Guamán Quinche |
| Estudiante | Paolo Julián Merino Guamán |
| Fecha | 09/11/2026 |

> El proyecto está dedicado al modelado y a las consultas de una base de datos para un taller mecánico. Los registros utilizados en el archivo SQL son **ficticios** y tienen fines académicos.

## Contenido

1. [Contexto del problema](#1-contexto-del-problema)
2. [Objetivos](#2-objetivos)
3. [Modelos de base de datos](#3-modelos-de-base-de-datos)
4. [Modelo relacional y diccionario de datos](#4-modelo-relacional-y-diccionario-de-datos)
5. [Código SQL: DDL y DML](#5-código-sql-ddl-y-dml)
6. [Consultas de álgebra relacional y SQL](#6-consultas-de-álgebra-relacional-y-sql)
7. [Conclusiones](#7-conclusiones)
8. [Bibliografía](#8-bibliografía)

---

## 1. Contexto del problema

En los talleres mecánicos dedicados al mantenimiento y reparación de automóviles, camionetas, furgonetas y camiones, es necesario administrar constantemente información relacionada con los propietarios, vehículos, mecánicos, reparaciones y repuestos utilizados.

Muchos talleres pequeños realizan estos registros de forma manual, mediante cuadernos o documentos independientes, lo que puede ocasionar pérdida de información, duplicación de datos y dificultades para consultar el historial de reparaciones de cada vehículo. Esta situación afecta al personal administrativo, a los mecánicos y a los propietarios, debido a que dificulta el seguimiento de los trabajos y el control de los recursos disponibles.

Ante esta problemática, surge la necesidad de contar con una base de datos que permita centralizar y relacionar la información del taller, facilitando el registro de las reparaciones, la identificación de los responsables, el control de los repuestos y la consulta de información, contribuyendo así a una gestión más organizada y eficiente.

## 2. Objetivos

### Objetivo general

Diseñar una base de datos que centralice la información de propietarios, vehículos, mecánicos, reparaciones, repuestos y distribuidores, para facilitar el registro de los servicios y la consulta de los trabajos realizados en el taller.

### Objetivos específicos

1. Organizar la información de los vehículos, sus propietarios y los servicios del taller mediante una estructura que defina los datos necesarios y las relaciones entre ellos.

2. Implementar las tablas y sus restricciones en SQL, incorporar registros de prueba y realizar consultas que permitan dar seguimiento a las reparaciones, identificar repuestos utilizados y obtener información útil para la gestión del taller.

## 3. Modelos de base de datos

### 3.1. Modelo entidad–relación (E-R)

![Modelo entidad-relación del taller mecánico](Modelo_ER_taller.png)

*Figura 1. Diagrama E-R del sistema de gestión para taller mecánico de vehículos.*

El modelo contempla propietarios, vehículos, mecánicos, reparaciones, repuestos y distribuidores, así como la especialización de los vehículos en livianos y pesados. El atributo `nombre_completo` de propietario y la `direccion` del distribuidor se descomponen en sus componentes; `telefonos` y `especialidades` admiten varios valores, mientras que `antiguedad` se calcula a partir del año de fabricación.

### 3.2. Modelo relacional por listas

![Modelo relacional por listas, incluido en el informe](ModeloRelacional_taller.png)

*Figura 2. Representación relacional por listas del documento académico.*

Para la implementación física, los teléfonos y las especialidades se almacenan en relaciones propias. La relación `UTILIZA` del diagrama E-R se representa mediante la tabla `DETALLE_REPARACION`, que guarda los identificadores de reparación y repuesto junto con su cantidad.

## 4. Modelo relacional y diccionario de datos

**PK**: clave primaria; **FK**: clave foránea. Cuando dos atributos aparecen marcados como PK en la misma tabla, conforman una clave primaria compuesta.

### PROPIETARIO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_propietario` | `INT` | PK | — |
| `nombres` | `VARCHAR(60)` | — | — |
| `apellidos` | `VARCHAR(60)` | — | — |

### TELEFONO_PROPIETARIO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_propietario` | `INT` | PK, FK | PROPIETARIO(id_propietario) |
| `telefono` | `VARCHAR(15)` | PK | — |

### MECANICO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_mecanico` | `INT` | PK | — |
| `nombre` | `VARCHAR(100)` | — | — |

### ESPECIALIDAD_MECANICO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_mecanico` | `INT` | PK, FK | MECANICO(id_mecanico) |
| `especialidad` | `VARCHAR(80)` | PK | — |

### DISTRIBUIDOR

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_distribuidor` | `INT` | PK | — |
| `nombre` | `VARCHAR(100)` | — | — |
| `telefono` | `VARCHAR(15)` | — | — |
| `calle` | `VARCHAR(100)` | — | — |
| `ciudad` | `VARCHAR(60)` | — | — |

### VEHICULO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_vehiculo` | `INT` | PK | — |
| `placa` | `VARCHAR(12)` | UNIQUE | — |
| `tipo` | `VARCHAR(20)` | — | — |
| `marca` | `VARCHAR(50)` | — | — |
| `modelo` | `VARCHAR(50)` | — | — |
| `anio_fabricacion` | `SMALLINT` | — | — |
| `id_propietario` | `INT` | FK | PROPIETARIO(id_propietario) |

### VEHICULO_LIVIANO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_vehiculo` | `INT` | PK, FK | VEHICULO(id_vehiculo) |
| `capacidad_pasajeros` | `INT` | — | — |

### VEHICULO_PESADO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_vehiculo` | `INT` | PK, FK | VEHICULO(id_vehiculo) |
| `capacidad_carga` | `DECIMAL(8,2)` | — | — |

### REPUESTO

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_repuesto` | `INT` | PK | — |
| `nombre` | `VARCHAR(100)` | — | — |
| `precio` | `DECIMAL(10,2)` | — | — |
| `stock` | `INT` | — | — |
| `id_distribuidor` | `INT` | FK | DISTRIBUIDOR(id_distribuidor) |

### REPARACION

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_reparacion` | `INT` | PK | — |
| `fecha` | `DATE` | — | — |
| `fallas` | `VARCHAR(250)` | — | — |
| `estado` | `VARCHAR(20)` | — | — |
| `costo` | `DECIMAL(10,2)` | — | — |
| `id_vehiculo` | `INT` | FK | VEHICULO(id_vehiculo) |
| `id_mecanico` | `INT` | FK | MECANICO(id_mecanico) |

### DETALLE_REPARACION

| Atributo | Tipo SQL | Clave | Referencia |
|---|---|---|---|
| `id_reparacion` | `INT` | PK, FK | REPARACION(id_reparacion) |
| `id_repuesto` | `INT` | PK, FK | REPUESTO(id_repuesto) |
| `cantidad` | `INT` | — | — |

**Criterios de implementación:** las claves primarias y las claves foráneas usan tipos compatibles (`INT`). El año de fabricación se almacena como `SMALLINT` (por ejemplo, `2022`), no como fecha completa. El atributo derivado `antiguedad` no se guarda en `VEHICULO`; se obtiene mediante una vista. El campo `costo` de `REPARACION` corresponde al servicio sin sumar el valor de los repuestos.

## 5. Código SQL: DDL y DML

La implementación incluye las **11 tablas**, las restricciones de integridad, el atributo derivado calculado mediante vista y los registros de prueba. El archivo [**taller_mecanico.sql**](taller_mecanico.sql) puede ejecutarse en **MySQL 8.0.16 o posterior**, sobre una base de datos nueva. El script no debe ejecutarse dos veces sin limpiar las tablas existentes.

### 5.1. Creación de tablas (DDL)

```sql
CREATE DATABASE IF NOT EXISTS taller_mecanico_u1
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE taller_mecanico_u1;

-- 5.1 DEFINICION DE TABLAS (DDL)

-- PROPIETARIO
CREATE TABLE PROPIETARIO (
    id_propietario INT NOT NULL,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_propietario)
);

-- TELEFONO_PROPIETARIO
CREATE TABLE TELEFONO_PROPIETARIO (
    id_propietario INT NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_propietario, telefono),
    FOREIGN KEY (id_propietario) REFERENCES PROPIETARIO(id_propietario)
);

-- MECANICO
CREATE TABLE MECANICO (
    id_mecanico INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_mecanico)
);

-- ESPECIALIDAD_MECANICO
CREATE TABLE ESPECIALIDAD_MECANICO (
    id_mecanico INT NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_mecanico, especialidad),
    FOREIGN KEY (id_mecanico) REFERENCES MECANICO(id_mecanico)
);

-- DISTRIBUIDOR
CREATE TABLE DISTRIBUIDOR (
    id_distribuidor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_distribuidor)
);

-- VEHICULO
CREATE TABLE VEHICULO (
    id_vehiculo INT NOT NULL,
    placa VARCHAR(12) NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio_fabricacion SMALLINT NOT NULL,
    id_propietario INT NOT NULL,
    PRIMARY KEY (id_vehiculo),
    CHECK (tipo IN ('Automovil', 'Camioneta', 'Furgoneta', 'Camion')),
    CHECK (anio_fabricacion BETWEEN 1950 AND 2100),
    FOREIGN KEY (id_propietario) REFERENCES PROPIETARIO(id_propietario)
);

-- VEHICULO_LIVIANO
CREATE TABLE VEHICULO_LIVIANO (
    id_vehiculo INT NOT NULL,
    capacidad_pasajeros INT NOT NULL,
    PRIMARY KEY (id_vehiculo),
    CHECK (capacidad_pasajeros > 0),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);

-- VEHICULO_PESADO
CREATE TABLE VEHICULO_PESADO (
    id_vehiculo INT NOT NULL,
    capacidad_carga DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_vehiculo),
    CHECK (capacidad_carga > 0),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);

-- REPUESTO
CREATE TABLE REPUESTO (
    id_repuesto INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    id_distribuidor INT NOT NULL,
    PRIMARY KEY (id_repuesto),
    CHECK (precio >= 0),
    CHECK (stock >= 0),
    FOREIGN KEY (id_distribuidor) REFERENCES DISTRIBUIDOR(id_distribuidor)
);

-- REPARACION
CREATE TABLE REPARACION (
    id_reparacion INT NOT NULL,
    fecha DATE NOT NULL,
    fallas VARCHAR(250) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    costo DECIMAL(10,2) NOT NULL DEFAULT 0,
    id_vehiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    PRIMARY KEY (id_reparacion),
    CHECK (estado IN ('Pendiente','En proceso','Finalizada')),
    CHECK (costo >= 0),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
    FOREIGN KEY (id_mecanico) REFERENCES MECANICO(id_mecanico)
);

-- DETALLE_REPARACION
CREATE TABLE DETALLE_REPARACION (
    id_reparacion INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_reparacion, id_repuesto),
    CHECK (cantidad > 0),
    FOREIGN KEY (id_reparacion) REFERENCES REPARACION(id_reparacion),
    FOREIGN KEY (id_repuesto) REFERENCES REPUESTO(id_repuesto)
);

-- Vista para atributo derivado (no materializado en la tabla VEHICULO)
-- La antiguedad es DERIVADA en el diagrama E-R; NO se almacena.
-- Edad aproximada en anios calendario, no edad exacta desde matriculacion.
CREATE OR REPLACE VIEW V_ANTIGUEDAD_VEHICULO AS
SELECT id_vehiculo, placa, tipo, marca, modelo, anio_fabricacion,
       YEAR(CURDATE()) - anio_fabricacion AS antiguedad
FROM VEHICULO;
```

### 5.2. Inserción de datos (DML)

```sql
-- PROPIETARIO
INSERT INTO PROPIETARIO (id_propietario,nombres,apellidos) VALUES
(1,'Ana','Torres'),(2,'Carlos','Vega'),(3,'Maria','Paredes'),
(4,'Luis','Jimenez'),(5,'Diana','Rojas');

-- TELEFONO_PROPIETARIO
INSERT INTO TELEFONO_PROPIETARIO (id_propietario,telefono) VALUES
(1,'0991112233'),(1,'072555001'),(2,'0992223344'),
(3,'0993334455'),(3,'072555003'),(4,'0994445566'),
(5,'0995556677'),(5,'072555005');

-- MECANICO
INSERT INTO MECANICO (id_mecanico,nombre) VALUES
(1,'Jose Lopez'),(2,'Pedro Leon'),(3,'Elena Silva'),
(4,'Marco Ruiz'),(5,'Sofia Castro');

-- ESPECIALIDAD_MECANICO
INSERT INTO ESPECIALIDAD_MECANICO (id_mecanico,especialidad) VALUES
(1,'Frenos'),(1,'Suspension'),(2,'Mantenimiento'),
(2,'Cambio de filtros'),(3,'Electricidad'),(3,'Diagnostico'),
(4,'Suspension'),(4,'Frenos'),(5,'Refrigeracion'),(5,'Mantenimiento');

-- DISTRIBUIDOR
INSERT INTO DISTRIBUIDOR
(id_distribuidor,nombre,telefono,calle,ciudad) VALUES
(1,'AutoPartes Loja','072555101','Av. Universitaria 125','Loja'),
(2,'Filtros del Sur','072555102','Calle Colon 42','Loja'),
(3,'Energia Automotriz','072555103','Av. Central 87','Catamayo'),
(4,'Suspension Andina','072555104','Calle Azuay 210','Loja'),
(5,'Repuestos Express','072555105','Av. Zamora 55','Zamora');

-- VEHICULO
INSERT INTO VEHICULO
(id_vehiculo,placa,tipo,marca,modelo,anio_fabricacion,id_propietario) VALUES
(1,'LBA-1023','Automovil','Toyota','Corolla',2017,1),
(2,'LCA-2045','Camioneta','Chevrolet','D-Max',2022,2),
(3,'LBD-3078','Camion','Hino','300',2018,3),
(4,'LCA-4090','Furgoneta','Hyundai','H1',2019,4),
(5,'LBA-5012','Automovil','Kia','Rio',2020,5),
(6,'LBA-6099','Automovil','Mazda','3',2023,1),
(7,'LBD-7100','Camion','Isuzu','NPR',2015,2),
(8,'LBD-8101','Camion','Mitsubishi','Fuso',2016,3),
(9,'LBD-9102','Camion','Freightliner','M2',2017,4),
(10,'LBD-0103','Camion','Hino','500',2021,5);

-- VEHICULO_LIVIANO
INSERT INTO VEHICULO_LIVIANO (id_vehiculo,capacidad_pasajeros) VALUES
(1,5),(2,5),(4,12),(5,5),(6,5);

-- VEHICULO_PESADO
INSERT INTO VEHICULO_PESADO (id_vehiculo,capacidad_carga) VALUES
(3,3.50),(7,4.00),(8,5.00),(9,8.00),(10,10.00);

-- REPUESTO
INSERT INTO REPUESTO (id_repuesto,nombre,precio,stock,id_distribuidor) VALUES
(1,'Pastillas de freno',36.00,18,1),
(2,'Filtro de aceite',12.00,40,2),
(3,'Bateria 12 V',95.00,12,3),
(4,'Amortiguador',65.00,16,4),
(5,'Refrigerante 1 L',9.00,50,5),
(6,'Disco de freno',55.00,14,1),
(7,'Grasa multiproposito',8.50,30,1);

-- REPARACION
INSERT INTO REPARACION
(id_reparacion,fecha,fallas,estado,costo,id_vehiculo,id_mecanico) VALUES
(1,'2026-10-05','Frenos desgastados','Finalizada',45.00,1,1),
(2,'2026-10-06','Cambio de aceite','Finalizada',20.00,2,2),
(3,'2026-10-07','Bateria descargada','Finalizada',25.00,3,3),
(4,'2026-10-09','Problemas de suspension','En proceso',60.00,4,4),
(5,'2026-10-10','Fuga de refrigerante','Pendiente',30.00,5,5),
(6,'2026-10-12','Revision de frenos','En proceso',40.00,1,1),
(7,'2026-10-15','Cambio de filtro','Finalizada',35.00,7,2),
(8,'2026-10-17','Amortiguadores desgastados','En proceso',75.00,9,4);

-- DETALLE_REPARACION
INSERT INTO DETALLE_REPARACION (id_reparacion,id_repuesto,cantidad) VALUES
(1,1,1),(1,6,2),(2,2,1),(3,3,1),(4,4,2),
(5,5,2),(6,1,1),(6,6,2),(7,2,2),(8,4,4),
(1,7,1),(2,7,1),(3,7,1),(7,7,1);
```

## 6. Consultas de álgebra relacional y SQL

Las siguientes consultas se han formulado para el funcionamiento del taller mecánico. Se presentan los objetivos, su expresión en álgebra relacional, la traducción a SQL y el resultado esperado, sin suponer un número fijo de registros en una base de datos real.

### 6.1. Reparaciones en proceso con costo superior a $50

**Objetivo:** Identificar las reparaciones que permanecen en proceso y cuyo costo del servicio supera los 50 dólares, con el propósito de dar seguimiento a los trabajos pendientes que representan un mayor costo de mano de obra.

**Álgebra relacional:**

```text
RESULTADO ← σ_{estado='En proceso' ∧ costo>50}(REPARACION)
```

**SQL:**

```sql
SELECT *
FROM REPARACION
WHERE estado = 'En proceso'
  AND costo > 50
ORDER BY id_reparacion;
```

**Resultado esperado:** Se obtendrán los registros de las reparaciones que se encuentren en estado 'En proceso' y cuyo costo sea superior a $50, siempre que existan registros que cumplan ambas condiciones.

### 6.2. Combinaciones posibles de mecánicos y distribuidores — producto cartesiano (×)

**Objetivo:** Explorar las combinaciones posibles entre el personal mecánico y los distribuidores de repuestos, mostrando ambos nombres sin confundir los atributos homónimos.

**Álgebra relacional:**

```text
M1 ← ρ_{nombre_mecanico ← nombre}(MECANICO)
D1 ← ρ_{nombre_distribuidor ← nombre}(DISTRIBUIDOR)
RESULTADO ← π_{nombre_mecanico,nombre_distribuidor}(M1 × D1)
```

**SQL:**

```sql
SELECT M.nombre AS nombre_mecanico,
       D.nombre AS nombre_distribuidor
FROM MECANICO M
CROSS JOIN DISTRIBUIDOR D
ORDER BY M.id_mecanico, D.id_distribuidor;
```

**Resultado esperado:** Se mostrarán todas las combinaciones posibles entre mecánicos y distribuidores registrados, en columnas separadas. Su cantidad dependerá de los registros existentes y no implica relaciones comerciales reales.

### 6.3. Repuestos de distribuidores de Loja con precio superior a $30

**Objetivo:** Obtener el nombre, precio y distribuidor de los repuestos que cuestan más de 30 dólares y proceden de establecimientos ubicados en Loja.

**Álgebra relacional:**

```text
R1 ← ρ_{nombre_repuesto ← nombre}(REPUESTO)
D1 ← ρ_{nombre_distribuidor ← nombre}(DISTRIBUIDOR)
R2 ← σ_{ciudad='Loja' ∧ precio>30}(R1 ⋈ D1)
RESULTADO ← π_{nombre_repuesto,precio,nombre_distribuidor}(R2)
```

**SQL:**

```sql
SELECT R.nombre AS nombre_repuesto,
       R.precio,
       D.nombre AS nombre_distribuidor
FROM REPUESTO R
JOIN DISTRIBUIDOR D ON R.id_distribuidor = D.id_distribuidor
WHERE D.ciudad = 'Loja'
  AND R.precio > 30
ORDER BY R.id_repuesto;
```

**Resultado esperado:** Se mostrarán los repuestos cuyo precio sea superior a $30 y que estén asociados con distribuidores de Loja, indicando su nombre, precio y proveedor.

### 6.4. Reparaciones en proceso asignadas a mecánicos especializados en frenos

**Objetivo:** Identificar las reparaciones que continúan en proceso y están asignadas a mecánicos que cuentan con la especialidad de frenos.

**Álgebra relacional:**

```text
M1 ← ρ_{mecanico ← nombre}(MECANICO)
R1 ← REPARACION ⋈ VEHICULO ⋈ M1 ⋈ ESPECIALIDAD_MECANICO
R2 ← σ_{estado='En proceso' ∧ especialidad='Frenos'}(R1)
RESULTADO ← π_{id_reparacion,placa,marca,mecanico}(R2)
```

**SQL:**

```sql
SELECT DISTINCT R.id_reparacion, V.placa,
       V.marca, M.nombre AS mecanico
FROM REPARACION R
JOIN VEHICULO V ON R.id_vehiculo = V.id_vehiculo
JOIN MECANICO M ON R.id_mecanico = M.id_mecanico
JOIN ESPECIALIDAD_MECANICO E ON E.id_mecanico = M.id_mecanico
WHERE E.especialidad = 'Frenos'
  AND R.estado = 'En proceso'
ORDER BY R.id_reparacion;
```

**Resultado esperado:** Se identificarán las reparaciones en proceso atendidas por mecánicos con especialidad en frenos, junto con la placa, marca del vehículo y nombre del mecánico.

### 6.5. Repuestos utilizados en todas las reparaciones finalizadas — división (÷)

**Objetivo:** Identificar los repuestos utilizados en todas las reparaciones finalizadas del taller mecánico. La consulta emplea división relacional para comprobar la presencia del mismo repuesto en cada una de las reparaciones seleccionadas.

**Álgebra relacional:**

```text
S1 ← π_{id_reparacion}(σ_{estado='Finalizada'}(REPARACION))
S2 ← π_{id_repuesto,id_reparacion}(DETALLE_REPARACION)
S3 ← S2 ÷ S1
RESULTADO ← π_{id_repuesto,nombre}(S3 ⋈ REPUESTO)
```

**SQL:**

```sql
SELECT P.id_repuesto, P.nombre
FROM REPUESTO P
WHERE EXISTS (
    SELECT 1
    FROM REPARACION R
    WHERE R.estado = 'Finalizada'
)
AND NOT EXISTS (
    SELECT 1
    FROM REPARACION R
    WHERE R.estado = 'Finalizada'
      AND NOT EXISTS (
          SELECT 1
          FROM DETALLE_REPARACION D
          WHERE D.id_reparacion = R.id_reparacion
            AND D.id_repuesto = P.id_repuesto
      )
)
ORDER BY P.id_repuesto;
```

**Resultado esperado:** Se obtendrán los repuestos utilizados en todas las reparaciones que figuren como finalizadas. Si no existe ninguna reparación finalizada, o ningún repuesto satisface la condición, no se devolverán registros.

## 7. Conclusiones

1. La organización de la información permitió relacionar cada vehículo con su propietario y sus reparaciones, además de identificar al mecánico responsable de cada trabajo. Esta estructura facilita la consulta de antecedentes y reduce el riesgo de duplicar registros.

2. Las tablas y restricciones implementadas en SQL proporcionan un control ordenado sobre los datos de contacto, los tipos de vehículos y los repuestos utilizados. Los registros de prueba permitieron comprobar las relaciones y distinguir el costo del servicio del importe correspondiente a los materiales.

3. El álgebra relacional permitió construir consultas de distinta complejidad antes de llevarlas a SQL. La combinación de filtros, renombramiento, producto cartesiano, reuniones y división facilitó la búsqueda de reparaciones, la identificación de repuestos según sus distribuidores y la comprobación de materiales utilizados en varios trabajos.

## 8. Bibliografía

[1] E. R. Guamán Quinche, «Paso Modelo E/R a Modelo Relacional», material de clase, Carrera de Computación, Universidad Nacional de Loja, Loja, Ecuador, s. f.

[2] E. R. Guamán Quinche, «Álgebra Relacional», material de clase, Carrera de Computación, Universidad Nacional de Loja, Loja, Ecuador, s. f.

[3] R. Elmasri y S. B. Navathe, Fundamentals of Database Systems, 7.ª ed. Pearson, 2016. [En línea]. Disponible en: https://books.google.com/books?id=Yb_uoQEACAAJ

[4] A. Silberschatz, H. F. Korth y S. Sudarshan, Database System Concepts, 7.ª ed. McGraw-Hill, 2019. [En línea]. Disponible en: https://www.db-book.com/

---

**Documento original:** [Informe de Evaluación U1 en Word](docs/ProyectoUnidad1_BaseDeDatos.docx).  
**Base de datos:** [Script completo DDL, DML y consultas](taller_mecanico.sql).
