    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_MostrarTrainer'
    ) DROP PROCEDURE SP_MostrarTrainer;

GO
    -- Muestra los trainers activos
    CREATE PROC SP_MostrarTrainer AS BEGIN
SELECT
    *
FROM
    Trainer
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
            name = 'SP_MostrarTrainerTodo'
    ) DROP PROCEDURE SP_MostrarTrainerTodo;

GO
    -- Muestra todos los trainers
    CREATE PROC SP_MostrarTrainerTodo AS BEGIN
SELECT
    *
FROM
    Trainer;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_BuscarTrainerXCodigo'
    ) DROP PROCEDURE SP_BuscarTrainerXCodigo;

GO
    -- Busca un trainer por código
    CREATE PROC SP_BuscarTrainerXCodigo @codigoTrainer INT AS BEGIN
SELECT
    *
FROM
    Trainer
WHERE
    codigoTrainer = @codigoTrainer;

END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_RegistrarTrainer'
    ) DROP PROCEDURE SP_RegistrarTrainer;

GO
    -- Registra un nuevo trainer
    CREATE PROC SP_RegistrarTrainer @nombre VARCHAR(MAX),
    @apellido VARCHAR(MAX),
    @especialidad VARCHAR(MAX),
    @disponibilidad VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_RegistrarTrainer BEGIN TRY
INSERT INTO
    Trainer(
        nombre,
        apellido,
        especialidad,
        disponibilidad,
        estado
    )
VALUES
    (
        @nombre,
        @apellido,
        @especialidad,
        @disponibilidad,
        @estado
    );

COMMIT TRAN SP_RegistrarTrainer;

END TRY BEGIN CATCH ROLLBACK TRAN SP_RegistrarTrainer;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_ActualizarTrainer'
    ) DROP PROCEDURE SP_ActualizarTrainer;

GO
    -- Actualiza datos de un trainer
    CREATE PROC SP_ActualizarTrainer @codigoTrainer INT,
    @nombre VARCHAR(MAX),
    @apellido VARCHAR(MAX),
    @especialidad VARCHAR(MAX),
    @disponibilidad VARCHAR(MAX),
    @estado VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_ActualizarTrainer BEGIN TRY
UPDATE
    Trainer
SET
    nombre = @nombre,
    apellido = @apellido,
    especialidad = @especialidad,
    disponibilidad = @disponibilidad,
    estado = @estado
WHERE
    codigoTrainer = @codigoTrainer;

COMMIT TRAN SP_ActualizarTrainer;

END TRY BEGIN CATCH ROLLBACK TRAN SP_ActualizarTrainer;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_EliminarTrainer'
    ) DROP PROCEDURE SP_EliminarTrainer;

GO
    -- Elimina lógicamente un trainer
    CREATE PROC SP_EliminarTrainer @codigoTrainer INT AS BEGIN BEGIN TRAN SP_EliminarTrainer BEGIN TRY
UPDATE
    Trainer
SET
    estado = 0
WHERE
    codigoTrainer = @codigoTrainer;

COMMIT TRAN SP_EliminarTrainer;

END TRY BEGIN CATCH ROLLBACK TRAN SP_EliminarTrainer;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_HabilitarTrainer'
    ) DROP PROCEDURE SP_HabilitarTrainer;

GO
    -- Habilita un trainer
    CREATE PROC SP_HabilitarTrainer @codigoTrainer INT AS BEGIN BEGIN TRAN SP_HabilitarTrainer BEGIN TRY
UPDATE
    Trainer
SET
    estado = 1
WHERE
    codigoTrainer = @codigoTrainer;

COMMIT TRAN SP_HabilitarTrainer;

END TRY BEGIN CATCH ROLLBACK TRAN SP_HabilitarTrainer;

END CATCH
END
GO
    IF EXISTS(
        SELECT
            *
        FROM
            sys.procedures
        WHERE
            name = 'SP_CodigoTrainer'
    ) DROP PROCEDURE SP_CodigoTrainer;

