USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'megaforce')
BEGIN
    ALTER DATABASE megaforce SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE megaforce;
END
GO

-- Crear base de datos
CREATE DATABASE megaforce;
GO

USE megaforce;
GO

/* ===========================
   TABLA LOCALES
   =========================== */
CREATE TABLE Locales (
    codigoLocal INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    capacidadMaxima INT NOT NULL,
    estado BIT NOT NULL
);
GO

/* ===========================
   TABLA TRAINER
   =========================== */
CREATE TABLE Trainer (
    codigoTrainer INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    disponibilidad BIT NOT NULL,
    estado BIT NOT NULL
);
GO

/* ===========================
   TABLA CLIENTE
   =========================== */
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

/* ===========================
   TABLA SANCION
   =========================== */
CREATE TABLE Sancion (
    codigo INT PRIMARY KEY IDENTITY(1,1),
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    motivo VARCHAR(100),
    codigoCliente INT NOT NULL,
    estado BIT NOT NULL,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente)
);
GO

/* ===========================
   TABLA RECLAMO
   =========================== */
CREATE TABLE Reclamo (
    codigo INT PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    estado BIT NOT NULL,
    codigoCliente INT NOT NULL,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente)
);
GO

/* ===========================
   TABLA ENTRENAMIENTO
   =========================== */
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

/* ===========================
   TABLA MetodoPago
   =========================== */
CREATE TABLE MetodoPago (
    idMetodoPago INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150),
    estado BIT NOT NULL DEFAULT 1
);
GO

/* ===========================
   TABLA PEDIDO (con MetodoPago)
   =========================== */
CREATE TABLE Pedido (
    codigoPedido INT PRIMARY KEY IDENTITY(1,1),
    codigoCliente INT NOT NULL,
    idMetodoPago INT NULL,
    fechaPedido DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente),
    FOREIGN KEY (idMetodoPago) REFERENCES MetodoPago(idMetodoPago)
);
GO

/* ===========================
   TABLA DETALLEPEDIDO
   =========================== */
CREATE TABLE DetallePedido (
    codigoDetallePedido INT PRIMARY KEY IDENTITY(1,1),
    codigoPedido INT NOT NULL,
    codigoEntrenamiento INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (codigoPedido) REFERENCES Pedido(codigoPedido),
    FOREIGN KEY (codigoEntrenamiento) REFERENCES Entrenamiento(codigoEntrenamiento)
);
GO

/* ===========================
   TABLA INSCRIPCIONES
   =========================== */
CREATE TABLE Inscripciones (
    codigoInscripcion INT PRIMARY KEY IDENTITY(1,1),
    codigoCliente INT NOT NULL,
    codigoEntrenamiento INT NOT NULL,
    fechaInscripcion DATETIME NOT NULL DEFAULT GETDATE(),
    estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigoCliente),
    FOREIGN KEY (codigoEntrenamiento) REFERENCES Entrenamiento(codigoEntrenamiento)
);
GO
