USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Smarfit')
BEGIN
    ALTER DATABASE Smarfit SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Smarfit;
END
GO

-- Creamos la base de datos
CREATE DATABASE Smarfit;
GO

-- Seleccionamos la base
USE Smarfit;
GO

-- Tabla Locales
CREATE TABLE Locales (
    codigoLocal INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    capacidadMaxima INT NOT NULL,
    estado BIT NOT NULL
);
GO

INSERT INTO Locales (tipo, direccion, capacidadMaxima, estado) VALUES
('Gimnasio Básico', 'Av. La Marina 1234 - Lima', 50, 1),
('Centro Premium', 'Calle Primavera 567 - Surco', 80, 1),
('Box de Crossfit', 'Jr. Las Palmeras 890 - San Borja', 40, 0),
('Studio Yoga', 'Av. El Polo 999 - La Molina', 35, 1),
('Área Funcional', 'Calle Canta 1010 - Miraflores', 25, 1);
GO

SELECT * FROM Locales;
GO

-- Tabla Trainer
CREATE TABLE Trainer (
    codigoTrainer INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    disponibilidad BIT NOT NULL
);
GO

INSERT INTO Trainer (nombre, apellido, especialidad, disponibilidad) VALUES
('Carlos', 'Paredes', 'Entrenamiento Funcional', 1),
('Andrea', 'Sánchez', 'Yoga y Pilates', 1),
('Luis', 'Ramírez', 'Crossfit', 0),
('Valeria', 'Morales', 'Musculación y Cardio', 1),
('Fernando', 'Gómez', 'Boxeo y HIIT', 1);
GO

SELECT * FROM Trainer;
GO

-- Tabla Cliente
CREATE TABLE Cliente (
    codigoCliente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    historialEntrenamientos VARCHAR(100) NOT NULL,
    estado BIT NOT NULL
);
GO

INSERT INTO Cliente (nombre, correo, telefono, direccion, historialEntrenamientos, estado) VALUES
('María López', 'maria.lopez@gmail.com', '987654321', 'Av. Brasil 123 - Lima', '5 sesiones de yoga', 1),
('Pedro Torres', 'pedro.torres@yahoo.com', '912345678', 'Jr. Unión 456 - Callao', '3 entrenamientos funcionales', 1),
('Lucía Ramírez', 'lucia.ram@gmail.com', '900123456', 'Calle Lima 789 - San Isidro', '2 sesiones de cardio', 0),
('Juan Pérez', 'juanperez@hotmail.com', '989898989', 'Av. Grau 1010 - Lima', '1 clase de boxeo', 1);
GO

SELECT * FROM Cliente;
GO

-- Tabla Sancion (depende de Cliente)
CREATE TABLE Sancion (
    codigo INT PRIMARY KEY IDENTITY(1,1),
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    motivo VARCHAR(100) NULL,
    codigoCliente INT NOT NULL,
    estado BIT NOT NULL,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente)
);
GO

INSERT INTO Sancion (fechaInicio, fechaFin, motivo, codigoCliente, estado) VALUES
('2025-06-01', '2025-06-07', 'No pago a tiempo', 2, 1),
('2025-07-10', '2025-07-15', 'Mal comportamiento', 3, 1),
('2025-07-01', '2025-07-05', 'Falta reiterada sin aviso', 4, 1);
GO

SELECT * FROM Sancion;
GO

-- Tabla Reclamo (depende de Cliente)
CREATE TABLE Reclamo (
    codigo INT PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    estado BIT NOT NULL,
    codigoCliente INT NOT NULL,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente)
);
GO

INSERT INTO Reclamo (descripcion, fecha, estado, codigoCliente) VALUES
('Falta de limpieza en baños', '2025-07-01', 1, 1),
('Cambio de horario sin aviso', '2025-07-05', 0, 2),
('Maltrato por parte del personal', '2025-07-10', 0, 3),
('Equipos dañados en sala de pesas', '2025-07-12', 1, 1);
GO

