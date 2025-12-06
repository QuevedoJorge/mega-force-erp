USE Smarfit;
GO

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

-- Mostrar activos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarTrainer') 
DROP PROCEDURE SP_MostrarTrainer;
GO
CREATE PROC SP_MostrarTrainer
AS
BEGIN
    SELECT * FROM Trainer WHERE disponibilidad = 1;
END
GO

EXEC SP_MostrarTrainer;
GO

-- Mostrar todo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarTrainerTodo') 
DROP PROCEDURE SP_MostrarTrainerTodo;
GO
CREATE PROC SP_MostrarTrainerTodo
AS
BEGIN
    SELECT * FROM Trainer;
END
GO

EXEC SP_MostrarTrainerTodo;
GO

-- Registrar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarTrainer') 
DROP PROCEDURE SP_RegistrarTrainer;
GO
CREATE PROC SP_RegistrarTrainer
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @especialidad VARCHAR(100),
    @disponibilidad BIT
AS
BEGIN
    BEGIN TRAN SP_RegistrarTrainer
    BEGIN TRY
        INSERT INTO Trainer (nombre, apellido, especialidad, disponibilidad)
        VALUES (@nombre, @apellido, @especialidad, @disponibilidad);
        COMMIT TRAN SP_RegistrarTrainer;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarTrainer;
    END CATCH
END
GO

-- Buscar por código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarTrainerXCodigo') 
DROP PROCEDURE SP_BuscarTrainerXCodigo;
GO
CREATE PROC SP_BuscarTrainerXCodigo
    @codigoTrainer INT
AS
BEGIN
    SELECT * FROM Trainer WHERE codigoTrainer = @codigoTrainer;
END
GO

EXEC SP_BuscarTrainerXCodigo 1;
GO

-- Actualizar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarTrainer') 
DROP PROCEDURE SP_ActualizarTrainer;
GO
CREATE PROC SP_ActualizarTrainer
    @codigoTrainer INT,
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @especialidad VARCHAR(100),
    @disponibilidad BIT
AS
BEGIN
    BEGIN TRAN SP_ActualizarTrainer
    BEGIN TRY
        UPDATE Trainer
        SET nombre = @nombre,
            apellido = @apellido,
            especialidad = @especialidad,
            disponibilidad = @disponibilidad
        WHERE codigoTrainer = @codigoTrainer;
        COMMIT TRAN SP_ActualizarTrainer;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarTrainer;
    END CATCH
END
GO

-- Eliminar (cambiar disponibilidad a 0)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarTrainer') 
DROP PROCEDURE SP_EliminarTrainer;
GO
CREATE PROC SP_EliminarTrainer
    @codigoTrainer INT
AS
BEGIN
    BEGIN TRAN SP_EliminarTrainer
    BEGIN TRY
        UPDATE Trainer SET disponibilidad = 0 WHERE codigoTrainer = @codigoTrainer;
        COMMIT TRAN SP_EliminarTrainer;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarTrainer;
    END CATCH
END
GO

-- Habilitar (cambiar disponibilidad a 1)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarTrainer') 
DROP PROCEDURE SP_HabilitarTrainer;
GO
CREATE PROC SP_HabilitarTrainer
    @codigoTrainer INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarTrainer
    BEGIN TRY
        UPDATE Trainer SET disponibilidad = 1 WHERE codigoTrainer = @codigoTrainer;
        COMMIT TRAN SP_HabilitarTrainer;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarTrainer;
    END CATCH
END
GO