GO
    -- Obtiene el siguiente código de trainer
    CREATE PROC SP_CodigoTrainer AS BEGIN DECLARE @codigo INT;

SELECT
    @codigo = ISNULL(MAX(codigoTrainer), 0) + 1
FROM
    Trainer;

SELECT
    @codigo AS SiguienteCodigo;

END
GO

-------------------
-- Entrenamiento --
-------------------

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarEntrenamiento')
    DROP PROCEDURE SP_MostrarEntrenamiento;
GO

CREATE PROC SP_MostrarEntrenamiento
AS
BEGIN
    SELECT 
        e.codigoEntrenamiento, e.tipo, e.fechaHora, e.duracion,
        e.ubicacion, e.capacidadMaxima, e.estado,
        t.codigoTrainer, t.nombre,
        l.codigoLocal, l.tipo
    FROM entrenamiento e
    INNER JOIN trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN locales l ON e.codigoLocal = l.codigoLocal
    WHERE e.estado = 1;
END
GO


--IF EXISTS(        SELECT
--            *
--        FROM
--            sys.procedures
--        WHERE
--            name = 'SP_MostrarEntrenamientoTodo'
--    ) DROP PROCEDURE SP_MostrarEntrenamientoTodo;

--GO
--    -- Muestra todos los entrenamientos
--    CREATE PROC SP_MostrarEntrenamientoTodo AS BEGIN
--SELECT
--    *
--FROM
--    Entrenamiento;

--END
--GO

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarEntrenamientoTodo')
    DROP PROCEDURE SP_MostrarEntrenamientoTodo;
GO

CREATE PROC SP_MostrarEntrenamientoTodo
AS
BEGIN
    SELECT	e.codigoEntrenamiento, e.tipo AS tipoEntrenamiento, e.fechaHora, e.duracion,
			e.ubicacion, e.capacidadMaxima, e.estado,
			t.codigoTrainer, t.nombre AS nombreTrainer,
			l.codigoLocal, l.tipo AS tipoLocal
    FROM entrenamiento e
    INNER JOIN trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN locales l ON e.codigoLocal = l.codigoLocal
END
GO

Use megaforce




--IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'SP_BuscarEntrenamientoXCodigo')
--DROP PROCEDURE SP_BuscarEntrenamientoXCodigo;
--GO
--    -- Busca un entrenamiento por código
--CREATE PROC SP_BuscarEntrenamientoXCodigo @codigoEntrenamiento INT AS BEGIN
--SELECT * FROM Entrenamiento
--WHERE codigoEntrenamiento = @codigoEntrenamiento;
--END
--GO


IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'SP_BuscarEntrenamientoXCodigo')
DROP PROCEDURE SP_BuscarEntrenamientoXCodigo
GO
CREATE PROC SP_BuscarEntrenamientoXCodigo
@codigo INT
AS
BEGIN
    SELECT  e.codigoEntrenamiento, e.tipo, e.fechaHora, e.duracion,
            e.ubicacion, e.capacidadMaxima, e.estado,
            t.codigoTrainer, t.nombre AS nombreTrainer,
            l.codigoLocal, l.tipo AS tipoLocal
    FROM entrenamiento e
    INNER JOIN trainer t ON e.codigoTrainer = t.codigoTrainer
    INNER JOIN locales l ON e.codigoLocal = l.codigoLocal
    WHERE e.codigoEntrenamiento = @codigo
END
GO

--IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarEntrenamiento') 
--DROP PROCEDURE SP_RegistrarEntrenamiento;

