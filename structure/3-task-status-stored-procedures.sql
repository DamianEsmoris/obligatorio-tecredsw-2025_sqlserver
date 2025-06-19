USE TaskManagementSystem;
GO

---

CREATE PROCEDURE UpdateTaskStatus
    @id INT,
    @newStatus VARCHAR(128)
AS
BEGIN
    DECLARE @title VARCHAR(255);
    DECLARE @description NVARCHAR(MAX);
    DECLARE @dateTime DATETIME;

    CREATE TABLE #TempTask(
        id INT,
        title VARCHAR(255),
        description TEXT,
        dateTime DATETIME,
        status VARCHAR(128)
    );

    INSERT INTO #TempTask EXEC GetTask @id;

    SELECT
        @title = title,
        @description = description,
        @dateTime = dateTime
    FROM #TempTask;

    DROP TABLE #TempTask;

    EXEC UpdateTask
        @id,
        @title,
        @description,
        @dateTime,
        @newStatus;
END;
GO

CREATE PROCEDURE UpdateTaskStatusIfAssigned
    @userId INT,
    @taskId INT,
    @newStatus VARCHAR(128)
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM TasksAssignations 
        WHERE taskId = @taskId AND userId = @userId
    )
    BEGIN
        RAISERROR('El usuario no tiene asignada la tarea.', 16, 1);
        RETURN;
    END;

    EXEC UpdateTaskStatus
        @taskId,
        @newStatus;
END;
GO
