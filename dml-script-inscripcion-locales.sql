USE megaforce
go

-- Mostrar activos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarLocales') 
DROP PROCEDURE SP_MostrarLocales;
GO
CREATE PROC SP_MostrarLocales
AS
BEGIN
    SELECT * FROM Locales WHERE estado = 1;
END
GO

EXEC SP_MostrarLocales;
GO

-- Mostrar todo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarLocalesTodo') 
DROP PROCEDURE SP_MostrarLocalesTodo;
GO
CREATE PROC SP_MostrarLocalesTodo
AS
BEGIN
    SELECT * FROM Locales;
END
GO

EXEC SP_MostrarLocalesTodo;
GO

-- Registrar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarLocales') 
DROP PROCEDURE SP_RegistrarLocales;
GO
CREATE PROC SP_RegistrarLocales
    @tipo VARCHAR(50),
    @direccion VARCHAR(100),
    @capacidadMaxima INT,
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_RegistrarLocales
    BEGIN TRY
        INSERT INTO Locales (tipo, direccion, capacidadMaxima, estado)
        VALUES (@tipo, @direccion, @capacidadMaxima, @estado);
        COMMIT TRAN SP_RegistrarLocales;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarLocales;
    END CATCH
END
GO

-- Buscar por código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarLocalesXCodigo') 
DROP PROCEDURE SP_BuscarLocalesXCodigo;
GO
CREATE PROC SP_BuscarLocalesXCodigo
    @codigoLocal INT
AS
BEGIN
    SELECT * FROM Locales WHERE codigoLocal = @codigoLocal;
END
GO

EXEC SP_BuscarLocalesXCodigo 1;
GO

-- Actualizar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarLocales') 
DROP PROCEDURE SP_ActualizarLocales;
GO
CREATE PROC SP_ActualizarLocales
    @codigoLocal INT,
    @tipo VARCHAR(50),
    @direccion VARCHAR(100),
    @capacidadMaxima INT,
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_ActualizarLocales
    BEGIN TRY
        UPDATE Locales
        SET tipo = @tipo,
            direccion = @direccion,
            capacidadMaxima = @capacidadMaxima,
            estado = @estado
        WHERE codigoLocal = @codigoLocal;
        COMMIT TRAN SP_ActualizarLocales;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarLocales;
    END CATCH
END
GO

-- Eliminar (cambiar estado a 0)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarLocales') 
DROP PROCEDURE SP_EliminarLocales;
GO
CREATE PROC SP_EliminarLocales
    @codigoLocal INT
AS
BEGIN
    BEGIN TRAN SP_EliminarLocales
    BEGIN TRY
        UPDATE Locales SET estado = 0 WHERE codigoLocal = @codigoLocal;
        COMMIT TRAN SP_EliminarLocales;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarLocales;
    END CATCH
END
GO

-- Habilitar (cambiar estado a 1)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarLocales') 
DROP PROCEDURE SP_HabilitarLocales;
GO
CREATE PROC SP_HabilitarLocales
    @codigoLocal INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarLocales
    BEGIN TRY
        UPDATE Locales SET estado = 1 WHERE codigoLocal = @codigoLocal;
        COMMIT TRAN SP_HabilitarLocales;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarLocales;
    END CATCH
END
GO

-- Siguiente código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoLocales') 
DROP PROCEDURE SP_CodigoLocales;
GO
CREATE PROC SP_CodigoLocales
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Locales)
    BEGIN
        SET @siguienteCodigo = 1;
    END
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Locales') + 1;
        DBCC CHECKIDENT ('Locales', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Locales') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO

EXEC SP_CodigoLocales;
GO

-- =============================================
-- STORED PROCEDURES PARA INSCRIPCIONES
-- =============================================

-- Mostrar todas las inscripciones
CREATE OR ALTER PROCEDURE SP_MostrarInscripciones
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        i.codigoCliente,
        c.nombre AS NombreCliente,
        i.codigoEntrenamiento,
        i.fechaInscripcion,
        i.estado
    FROM Inscripciones i
    INNER JOIN Cliente c ON i.codigoCliente = c.codigoCliente
    INNER JOIN Entrenamiento e ON i.codigoEntrenamiento = e.codigoEntrenamiento
    WHERE i.estado = 1
    ORDER BY i.fechaInscripcion DESC
END
GO

-- =============================================
-- STORED PROCEDURES PARA INSCRIPCIONES (CORREGIDOS)
-- =============================================

-- Mostrar todas las inscripciones
CREATE OR ALTER  PROCEDURE SP_MostrarInscripciones
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        i.codigoCliente,
        c.nombre AS NombreCliente,
        i.codigoEntrenamiento,
        e.tipo AS NombreEntrenamiento,
        i.fechaInscripcion,
        i.estado
    FROM Inscripciones i
    INNER JOIN Cliente c ON i.codigoCliente = c.codigoCliente
    INNER JOIN Entrenamiento e ON i.codigoEntrenamiento = e.codigoEntrenamiento
    WHERE i.estado = 1
    ORDER BY i.fechaInscripcion DESC
END
GO

-- Mostrar inscripciones por cliente
CREATE OR ALTER  PROCEDURE SP_MostrarInscripcionesPorCliente
    @codigoCliente INT
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        i.codigoCliente,
        c.nombre AS NombreCliente,
        i.codigoEntrenamiento,
        e.tipo AS NombreEntrenamiento,
        i.fechaInscripcion,
        i.estado
    FROM Inscripciones i
    INNER JOIN Cliente c ON i.codigoCliente = c.codigoCliente
    INNER JOIN Entrenamiento e ON i.codigoEntrenamiento = e.codigoEntrenamiento
    WHERE i.codigoCliente = @codigoCliente AND i.estado = 1
    ORDER BY i.fechaInscripcion DESC
END
GO

-- Registrar nueva inscripción
CREATE OR ALTER  PROCEDURE SP_RegistrarInscripcion
    @codigoCliente INT,
    @codigoEntrenamiento INT
AS
BEGIN
    -- Verificar si ya existe la inscripción
    IF NOT EXISTS (SELECT 1 FROM Inscripciones 
                   WHERE codigoCliente = @codigoCliente 
                   AND codigoEntrenamiento = @codigoEntrenamiento 
                   AND estado = 1)
    BEGIN
        INSERT INTO Inscripciones (codigoCliente, codigoEntrenamiento, fechaInscripcion, estado)
        VALUES (@codigoCliente, @codigoEntrenamiento, GETDATE(), 1)
        
        SELECT 'Inscripción registrada exitosamente' AS Mensaje
    END
    ELSE
    BEGIN
        SELECT 'El cliente ya está inscrito en este entrenamiento' AS Mensaje
    END
END
GO

-- Eliminar inscripción (cambiar estado)
CREATE OR ALTER  PROCEDURE SP_EliminarInscripcion
    @codigoInscripcion INT
AS
BEGIN
    UPDATE Inscripciones 
    SET estado = 0 
    WHERE codigoInscripcion = @codigoInscripcion
    
    SELECT 'Inscripción eliminada exitosamente' AS Mensaje
END
GO

-- Eliminar inscripción (cambiar estado)
CREATE OR ALTER  PROCEDURE SP_HabilitarInscripcion
    @codigoInscripcion INT
AS
BEGIN
    UPDATE Inscripciones 
    SET estado = 1 
    WHERE codigoInscripcion = @codigoInscripcion
    
    SELECT 'Inscripción eliminada exitosamente' AS Mensaje
END
GO