--GO
--    -- Registra un nuevo entrenamiento
--    CREATE PROC SP_RegistrarEntrenamiento @tipo VARCHAR(MAX),
--    @fechaHora VARCHAR(MAX),
--    @duracion VARCHAR(MAX),
--    @ubicacion VARCHAR(MAX),
--    @capacidadMaxima VARCHAR(MAX),
--    @estado VARCHAR(MAX),
--    @codigoTrainer VARCHAR(MAX),
--    @codigoLocal VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_RegistrarEntrenamiento BEGIN TRY
--INSERT INTO
--    Entrenamiento(
--        tipo,
--        fechaHora,
--        duracion,
--        ubicacion,
--        capacidadMaxima,
--        estado,
--        codigoTrainer,
--        codigoLocal
--    )
--VALUES
--    (
--        @tipo,
--        @fechaHora,
--        @duracion,
--        @ubicacion,
--        @capacidadMaxima,
--        @estado,
--        @codigoTrainer,
--        @codigoLocal
--    );

--COMMIT TRAN SP_RegistrarEntrenamiento;

--END TRY BEGIN CATCH ROLLBACK TRAN SP_RegistrarEntrenamiento;

--END CATCH
--END
GO

--Registrar Entrenamiento
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'SP_RegistrarEntrenamiento')
    DROP PROCEDURE SP_RegistrarEntrenamiento
GO

CREATE PROC SP_RegistrarEntrenamiento
    @tipo              VARCHAR(50),
    @fechaHora         DATETIME,
    @duracion          DECIMAL(5,2),
    @ubicacion         VARCHAR(50),
    @capacidadMaxima   INT,
    @estado            BIT,
    @codigoTrainer     INT,
    @codigoLocal       INT
AS
BEGIN
    BEGIN TRAN SP_RegistrarEntrenamiento
    BEGIN TRY
        
        INSERT INTO Entrenamiento
        (tipo, fechaHora, duracion, ubicacion, capacidadMaxima, estado, codigoTrainer, codigoLocal)
        VALUES
        (@tipo, @fechaHora, @duracion, @ubicacion, @capacidadMaxima, @estado, @codigoTrainer, @codigoLocal);

        COMMIT TRAN SP_RegistrarEntrenamiento
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_RegistrarEntrenamiento
    END CATCH
END
GO









--    IF EXISTS(
--        SELECT
--            *
--        FROM
--            sys.procedures
--        WHERE
--            name = 'SP_ActualizarEntrenamiento'
--    ) DROP PROCEDURE SP_ActualizarEntrenamiento;

--GO
--    -- Actualiza un entrenamiento
--    CREATE PROC SP_ActualizarEntrenamiento @codigoEntrenamiento INT,
--    @tipo VARCHAR(MAX),
--    @fechaHora VARCHAR(MAX),
--    @duracion VARCHAR(MAX),
--    @ubicacion VARCHAR(MAX),
--    @capacidadMaxima VARCHAR(MAX),
--    @estado VARCHAR(MAX),
--    @codigoTrainer VARCHAR(MAX),
--    @codigoLocal VARCHAR(MAX) AS BEGIN BEGIN TRAN SP_ActualizarEntrenamiento BEGIN TRY
--UPDATE
--    Entrenamiento
--SET
--    tipo = @tipo,
--    fechaHora = @fechaHora,
--    duracion = @duracion,
--    ubicacion = @ubicacion,
--    capacidadMaxima = @capacidadMaxima,
--    estado = @estado,
--    codigoTrainer = @codigoTrainer,
--    codigoLocal = @codigoLocal
--WHERE
--    codigoEntrenamiento = @codigoEntrenamiento;

--COMMIT TRAN SP_ActualizarEntrenamiento;

--END TRY BEGIN CATCH ROLLBACK TRAN SP_ActualizarEntrenamiento;

--END CATCH
--END
--GO





IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarEntrenamiento')
    DROP PROCEDURE SP_ActualizarEntrenamiento
GO

CREATE PROC SP_ActualizarEntrenamiento
    @codigoEntrenamiento INT,
    @tipo                VARCHAR(50),
    @fechaHora           DATETIME,
    @duracion            DECIMAL(5,2),
    @ubicacion           VARCHAR(50),
    @capacidadMaxima     INT,
    @estado              BIT,
    @codigoTrainer       INT,
    @codigoLocal         INT