-- Siguiente código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoTrainer') 
DROP PROCEDURE SP_CodigoTrainer;
GO
CREATE PROC SP_CodigoTrainer
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Trainer)
    BEGIN
        SET @siguienteCodigo = 1;
    END
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Trainer') + 1;
        DBCC CHECKIDENT ('Trainer', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Trainer') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO

EXEC SP_CodigoTrainer;
GO


-- Mostrar activos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarCliente') 
DROP PROCEDURE SP_MostrarCliente;
GO
CREATE PROC SP_MostrarCliente
AS
BEGIN
    SELECT * FROM Cliente WHERE estado = 1;
END
GO

EXEC SP_MostrarCliente;
GO

-- Mostrar todo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarClienteTodo') 
DROP PROCEDURE SP_MostrarClienteTodo;
GO
CREATE PROC SP_MostrarClienteTodo
AS
BEGIN
    SELECT * FROM Cliente;
END
GO

EXEC SP_MostrarClienteTodo;
GO

-- Registrar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarCliente') 
DROP PROCEDURE SP_RegistrarCliente;
GO
CREATE PROC SP_RegistrarCliente
    @nombre VARCHAR(100),
    @correo VARCHAR(100),
    @telefono VARCHAR(20),
    @direccion VARCHAR(100),
    @historialEntrenamientos VARCHAR(100),
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_RegistrarCliente
    BEGIN TRY
        INSERT INTO Cliente (nombre, correo, telefono, direccion, historialEntrenamientos, estado)
        VALUES (@nombre, @correo, @telefono, @direccion, @historialEntrenamientos, @estado);
        COMMIT TRAN SP_RegistrarCliente;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarCliente;
    END CATCH
END
GO

-- Buscar por código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarClienteXCodigo') 
DROP PROCEDURE SP_BuscarClienteXCodigo;
GO
CREATE PROC SP_BuscarClienteXCodigo
    @codigoCliente INT
AS
BEGIN
    SELECT * FROM Cliente WHERE codigoCliente = @codigoCliente;
END
GO

EXEC SP_BuscarClienteXCodigo 1;
GO

-- Actualizar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarCliente') 
DROP PROCEDURE SP_ActualizarCliente;
GO
CREATE PROC SP_ActualizarCliente
    @codigoCliente INT,
    @nombre VARCHAR(100),
    @correo VARCHAR(100),
    @telefono VARCHAR(20),
    @direccion VARCHAR(100),
    @historialEntrenamientos VARCHAR(100),
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_ActualizarCliente
    BEGIN TRY
        UPDATE Cliente
        SET nombre = @nombre,
            correo = @correo,
            telefono = @telefono,
            direccion = @direccion,
            historialEntrenamientos = @historialEntrenamientos,
            estado = @estado
        WHERE codigoCliente = @codigoCliente;
        COMMIT TRAN SP_ActualizarCliente;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarCliente;
    END CATCH
END
GO

-- Eliminar (cambiar estado a 0)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarCliente') 
DROP PROCEDURE SP_EliminarCliente;
GO
CREATE PROC SP_EliminarCliente
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_EliminarCliente
    BEGIN TRY
        UPDATE Cliente SET estado = 0 WHERE codigoCliente = @codigoCliente;
        COMMIT TRAN SP_EliminarCliente;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarCliente;
    END CATCH
END
GO

-- Habilitar (cambiar estado a 1)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarCliente') 
DROP PROCEDURE SP_HabilitarCliente;
GO
CREATE PROC SP_HabilitarCliente
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarCliente
    BEGIN TRY
        UPDATE Cliente SET estado = 1 WHERE codigoCliente = @codigoCliente;
        COMMIT TRAN SP_HabilitarCliente;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarCliente;
    END CATCH
END
GO

-- Siguiente código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoCliente') 
DROP PROCEDURE SP_CodigoCliente;
GO
CREATE PROC SP_CodigoCliente
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Cliente)
    BEGIN
        SET @siguienteCodigo = 1;
    END
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Cliente') + 1;
        DBCC CHECKIDENT ('Cliente', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Cliente') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO

EXEC SP_CodigoCliente;
GO

-- Mostrar Entrenamientos activos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarEntrenamiento') 
DROP PROCEDURE SP_MostrarEntrenamiento;
GO
CREATE PROC SP_MostrarEntrenamiento
AS
BEGIN
    SELECT 
        e.codigoEntrenamiento, e.tipo, e.fechaHora, e.duracion,
        e.ubicacion, e.capacidadMaxima, e.estado,
        t.codigoTrainer, t.nombre AS nombreTrainer, t.apellido,
        l.codigoLocal, l.tipo AS tipoLocal, l.direccion
    FROM Entrenamiento e
    INNER JOIN Trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN Locales l ON e.codigoLocal = l.codigoLocal
    WHERE e.estado = 1;
END
GO

EXEC SP_MostrarEntrenamiento;
GO


-- Mostrar Todos los Entrenamientos (sin importar estado)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarEntrenamientoTodo') 
DROP PROCEDURE SP_MostrarEntrenamientoTodo;
GO
CREATE PROC SP_MostrarEntrenamientoTodo
AS
BEGIN
    SELECT 
        e.codigoEntrenamiento, e.tipo, e.fechaHora, e.duracion,
        e.ubicacion, e.capacidadMaxima, e.estado,
        t.codigoTrainer, t.nombre AS nombreTrainer, t.apellido,
        l.codigoLocal, l.tipo AS tipoLocal, l.direccion
    FROM Entrenamiento e
    INNER JOIN Trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN Locales l ON e.codigoLocal = l.codigoLocal;
END
GO

EXEC SP_MostrarEntrenamientoTodo;
GO

-- Buscar Entrenamiento por Código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarEntrenamientoXCodigo') 
DROP PROCEDURE SP_BuscarEntrenamientoXCodigo;
GO
CREATE PROC SP_BuscarEntrenamientoXCodigo
    @codigo INT
AS
BEGIN
    SELECT 
        e.codigoEntrenamiento, e.tipo, e.fechaHora, e.duracion,
        e.ubicacion, e.capacidadMaxima, e.estado,
        t.codigoTrainer, t.nombre AS nombreTrainer, t.apellido,
        l.codigoLocal, l.tipo AS tipoLocal, l.direccion
    FROM Entrenamiento e
    INNER JOIN Trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN Locales l ON e.codigoLocal = l.codigoLocal
    WHERE e.codigoEntrenamiento = @codigo;
END
GO

EXEC SP_BuscarEntrenamientoXCodigo 1;
GO

-- Registrar Entrenamiento
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarEntrenamiento') 
DROP PROCEDURE SP_RegistrarEntrenamiento;
GO
CREATE PROC SP_RegistrarEntrenamiento
    @tipo VARCHAR(50),
    @fechaHora DATETIME,
    @duracion DECIMAL(5,2),
    @ubicacion VARCHAR(50),
    @capacidadMaxima INT,
    @estado BIT,
    @codigoTrainer INT,
    @codigoLocal INT
AS
BEGIN
    BEGIN TRAN SP_RegistrarEntrenamiento
    BEGIN TRY
        INSERT INTO Entrenamiento 
        (tipo, fechaHora, duracion, ubicacion, capacidadMaxima, estado, codigoTrainer, codigoLocal)
        VALUES 
        (@tipo, @fechaHora, @duracion, @ubicacion, @capacidadMaxima, @estado, @codigoTrainer, @codigoLocal);
        COMMIT TRAN SP_RegistrarEntrenamiento;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarEntrenamiento;
    END CATCH
END
GO

-- Actualizar Entrenamiento
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarEntrenamiento') 
DROP PROCEDURE SP_ActualizarEntrenamiento;
GO
CREATE PROC SP_ActualizarEntrenamiento
    @codigo INT,
    @tipo VARCHAR(50),
    @fechaHora DATETIME,
    @duracion DECIMAL(5,2),
    @ubicacion VARCHAR(50),
    @capacidadMaxima INT,
    @estado BIT,
    @codigoTrainer INT,
    @codigoLocal INT
AS
BEGIN
    BEGIN TRAN SP_ActualizarEntrenamiento
    BEGIN TRY
        UPDATE Entrenamiento
        SET tipo = @tipo,
            fechaHora = @fechaHora,
            duracion = @duracion,
            ubicacion = @ubicacion,
            capacidadMaxima = @capacidadMaxima,
            estado = @estado,
            codigoTrainer = @codigoTrainer,
            codigoLocal = @codigoLocal
        WHERE codigoEntrenamiento = @codigo;
        COMMIT TRAN SP_ActualizarEntrenamiento;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarEntrenamiento;
    END CATCH
END
GO

-- Eliminar Entrenamiento (lógico - estado = 0)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarEntrenamiento') 
DROP PROCEDURE SP_EliminarEntrenamiento;
GO
CREATE PROC SP_EliminarEntrenamiento
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_EliminarEntrenamiento
    BEGIN TRY
        UPDATE Entrenamiento SET estado = 0 WHERE codigoEntrenamiento = @codigo;
        COMMIT TRAN SP_EliminarEntrenamiento;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarEntrenamiento;
    END CATCH
END
GO

-- Habilitar Entrenamiento (estado = 1)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarEntrenamiento') 
DROP PROCEDURE SP_HabilitarEntrenamiento;
GO
CREATE PROC SP_HabilitarEntrenamiento
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarEntrenamiento
    BEGIN TRY
        UPDATE Entrenamiento SET estado = 1 WHERE codigoEntrenamiento = @codigo;
        COMMIT TRAN SP_HabilitarEntrenamiento;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarEntrenamiento;
    END CATCH
END
GO

-- Siguiente Código Entrenamiento
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoEntrenamiento') 
DROP PROCEDURE SP_CodigoEntrenamiento;
GO
CREATE PROC SP_CodigoEntrenamiento
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Entrenamiento)
        SET @siguienteCodigo = 1;
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Entrenamiento') + 1;
        DBCC CHECKIDENT ('Entrenamiento', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Entrenamiento') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO

EXEC SP_CodigoEntrenamiento;
GO

-- Mostrar Sanciones activas
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarSancion') 
DROP PROCEDURE SP_MostrarSancion;
GO
CREATE PROC SP_MostrarSancion
AS
BEGIN
    SELECT 
        s.codigo, s.fechaInicio, s.fechaFin, s.motivo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente
    WHERE c.estado = 1;
END
GO
EXEC SP_MostrarSancion;
GO

-- Mostrar todas las sanciones
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarSancionTodo') 
DROP PROCEDURE SP_MostrarSancionTodo;
GO
CREATE PROC SP_MostrarSancionTodo
AS
BEGIN
    SELECT 
        s.codigo, s.fechaInicio, s.fechaFin, s.motivo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente;
END
GO
EXEC SP_MostrarSancionTodo;
GO

-- Buscar por código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarSancionXCodigo') 
DROP PROCEDURE SP_BuscarSancionXCodigo;
GO
CREATE PROC SP_BuscarSancionXCodigo
    @codigo INT
AS
BEGIN
    SELECT 
        s.codigo, s.fechaInicio, s.fechaFin, s.motivo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente
    WHERE s.codigo = @codigo;
END
GO
EXEC SP_BuscarSancionXCodigo 1;
GO

-- Registrar sanción
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarSancion') 
DROP PROCEDURE SP_RegistrarSancion;
GO
CREATE PROC SP_RegistrarSancion
    @fechaInicio DATE,
    @fechaFin DATE,
    @motivo VARCHAR(100),
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_RegistrarSancion
    BEGIN TRY
        INSERT INTO Sancion(fechaInicio, fechaFin, motivo, codigoCliente)
        VALUES (@fechaInicio, @fechaFin, @motivo, @codigoCliente);
        COMMIT TRAN SP_RegistrarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarSancion;
    END CATCH
END
GO

-- Actualizar sanción
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarSancion') 
DROP PROCEDURE SP_ActualizarSancion;
GO
CREATE PROC SP_ActualizarSancion
    @codigo INT,
    @fechaInicio DATE,
    @fechaFin DATE,
    @motivo VARCHAR(100),
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_ActualizarSancion
    BEGIN TRY
        UPDATE Sancion
        SET fechaInicio = @fechaInicio,
            fechaFin = @fechaFin,
            motivo = @motivo,
            codigoCliente = @codigoCliente
        WHERE codigo = @codigo;
        COMMIT TRAN SP_ActualizarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarSancion;
    END CATCH
END
GO

-- Eliminar (lógico): no hay estado, así que opción puede ser eliminar físicamente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarSancion') 
DROP PROCEDURE SP_EliminarSancion;
GO
CREATE PROC SP_EliminarSancion
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_EliminarSancion
    BEGIN TRY
        DELETE FROM Sancion WHERE codigo = @codigo;
        COMMIT TRAN SP_EliminarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarSancion;
    END CATCH
END
GO

-- Siguiente código sanción
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoSancion') 
DROP PROCEDURE SP_CodigoSancion;
GO
CREATE PROC SP_CodigoSancion
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Sancion)
        SET @siguienteCodigo = 1;
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Sancion') + 1;
        DBCC CHECKIDENT('Sancion', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Sancion') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO
EXEC SP_CodigoSancion;
GO

-- Mostrar reclamos activos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarReclamo') 
DROP PROCEDURE SP_MostrarReclamo;
GO
CREATE PROC SP_MostrarReclamo
AS
BEGIN
    SELECT 
        r.codigo, r.descripcion, r.fecha, r.estado AS estadoReclamo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Reclamo r
    INNER JOIN Cliente c ON r.codigoCliente = c.codigoCliente
    WHERE r.estado = 1;
END
GO
EXEC SP_MostrarReclamo;
GO

-- Mostrar todos los reclamos
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarReclamoTodo') 
DROP PROCEDURE SP_MostrarReclamoTodo;
GO
CREATE PROC SP_MostrarReclamoTodo
AS
BEGIN
    SELECT 
        r.codigo, r.descripcion, r.fecha, r.estado AS estadoReclamo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Reclamo r
    INNER JOIN Cliente c ON r.codigoCliente = c.codigoCliente;
END
GO
EXEC SP_MostrarReclamoTodo;
GO

-- Buscar reclamo por código
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarReclamoXCodigo') 
DROP PROCEDURE SP_BuscarReclamoXCodigo;
GO
CREATE PROC SP_BuscarReclamoXCodigo
    @codigo INT
AS
BEGIN
    SELECT 
        r.codigo, r.descripcion, r.fecha, r.estado AS estadoReclamo,
        c.codigoCliente, c.nombre, c.correo, c.estado AS estadoCliente
    FROM Reclamo r
    INNER JOIN Cliente c ON r.codigoCliente = c.codigoCliente
    WHERE r.codigo = @codigo;
END
GO
EXEC SP_BuscarReclamoXCodigo 1;
GO

-- Registrar reclamo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarReclamo') 
DROP PROCEDURE SP_RegistrarReclamo;
GO
CREATE PROC SP_RegistrarReclamo
    @descripcion VARCHAR(100),
    @fecha DATE,
    @estado BIT,
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_RegistrarReclamo
    BEGIN TRY
        INSERT INTO Reclamo(descripcion, fecha, estado, codigoCliente)
        VALUES (@descripcion, @fecha, @estado, @codigoCliente);
        COMMIT TRAN SP_RegistrarReclamo;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarReclamo;
    END CATCH
END
GO

-- Actualizar reclamo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarReclamo') 
DROP PROCEDURE SP_ActualizarReclamo;
GO
CREATE PROC SP_ActualizarReclamo
    @codigo INT,
    @descripcion VARCHAR(100),
    @fecha DATE,
    @estado BIT,
    @codigoCliente INT
AS
BEGIN
    BEGIN TRAN SP_ActualizarReclamo
    BEGIN TRY
        UPDATE Reclamo
        SET descripcion = @descripcion,
            fecha = @fecha,
            estado = @estado,
            codigoCliente = @codigoCliente
        WHERE codigo = @codigo;
        COMMIT TRAN SP_ActualizarReclamo;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarReclamo;
    END CATCH
END
GO

-- Eliminar reclamo (lógico)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarReclamo') 
DROP PROCEDURE SP_EliminarReclamo;
GO
CREATE PROC SP_EliminarReclamo
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_EliminarReclamo
    BEGIN TRY
        UPDATE Reclamo SET estado = 0 WHERE codigo = @codigo;
        COMMIT TRAN SP_EliminarReclamo;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarReclamo;
    END CATCH
END
GO

-- Habilitar reclamo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarReclamo') 
DROP PROCEDURE SP_HabilitarReclamo;
GO
CREATE PROC SP_HabilitarReclamo
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarReclamo
    BEGIN TRY
        UPDATE Reclamo SET estado = 1 WHERE codigo = @codigo;
        COMMIT TRAN SP_HabilitarReclamo;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarReclamo;
    END CATCH
END
GO

-- Siguiente código reclamo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_CodigoReclamo') 
DROP PROCEDURE SP_CodigoReclamo;
GO
CREATE PROC SP_CodigoReclamo
AS
BEGIN
    DECLARE @siguienteCodigo INT;
    DECLARE @valorActual INT;

    IF NOT EXISTS (SELECT 1 FROM Reclamo)
        SET @siguienteCodigo = 1;
    ELSE
    BEGIN
        SELECT @siguienteCodigo = IDENT_CURRENT('Reclamo') + 1;
        DBCC CHECKIDENT('Reclamo', NORESEED) WITH NO_INFOMSGS;
        SELECT @valorActual = IDENT_CURRENT('Reclamo') + 1;
        IF @valorActual > @siguienteCodigo
            SET @siguienteCodigo = @valorActual;
    END

    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO
EXEC SP_CodigoReclamo;
GO

USE Smarfit;
GO

-- Mostrar pedidos activos
CREATE OR ALTER PROC SP_MostrarPedido
AS
BEGIN
    SELECT * FROM Pedido WHERE estado = 1;
END
GO

-- Mostrar todos los pedidos
CREATE OR ALTER PROC SP_MostrarPedidoTodo
AS
BEGIN
    SELECT * FROM Pedido;
END
GO

-- Registrar pedido
CREATE OR ALTER PROC SP_RegistrarPedido
    @codigoCliente INT,
    @total         DECIMAL(10,2),
    @estado        BIT
AS
BEGIN
    INSERT INTO Pedido (codigoCliente, total, estado)
    VALUES (@codigoCliente, @total, @estado);
END
GO

-- Buscar pedido por código
CREATE OR ALTER PROC SP_BuscarPedidoXCodigo
    @codigoPedido INT
AS
BEGIN
    SELECT * 
      FROM Pedido 
     WHERE codigoPedido = @codigoPedido;
END
GO

-- Actualizar pedido
CREATE OR ALTER PROC SP_ActualizarPedido
    @codigoPedido  INT,
    @codigoCliente INT,
    @total         DECIMAL(10,2),
    @estado        BIT
AS
BEGIN
    UPDATE Pedido
       SET codigoCliente = @codigoCliente,
           total         = @total,
           estado        = @estado
     WHERE codigoPedido = @codigoPedido;
END
GO

-- Eliminar (lógico)
CREATE OR ALTER PROC SP_EliminarPedido
    @codigoPedido INT
AS
BEGIN
    UPDATE Pedido
       SET estado = 0
     WHERE codigoPedido = @codigoPedido;
END
GO

-- Habilitar nuevamente
CREATE OR ALTER PROC SP_HabilitarPedido
    @codigoPedido INT
AS
BEGIN
    UPDATE Pedido
       SET estado = 1
     WHERE codigoPedido = @codigoPedido;
END
GO

-- Obtener siguiente código
CREATE OR ALTER PROC SP_CodigoPedido
AS
BEGIN
    DECLARE @siguiente INT;
    SELECT @siguiente = IDENT_CURRENT('Pedido') + 1;
    SELECT @siguiente AS SiguienteCodigo;
END
GO

USE Smarfit;
GO

-- Mostrar detalles activos
CREATE OR ALTER PROC SP_MostrarDetallePedido
AS
BEGIN
    SELECT * FROM DetallePedido WHERE estado = 1;
END
GO

-- Mostrar todos los detalles
CREATE OR ALTER PROC SP_MostrarDetallePedidoTodo
AS
BEGIN
    SELECT * FROM DetallePedido;
END
GO

-- Registrar detalle de pedido
CREATE OR ALTER PROC SP_RegistrarDetallePedido
    @codigoPedido        INT,
    @codigoEntrenamiento INT,
    @cantidad            INT,
    @precioUnitario      DECIMAL(10,2),
    @estado              BIT
AS
BEGIN
    INSERT INTO DetallePedido
    (codigoPedido, codigoEntrenamiento, cantidad, precioUnitario, estado)
    VALUES
    (@codigoPedido, @codigoEntrenamiento, @cantidad, @precioUnitario, @estado);
END
GO

-- Buscar detalle por código
CREATE OR ALTER PROC SP_BuscarDetallePedidoXCodigo
    @codigoDetallePedido INT
AS
BEGIN
    SELECT *
      FROM DetallePedido
     WHERE codigoDetallePedido = @codigoDetallePedido;
END
GO

-- Actualizar detalle
CREATE OR ALTER PROC SP_ActualizarDetallePedido
    @codigoDetallePedido INT,
    @cantidad            INT,
    @precioUnitario      DECIMAL(10,2),
    @estado              BIT
AS
BEGIN
    UPDATE DetallePedido
       SET cantidad       = @cantidad,
           precioUnitario = @precioUnitario,
           estado         = @estado
     WHERE codigoDetallePedido = @codigoDetallePedido;
END
GO

-- Eliminar (lógico)
CREATE OR ALTER PROC SP_EliminarDetallePedido
    @codigoDetallePedido INT
AS
BEGIN
    UPDATE DetallePedido
       SET estado = 0
     WHERE codigoDetallePedido = @codigoDetallePedido;
END
GO

-- Habilitar nuevamente
CREATE OR ALTER PROC SP_HabilitarDetallePedido
    @codigoDetallePedido INT
AS
BEGIN
    UPDATE DetallePedido
       SET estado = 1
     WHERE codigoDetallePedido = @codigoDetallePedido;
END
GO

-- Obtener siguiente código
CREATE OR ALTER PROC SP_CodigoDetallePedido
AS
BEGIN
    DECLARE @siguiente INT;
    SELECT @siguiente = IDENT_CURRENT('DetallePedido') + 1;
    SELECT @siguiente AS SiguienteCodigo;
END
GO


-- =============================================
-- STORED PROCEDURES PARA INSCRIPCIONES
-- =============================================

-- Mostrar todas las inscripciones
CREATE PROCEDURE SP_MostrarInscripciones
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        i.codigoCliente,
        c.nombre + ' ' + c.apellido AS NombreCliente,
        i.codigoEntrenamiento,
        e.nombre AS NombreEntrenamiento,
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
CREATE PROCEDURE SP_MostrarInscripciones
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
CREATE PROCEDURE SP_MostrarInscripcionesPorCliente
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
CREATE PROCEDURE SP_RegistrarInscripcion
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
CREATE PROCEDURE SP_EliminarInscripcion
    @codigoInscripcion INT
AS
BEGIN
    UPDATE Inscripciones 
    SET estado = 0 
    WHERE codigoInscripcion = @codigoInscripcion
    
    SELECT 'Inscripción eliminada exitosamente' AS Mensaje
END
GO
