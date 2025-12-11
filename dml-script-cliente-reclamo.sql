use megaforce
go

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


-------------
-- Reclamo --
-------------

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