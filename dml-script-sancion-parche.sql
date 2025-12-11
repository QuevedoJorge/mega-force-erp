USE megaforce;
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA REGISTRAR UNA NUEVA SANCION
   ========================================================== */
IF OBJECT_ID('SP_RegistrarSancion', 'P') IS NOT NULL
    DROP PROCEDURE SP_RegistrarSancion;
GO

CREATE PROCEDURE SP_RegistrarSancion
    @fechaInicio DATE,
    @fechaFin DATE,
    @motivo VARCHAR(100),
    @codigoCliente INT,
    @estado BIT
AS
BEGIN
    INSERT INTO Sancion (fechaInicio, fechaFin, motivo, codigoCliente, estado)
    VALUES (@fechaInicio, @fechaFin, @motivo, @codigoCliente, @estado);
END
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR UNA SANCION
   ========================================================== */
IF OBJECT_ID('SP_ActualizarSancion', 'P') IS NOT NULL
    DROP PROCEDURE SP_ActualizarSancion;
GO

CREATE PROCEDURE SP_ActualizarSancion
    @codigo INT,
    @fechaInicio DATE,
    @fechaFin DATE,
    @motivo VARCHAR(100),
    @codigoCliente INT,
    @estado BIT
AS
BEGIN
    UPDATE Sancion
    SET
        fechaInicio = @fechaInicio,
        fechaFin = @fechaFin,
        motivo = @motivo,
        codigoCliente = @codigoCliente,
        estado = @estado
    WHERE
        codigo = @codigo;
END
GO

PRINT 'Procedimientos almacenados SP_RegistrarSancion y SP_ActualizarSancion creados exitosamente.';
GO
