USE TaskManagementSystem;
GO

--- 

CREATE TRIGGER AvoidTaskAssignationCollision
ON TasksAssignations
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @userId INT;
    SELECT
        @userId = userId
    FROM inserted;

    IF EXISTS (
        SELECT 1 FROM inserted i
        INNER JOIN TasksAssignations a
        ON i.taskId = a.taskId AND i.userId = a.userId AND i.dateTime = a.dateTime
        WHERE i.userId <> @userId
    )
    BEGIN
        RAISERROR('A task cannot be assigned to different users at the same date and time.', 16, 1);
        RETURN;
    END

    INSERT INTO TasksAssignations
    SELECT * FROM inserted;
END;
GO
