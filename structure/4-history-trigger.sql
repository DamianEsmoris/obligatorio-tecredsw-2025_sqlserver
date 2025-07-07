USE TaskManagementSystem;
GO

---

CREATE TRIGGER TaskModificationTrigger
ON Tasks
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @userId INT = @@SPID;
    DECLARE @action CHAR(1);

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
        BEGIN
            SET @action = 'U';
        END
        ELSE
        BEGIN 
            SET @action = 'C';
        END

        INSERT INTO TasksHistory (taskId, userId, action)
            SELECT id, @userId, @action AS action
            FROM inserted;
    END
    ELSE 
    BEGIN
        SET @action = 'D';
        INSERT INTO TasksHistory (taskId, userId, action)
            SELECT id, @userId, @action AS action
            FROM deleted;
    END
END;
GO
