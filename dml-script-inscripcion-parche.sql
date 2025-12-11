USE megaforce;
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA MOSTRAR TODAS LAS INSCRIPCIONES
   ========================================================== */
IF OBJECT_ID('SP_MostrarInscripcionTodo', 'P') IS NOT NULL
    DROP PROCEDURE SP_MostrarInscripcionTodo;
GO

CREATE PROCEDURE SP_MostrarInscripcionTodo
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        c.nombre AS nombreCliente,
        e.tipo AS tipoEntrenamiento,
        i.fechaInscripcion,
        i.estado
    FROM 
        Inscripciones i
    INNER JOIN 
        Cliente c ON i.codigoCliente = c.codigoCliente
    INNER JOIN 
        Entrenamiento e ON i.codigoEntrenamiento = e.codigoEntrenamiento;
END
GO

/* ==========================================================
   PROCEDIMIENTO ALMACENADO PARA BUSCAR INSCRIPCION POR CODIGO
   ========================================================== */
IF OBJECT_ID('SP_BuscarInscripcionXCodigo', 'P') IS NOT NULL
    DROP PROCEDURE SP_BuscarInscripcionXCodigo;
GO

CREATE PROCEDURE SP_BuscarInscripcionXCodigo
    @codigo INT
AS
BEGIN
    SELECT 
        i.codigoInscripcion,
        c.nombre AS nombreCliente,
        e.tipo AS tipoEntrenamiento,
        i.fechaInscripcion,
        i.estado
    FROM 
        Inscripciones i
    INNER JOIN 
        Cliente c ON i.codigoCliente = c.codigoCliente
    INNER JOIN 
        Entrenamiento e ON i.codigoEntrenamiento = e.codigoEntrenamiento
    WHERE 
        i.codigoInscripcion = @codigo;
END
GO

PRINT 'Procedimientos almacenados SP_MostrarInscripcionTodo y SP_BuscarInscripcionXCodigo creados exitosamente.';
GO
