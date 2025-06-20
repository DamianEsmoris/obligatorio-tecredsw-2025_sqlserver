USE TaskManagementSystem;
GO

---

CREATE TRIGGER InsertTaskAssignationOnHistory
ON TasksAssignations
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @taskId INT;
    DECLARE @userId INT;
    DECLARE @action CHAR(1);
    DECLARE @dateTime DATETIME;

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @action = 'U';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @action = 'C';
    END
    ELSE 
    BEGIN
        SET @action = 'D';
    END

    INSERT INTO TasksHistory (taskId, userId, action)
        SELECT taskId, userId, @action AS action
        FROM deleted
        UNION ALL
        SELECT taskId, userId, @action AS action
        FROM inserted;
END;
GO