AS
BEGIN
    BEGIN TRAN SP_ActualizarEntrenamiento
    BEGIN TRY

        UPDATE Entrenamiento
        SET tipo            = @tipo,
            fechaHora       = @fechaHora,
            duracion        = @duracion,
            ubicacion       = @ubicacion,
            capacidadMaxima = @capacidadMaxima,
            estado          = @estado,
            codigoTrainer   = @codigoTrainer,
            codigoLocal     = @codigoLocal
        WHERE codigoEntrenamiento = @codigoEntrenamiento;

        COMMIT TRAN SP_ActualizarEntrenamiento
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SP_ActualizarEntrenamiento
    END CATCH
END
GO









--    IF EXISTS(
--        SELECT
--            *
--        FROM
--            sys.procedures
--        WHERE
--            name = 'SP_EliminarEntrenamiento'
--    ) DROP PROCEDURE SP_EliminarEntrenamiento;

--GO
--    -- Elimina lógicamente un entrenamiento
--    CREATE PROC SP_EliminarEntrenamiento @codigoEntrenamiento INT AS BEGIN BEGIN TRAN SP_EliminarEntrenamiento BEGIN TRY
--UPDATE
--    Entrenamiento
--SET
--    estado = 0
--WHERE
--    codigoEntrenamiento = @codigoEntrenamiento;

--COMMIT TRAN SP_EliminarEntrenamiento;

--END TRY BEGIN CATCH ROLLBACK TRAN SP_EliminarEntrenamiento;

--END CATCH
--END
--GO


--    IF EXISTS(
--        SELECT
--            *
--        FROM
--            sys.procedures
--        WHERE
--            name = 'SP_HabilitarEntrenamiento'
--    ) DROP PROCEDURE SP_HabilitarEntrenamiento;

--GO
--    -- Habilita un entrenamiento
--    CREATE PROC SP_HabilitarEntrenamiento @codigoEntrenamiento INT AS BEGIN BEGIN TRAN SP_HabilitarEntrenamiento BEGIN TRY
--UPDATE
--    Entrenamiento
--SET
--    estado = 1
--WHERE
--    codigoEntrenamiento = @codigoEntrenamiento;

--COMMIT TRAN SP_HabilitarEntrenamiento;

--END TRY BEGIN CATCH ROLLBACK TRAN SP_HabilitarEntrenamiento;

--END CATCH
--END
--GO






IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarEntrenamiento') 
DROP PROCEDURE SP_EliminarEntrenamiento
go
CREATE PROC SP_EliminarEntrenamiento
@codigo INT  
AS  
BEGIN  
    BEGIN TRAN SP_EliminarEntrenamiento
    BEGIN TRY  
        UPDATE Entrenamiento SET estado = 0 WHERE codigoEntrenamiento = @codigo  
        COMMIT TRAN SP_EliminarEntrenamiento
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRAN SP_EliminarEntrenamiento
    END CATCH  
END
GO

-- Habilitar 
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_HabilitarEntrenamiento') 
DROP PROCEDURE SP_HabilitarEntrenamiento
go
CREATE PROC SP_HabilitarEntrenamiento
@codigo INT  
AS  
BEGIN  
    BEGIN TRAN SP_HabilitarEntrenamiento
    BEGIN TRY  
        UPDATE Entrenamiento SET estado = 1 WHERE codigoEntrenamiento = @codigo  
        COMMIT TRAN SP_HabilitarEntrenamiento
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRAN SP_HabilitarEntrenamiento
    END CATCH  
END
GO


IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'SP_CodigoEntrenamiento'
    ) DROP PROCEDURE SP_CodigoEntrenamiento;

GO
    -- Obtiene el siguiente código de entrenamiento
    CREATE PROC SP_CodigoEntrenamiento AS BEGIN DECLARE @codigo INT;

SELECT
    @codigo = ISNULL(MAX(codigoEntrenamiento), 0) + 1
FROM
    Entrenamiento;

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
            name = 'SP_MostrarMetodoPago'
    ) DROP PROCEDURE SP_MostrarMetodoPago;

GO