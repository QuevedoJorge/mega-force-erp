USE megaforce;

--------------------
-- Detalle pedido --
--------------------
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarDetallePedido'
    ) DROP PROCEDURE SP_MostrarDetallePedido;

GO
    -- Muestra los detalles de pedido activos
    CREATE PROC SP_MostrarDetallePedido AS BEGIN
SELECT
    *
FROM
    DetallePedido
WHERE
    estado = 1;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarDetallePedidoTodo'
    ) DROP PROCEDURE SP_MostrarDetallePedidoTodo;

GO
    -- Muestra todos los detalles de pedido
    CREATE PROC SP_MostrarDetallePedidoTodo AS BEGIN
SELECT
    *
FROM
    DetallePedido;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_BuscarDetallePedidoXCodigo'
    ) DROP PROCEDURE SP_BuscarDetallePedidoXCodigo;

GO
    -- Busca un detalle de pedido por código
    CREATE PROC SP_BuscarDetallePedidoXCodigo @codigoDetallePedido INT AS BEGIN
SELECT
    *
FROM
    DetallePedido
WHERE
    codigoDetallePedido = @codigoDetallePedido;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_RegistrarDetallePedido'
    ) DROP PROCEDURE SP_RegistrarDetallePedido;

GO
    -- Registra un nuevo detalle de pedido
    CREATE PROC SP_RegistrarDetallePedido @codigoPedido VARCHAR(MAX),
    @codigoEntrenamiento VARCHAR(MAX),
    @cantidad VARCHAR(MAX),
    @precioUnitario VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_RegistrarDetallePedido BEGIN TRY
INSERT INTO
    DetallePedido(
        codigoPedido,
        codigoEntrenamiento,
        cantidad,
        precioUnitario,
        estado
    )
VALUES
    (
        @codigoPedido,
        @codigoEntrenamiento,
        @cantidad,
        @precioUnitario,
        @estado
    );

COMMIT TRAN SP_RegistrarDetallePedido;

END TRY BEGIN CATCH ROLLBACK TRAN SP_RegistrarDetallePedido;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_ActualizarDetallePedido'
    ) DROP PROCEDURE SP_ActualizarDetallePedido;

GO
    -- Actualiza un detalle de pedido
    CREATE PROC SP_ActualizarDetallePedido @codigoDetallePedido INT,
    @codigoPedido VARCHAR(MAX),
    @codigoEntrenamiento VARCHAR(MAX),
    @cantidad VARCHAR(MAX),
    @precioUnitario VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_ActualizarDetallePedido BEGIN TRY
UPDATE
    DetallePedido
SET
    codigoPedido = @codigoPedido,
    codigoEntrenamiento = @codigoEntrenamiento,
    cantidad = @cantidad,
    precioUnitario = @precioUnitario,
    estado = @estado
WHERE
    codigoDetallePedido = @codigoDetallePedido;

COMMIT TRAN SP_ActualizarDetallePedido;

END TRY BEGIN CATCH ROLLBACK TRAN SP_ActualizarDetallePedido;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_EliminarDetallePedido'
    ) DROP PROCEDURE SP_EliminarDetallePedido;

GO
    -- Elimina lógicamente un detalle de pedido
    CREATE PROC SP_EliminarDetallePedido @codigoDetallePedido INT AS BEGIN BEGIN TRAN SP_EliminarDetallePedido BEGIN TRY
UPDATE
    DetallePedido
SET
    estado = 0
WHERE
    codigoDetallePedido = @codigoDetallePedido;

COMMIT TRAN SP_EliminarDetallePedido;

END TRY BEGIN CATCH ROLLBACK TRAN SP_EliminarDetallePedido;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_HabilitarDetallePedido'
    ) DROP PROCEDURE SP_HabilitarDetallePedido;

GO
    -- Habilita un detalle de pedido
    CREATE PROC SP_HabilitarDetallePedido @codigoDetallePedido INT AS BEGIN BEGIN TRAN SP_HabilitarDetallePedido BEGIN TRY
UPDATE
    DetallePedido
SET
    estado = 1
WHERE
    codigoDetallePedido = @codigoDetallePedido;

COMMIT TRAN SP_HabilitarDetallePedido;

END TRY BEGIN CATCH ROLLBACK TRAN SP_HabilitarDetallePedido;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_CodigoDetallePedido'
    ) DROP PROCEDURE SP_CodigoDetallePedido;

