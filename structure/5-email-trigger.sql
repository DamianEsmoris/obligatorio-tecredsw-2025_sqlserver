USE TaskManagementSystem;
GO

---

CREATE TRIGGER UniqueEmailAddress
ON Users
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        INNER JOIN Users u ON i.email = u.email
    )
    BEGIN
        RAISERROR('Email has been taken', 16, 1);
        RETURN;
    END
    INSERT INTO Users (username, fullName, email)
    SELECT username, fullName, email FROM inserted;
END;
GO
