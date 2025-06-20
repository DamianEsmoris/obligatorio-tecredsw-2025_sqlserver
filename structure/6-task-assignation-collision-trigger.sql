USE TaskManagementSystem;
GO

--- 

CREATE TRIGGER AvoidTaskAssignationCollision
ON TasksAssignations
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        INNER JOIN TasksAssignations a
        ON i.taskId = a.taskId AND i.dateTime = a.dateTime
        WHERE i.userId <> a.userId
    )
    BEGIN
        RAISERROR('A task cannot be assigned to different users at the same date time.', 16, 1);
        RETURN;
    END

    INSERT INTO TasksAssignations
    SELECT * FROM inserted;
END;
GO