GO
    -- Obtiene el siguiente código de detalle de pedido
    CREATE PROC SP_CodigoDetallePedido AS BEGIN DECLARE @codigo INT;

SELECT
    @codigo = ISNULL(MAX(codigoDetallePedido), 0) + 1
FROM
    DetallePedido;

SELECT
    @codigo AS SiguienteCodigo;

END
GO


--------------------
-- Metodo de pago --
--------------------

    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarMetodoPago'
    ) DROP PROCEDURE SP_MostrarMetodoPago;

GO
    -- Muestra los métodos de pago activos
    CREATE PROC SP_MostrarMetodoPago AS BEGIN
SELECT
    *
FROM
    MetodoPago
WHERE
    estado = 1;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarMetodoPagoTodo'
    ) DROP PROCEDURE SP_MostrarMetodoPagoTodo;

GO
    -- Muestra todos los métodos de pago
    CREATE PROC SP_MostrarMetodoPagoTodo AS BEGIN
SELECT
    *
FROM
    MetodoPago;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_BuscarMetodoPagoXCodigo'
    ) DROP PROCEDURE SP_BuscarMetodoPagoXCodigo;

GO
    -- Busca un método de pago por código
    CREATE PROC SP_BuscarMetodoPagoXCodigo @idMetodoPago INT AS BEGIN
SELECT
    *
FROM
    MetodoPago
WHERE
    idMetodoPago = @idMetodoPago;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_RegistrarMetodoPago'
    ) DROP PROCEDURE SP_RegistrarMetodoPago;

GO
    -- Registra un nuevo método de pago
    CREATE PROC SP_RegistrarMetodoPago @nombre VARCHAR(MAX),
    @descripcion VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_RegistrarMetodoPago BEGIN TRY
INSERT INTO
    MetodoPago(nombre, descripcion, estado)
VALUES
    (@nombre, @descripcion, @estado);

COMMIT TRAN SP_RegistrarMetodoPago;

END TRY BEGIN CATCH ROLLBACK TRAN SP_RegistrarMetodoPago;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_ActualizarMetodoPago'
    ) DROP PROCEDURE SP_ActualizarMetodoPago;

GO
    -- Actualiza un método de pago
    CREATE PROC SP_ActualizarMetodoPago @idMetodoPago INT,
    @nombre VARCHAR(MAX),
    @descripcion VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_ActualizarMetodoPago BEGIN TRY
UPDATE
    MetodoPago
SET
    nombre = @nombre,
    descripcion = @descripcion,
    estado = @estado
WHERE
    idMetodoPago = @idMetodoPago;

COMMIT TRAN SP_ActualizarMetodoPago;

END TRY BEGIN CATCH ROLLBACK TRAN SP_ActualizarMetodoPago;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_EliminarMetodoPago'
    ) DROP PROCEDURE SP_EliminarMetodoPago;

GO
    -- Elimina lógicamente un método de pago
    CREATE PROC SP_EliminarMetodoPago @idMetodoPago INT AS BEGIN BEGIN TRAN SP_EliminarMetodoPago BEGIN TRY
UPDATE
    MetodoPago
SET
    estado = 0
WHERE
    idMetodoPago = @idMetodoPago;

COMMIT TRAN SP_EliminarMetodoPago;

END TRY BEGIN CATCH ROLLBACK TRAN SP_EliminarMetodoPago;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_HabilitarMetodoPago'
    ) DROP PROCEDURE SP_HabilitarMetodoPago;

GO
    -- Habilita un método de pago
    CREATE PROC SP_HabilitarMetodoPago @idMetodoPago INT AS BEGIN BEGIN TRAN SP_HabilitarMetodoPago BEGIN TRY
UPDATE
    MetodoPago
SET
    estado = 1
WHERE
    idMetodoPago = @idMetodoPago;

COMMIT TRAN SP_HabilitarMetodoPago;

END TRY BEGIN CATCH ROLLBACK TRAN SP_HabilitarMetodoPago;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_CodigoMetodoPago'
    ) DROP PROCEDURE SP_CodigoMetodoPago;

GO
    -- Obtiene el siguiente código de método de pago
    CREATE PROC SP_CodigoMetodoPago AS BEGIN DECLARE @codigo INT;

SELECT
    @codigo = ISNULL(MAX(idMetodoPago), 0) + 1
FROM
    MetodoPago;

SELECT
    @codigo AS SiguienteCodigo;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarPedido'
    ) DROP PROCEDURE SP_MostrarPedido;

GO