USE megaforce;
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA REGISTRAR UN NUEVO PEDIDO
   ========================================================== */
IF OBJECT_ID('SP_RegistrarPedido', 'P') IS NOT NULL
    DROP PROCEDURE SP_RegistrarPedido;
GO

CREATE PROCEDURE SP_RegistrarPedido
    @codigoCliente INT,
    @idMetodoPago INT,
    @fechaPedido DATETIME,
    @total DECIMAL(10,2),
    @estado BIT
AS
BEGIN
    INSERT INTO Pedido (codigoCliente, idMetodoPago, fechaPedido, total, estado)
    VALUES (@codigoCliente, @idMetodoPago, @fechaPedido, @total, @estado);
END
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR UN PEDIDO
   ========================================================== */
IF OBJECT_ID('SP_ActualizarPedido', 'P') IS NOT NULL
    DROP PROCEDURE SP_ActualizarPedido;
GO

CREATE PROCEDURE SP_ActualizarPedido
    @codigoPedido INT,
    @codigoCliente INT,
    @idMetodoPago INT,
    @fechaPedido DATETIME,
    @total DECIMAL(10,2),
    @estado BIT
AS
BEGIN
    UPDATE Pedido
    SET
        codigoCliente = @codigoCliente,
        idMetodoPago = @idMetodoPago,
        fechaPedido = @fechaPedido,
        total = @total,
        estado = @estado
    WHERE
        codigoPedido = @codigoPedido;
END
GO

PRINT 'Procedimientos almacenados SP_RegistrarPedido y SP_ActualizarPedido creados exitosamente.';
GO