SELECT * FROM Reclamo;
GO

-- Tabla Entrenamiento (depende de Trainer y Locales)
CREATE TABLE Entrenamiento (
    codigoEntrenamiento INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50) NOT NULL,
    fechaHora DATETIME NOT NULL,
    duracion DECIMAL(5,2) NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    capacidadMaxima INT NOT NULL,
    estado BIT NOT NULL,
    codigoTrainer INT NOT NULL,
    codigoLocal INT NOT NULL,
    FOREIGN KEY (codigoTrainer) REFERENCES Trainer(codigoTrainer),
    FOREIGN KEY (codigoLocal) REFERENCES Locales(codigoLocal)
);
GO

INSERT INTO Entrenamiento (tipo, fechaHora, duracion, ubicacion, capacidadMaxima, estado, codigoTrainer, codigoLocal) VALUES
('Yoga', '2025-07-20 08:00:00', 1.5, 'Sala A', 20, 1, 2, 4),
('Crossfit', '2025-07-21 18:00:00', 1.0, 'Box 1', 15, 1, 3, 3),
('Funcional', '2025-07-22 07:00:00', 1.0, 'Zona Libre', 25, 1, 1, 1),
('Cardio HIIT', '2025-07-23 19:00:00', 0.75, 'Área Cardio', 30, 1, 5, 2),
('Pilates', '2025-07-24 09:00:00', 1.0, 'Sala B', 10, 0, 2, 4);
GO

SELECT * FROM Entrenamiento;
GO

USE Smarfit;
GO

IF OBJECT_ID('Pedido', 'U') IS NOT NULL
  DROP TABLE Pedido;
GO

CREATE TABLE Pedido (
    codigoPedido   INT           PRIMARY KEY IDENTITY(1,1),
    codigoCliente  INT           NOT NULL,              
    fechaPedido    DATETIME      NOT NULL DEFAULT GETDATE(),
    total          DECIMAL(10,2) NOT NULL DEFAULT 0,    
    estado         BIT           NOT NULL DEFAULT 1,    
    CONSTRAINT FK_Pedido_Cliente 
      FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente)
);
GO

USE Smarfit;
GO

IF OBJECT_ID('DetallePedido', 'U') IS NOT NULL
  DROP TABLE DetallePedido;
GO

CREATE TABLE DetallePedido (
    codigoDetallePedido INT           PRIMARY KEY IDENTITY(1,1),
    codigoPedido        INT           NOT NULL,           
    codigoEntrenamiento INT           NOT NULL,           
    cantidad            INT           NOT NULL,
    precioUnitario      DECIMAL(10,2) NOT NULL,
    estado              BIT           NOT NULL DEFAULT 1,
    CONSTRAINT FK_DetallePedido_Pedido 
      FOREIGN KEY (codigoPedido) REFERENCES Pedido(codigoPedido),
    CONSTRAINT FK_DetallePedido_Entrenamiento 
      FOREIGN KEY (codigoEntrenamiento) REFERENCES Entrenamiento(codigoEntrenamiento)
);
GO

-- Tabla Inscripciones para manejar asignaciones Cliente-Entrenamiento
CREATE TABLE Inscripciones (
    codigoInscripcion INT IDENTITY(1,1) PRIMARY KEY,
    codigoCliente INT NOT NULL,
    codigoEntrenamiento INT NOT NULL,
    fechaInscripcion DATETIME DEFAULT GETDATE(),
    estado BIT DEFAULT 1,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente),
    FOREIGN KEY (codigoEntrenamiento) REFERENCES Entrenamiento(codigoEntrenamiento)
);

-- Datos de ejemplo
INSERT INTO Inscripciones (codigoCliente, codigoEntrenamiento, fechaInscripcion, estado)
VALUES 
(1, 1, GETDATE(), 1),
(2, 1, GETDATE(), 1),
(1, 2, GETDATE(), 1);
