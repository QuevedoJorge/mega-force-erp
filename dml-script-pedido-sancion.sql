USE Smarfit;
GO

-- =============================================
-- PROCEDIMIENTOS PARA LA TABLA SANCION
-- =============================================

-- Mostrar Sanciones activas con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarSancion') 
DROP PROCEDURE SP_MostrarSancion;
GO
CREATE PROC SP_MostrarSancion
AS
BEGIN
    SELECT 
        s.codigo, 
        s.fechaInicio, 
        s.fechaFin, 
        s.motivo,
        s.estado,
        c.codigoCliente, 
        c.nombre as nombreCliente, 
        c.correo as correoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente
    WHERE s.estado = 1;
END
GO

-- Mostrar todas las sanciones con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarSancionTodo') 
DROP PROCEDURE SP_MostrarSancionTodo;
GO
CREATE PROC SP_MostrarSancionTodo
AS
BEGIN
    SELECT 
        s.codigo, 
        s.fechaInicio, 
        s.fechaFin, 
        s.motivo,
        s.estado,
        c.codigoCliente, 
        c.nombre as nombreCliente, 
        c.correo as correoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente;
END
GO

-- Buscar sanción por código con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarSancionXCodigo') 
DROP PROCEDURE SP_BuscarSancionXCodigo;
GO
CREATE PROC SP_BuscarSancionXCodigo
    @codigo INT
AS
BEGIN
    SELECT 
        s.codigo, 
        s.fechaInicio, 
        s.fechaFin, 
        s.motivo,
        s.estado,
        c.codigoCliente, 
        c.nombre as nombreCliente, 
        c.correo as correoCliente
    FROM Sancion s
    INNER JOIN Cliente c ON s.codigoCliente = c.codigoCliente
    WHERE s.codigo = @codigo;
END
GO

-- Registrar sanción
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarSancion') 
DROP PROCEDURE SP_RegistrarSancion;
GO
CREATE PROC SP_RegistrarSancion
    @fechaInicio DATE,
    @fechaFin DATE,
    @motivo VARCHAR(100),
    @codigoCliente INT,
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_RegistrarSancion
    BEGIN TRY
        INSERT INTO Sancion(fechaInicio, fechaFin, motivo, codigoCliente, estado)
        VALUES (@fechaInicio, @fechaFin, @motivo, @codigoCliente, @estado);
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
    @codigoCliente INT,
    @estado BIT
AS
BEGIN
    BEGIN TRAN SP_ActualizarSancion
    BEGIN TRY
        UPDATE Sancion
        SET fechaInicio = @fechaInicio,
            fechaFin = @fechaFin,
            motivo = @motivo,
            codigoCliente = @codigoCliente,
            estado = @estado
        WHERE codigo = @codigo;
        COMMIT TRAN SP_ActualizarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarSancion;
    END CATCH
END
GO

-- Eliminar (lógico)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarSancion') 
DROP PROCEDURE SP_EliminarSancion;
GO
CREATE PROC SP_EliminarSancion
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_EliminarSancion
    BEGIN TRY
        UPDATE Sancion SET estado = 0 WHERE codigo = @codigo;
        COMMIT TRAN SP_EliminarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_EliminarSancion;
    END CATCH
END
GO

-- Habilitar (lógico)
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarSancion') 
DROP PROCEDURE SP_HabilitarSancion;
GO
CREATE PROC SP_HabilitarSancion
    @codigo INT
AS
BEGIN
    BEGIN TRAN SP_HabilitarSancion
    BEGIN TRY
        UPDATE Sancion SET estado = 1 WHERE codigo = @codigo;
        COMMIT TRAN SP_HabilitarSancion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_HabilitarSancion;
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
    SELECT @siguienteCodigo = ISNULL(MAX(codigo), 0) + 1 FROM Sancion;
    SELECT @siguienteCodigo AS SiguienteCodigo;
END
GO

-- =============================================
-- PROCEDIMIENTOS PARA LA TABLA PEDIDO
-- =============================================

-- Mostrar pedidos activos con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarPedido') 
DROP PROCEDURE SP_MostrarPedido;
GO
CREATE OR ALTER PROC SP_MostrarPedido
AS
BEGIN
    SELECT 
        p.codigoPedido,
        p.fechaPedido,
        p.total,
        p.estado,
        c.codigoCliente,
        c.nombre AS nombreCliente,
        c.correo AS correoCliente
    FROM Pedido p
    INNER JOIN Cliente c ON p.codigoCliente = c.codigoCliente
    WHERE p.estado = 1;
END
GO

-- Mostrar todos los pedidos con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarPedidoTodo') 
DROP PROCEDURE SP_MostrarPedidoTodo;
GO
CREATE OR ALTER PROC SP_MostrarPedidoTodo
AS
BEGIN
    SELECT 
        p.codigoPedido,
        p.fechaPedido,
        p.total,
        p.estado,
        c.codigoCliente,
        c.nombre AS nombreCliente,
        c.correo AS correoCliente
    FROM Pedido p
    INNER JOIN Cliente c ON p.codigoCliente = c.codigoCliente;
END
GO

-- Buscar pedido por código con datos del cliente
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_BuscarPedidoXCodigo') 
DROP PROCEDURE SP_BuscarPedidoXCodigo;
GO
CREATE OR ALTER PROC SP_BuscarPedidoXCodigo
    @codigoPedido INT
AS
BEGIN
    SELECT 
        p.codigoPedido,
        p.fechaPedido,
        p.total,
        p.estado,
        c.codigoCliente,
        c.nombre AS nombreCliente,
        c.correo AS correoCliente
    FROM Pedido p
    INNER JOIN Cliente c ON p.codigoCliente = c.codigoCliente
    WHERE p.codigoPedido = @codigoPedido;
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
    SELECT @siguiente = ISNULL(MAX(codigoPedido), 0) + 1 FROM Pedido;
    SELECT @siguiente AS SiguienteCodigo;
END
GO
