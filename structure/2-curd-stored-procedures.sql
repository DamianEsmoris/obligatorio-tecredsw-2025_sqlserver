USE TaskManagementSystem;
GO

--- Users ---

CREATE PROCEDURE CreateUser
    @username VARCHAR(32),
    @fullName VARCHAR(64),
    @email VARCHAR(64)
AS
BEGIN
    INSERT INTO Users
        (username, fullName, email)
    VALUES
        (@username, @fullName, @email);
END;
GO

CREATE PROCEDURE GetAllUsers
AS
BEGIN
    SELECT
        id,
        username,
        fullName,
        email
    FROM Users;
END;
GO

CREATE PROCEDURE GetUser
    @id INT
AS
BEGIN
    SELECT
        id,
        username,
        fullName,
        email
    FROM Users
    WHERE id = @id;
END;
GO

CREATE PROCEDURE UpdateUser
    @id INT,
    @username VARCHAR(32),
    @fullName VARCHAR(64),
    @email VARCHAR(64)
AS
BEGIN
    UPDATE Users SET
        username = @username,
        fullName = @fullName,
        email = @email
    WHERE id = @id;
END;
GO

CREATE PROCEDURE DeleteUser
    @id INT
AS
BEGIN
    DELETE FROM Users
    WHERE id = @id;
END;
GO

--- Tasks ---

CREATE PROCEDURE CreateTask
    @title VARCHAR(255),
    @description TEXT,
    @dateTime DATETIME,
    @status VARCHAR(128)
AS
BEGIN
    INSERT INTO Tasks
        (title, description, dateTime, status)
    VALUES
        (@title, @description, @dateTime, @status);
END;
GO

CREATE PROCEDURE GetAllTasks AS
BEGIN
    SELECT
        id,
        title,
        description,
        dateTime,
        status
    FROM Tasks;
END;
GO

CREATE PROCEDURE GetAllTasksWithStatus 
    @status VARCHAR(128)
AS
BEGIN
    SELECT
        id,
        title,
        description,
        dateTime,
        status
    FROM Tasks
    WHERE status = @status;
END;
GO

CREATE PROCEDURE GetTask
    @id INT
AS
BEGIN
    SELECT
        id,
        title,
        description,
        dateTime,
        status
    FROM Tasks
    WHERE id = @id;
END;
GO

CREATE PROCEDURE UpdateTask
    @id INT,
    @title VARCHAR(255),
    @description TEXT,
    @dateTime DATETIME,
    @status VARCHAR(128)
AS
BEGIN
    UPDATE Tasks SET
        title = @title,
        description = @description,
        dateTime = @dateTime,
        status = @status
    WHERE id = @id;
END;
GO

CREATE PROCEDURE DeleteTask
    @id INT
AS
BEGIN
    DELETE FROM Tasks
    WHERE id = @id;
END;
GO

--- TasksAssignations ---

CREATE PROCEDURE CreateTaskAssignation
    @taskId INT,
    @userId INT,
    @dateTime DATETIME
AS
BEGIN
    INSERT INTO TasksAssignations
        (taskId, userId, dateTime)
    VALUES
        (@taskId, @userId, @dateTime);
END;
GO

CREATE PROCEDURE GetAllTaskAssignation
AS
BEGIN
    SELECT
        taskId,
        userId,
        dateTime
    FROM TasksAssignations;
END;
GO

CREATE PROCEDURE GetTaskAssignation
    @taskId INT,
    @userId INT,
    @dateTime DATETIME
AS
BEGIN
    SELECT
        taskId,
        userId,
        dateTime
    FROM TasksAssignations
    WHERE taskId = @taskId AND userId = @userId AND dateTime = @dateTime;
END;
GO

CREATE PROCEDURE UpdateTaskAssignation
    @taskId INT,
    @userId INT,
    @dateTime DATETIME,
    @newTaskId INT,
    @newUserId INT,
    @newDateTime DATETIME
AS
BEGIN
    EXEC DeleteTaskAssignation
        @taskId,
        @userId,
        @dateTime;

    EXEC CreateTaskAssignation
        @newTaskId
        @newUserId,
        @newDateTime;

    -- Puede que sea mala idea hacer esto pero en mi corazón me dice que es lo correcto
END;
GO

CREATE PROCEDURE DeleteTaskAssignation
    @taskId INT,
    @userId INT,
    @dateTime DATETIME
AS
BEGIN
    DELETE FROM TasksAssignations
    WHERE taskId = @taskId AND userId = @userId AND dateTime = @dateTime;
END;
GO

--- TasksHistory ---

CREATE PROCEDURE CreateTaskHistory
    @taskId INT,
    @userId INT,
    @dateTime DATETIME,
    @action CHAR(1)
AS
BEGIN
    INSERT INTO TasksHistory
        (taskId, userId, dateTime, action)
    VALUES
        (@taskId, @userId, @dateTime, @action);
END;
GO

CREATE PROCEDURE GetAllTasksHistory
AS
BEGIN
    SELECT
        taskId,
        userId,
        dateTime,
        action
    FROM TasksHistory;
END;
GO

CREATE PROCEDURE GetTaskHistory
    @taskId INT,
    @userId INT,
    @dateTime DATETIME
AS
BEGIN
    SELECT
        taskId,
        userId,
        dateTime,
        action
    FROM TasksHistory
    WHERE taskId = @taskId AND userId = @userId AND dateTime = @dateTime;
END;
GO

CREATE PROCEDURE UpdateTaskHistory
    @taskId INT,
    @userId INT,
    @dateTime DATETIME,
    @action CHAR(1)
AS
BEGIN
    UPDATE TasksHistory SET
        dateTime = @dateTime,
        action = @action
    WHERE taskId = @taskId AND userId = @userId AND dateTime = @dateTime;
END;
GO

CREATE PROCEDURE DeleteTaskHistory
    @taskId INT,
    @userId INT,
    @dateTime DATETIME
AS
BEGIN
    DELETE FROM TasksHistory
    WHERE taskId = @taskId AND userId = @userId AND dateTime = @dateTime;
END;
GO

--- Extras ---

CREATE PROCEDURE GetTasksAssignedTo
    @userId INT
AS
BEGIN
    SELECT task.*
    FROM TasksAssignations
    INNER JOIN Tasks task ON task.id = taskId
    WHERE userId = @userId;
END;
GO

CREATE PROCEDURE GetTaskHistoryByTaskId
    @taskId INT
AS
BEGIN
    SELECT
        taskId,
        userId,
        dateTime,
        action
    FROM TasksHistory
    WHERE taskId = @taskId;
END;
GO
