USE TaskManagementSystem;
GO

---

CREATE TABLE Users(
    id INT IDENTITY (1,1) PRIMARY KEY,
    username VARCHAR(32) UNIQUE,
    fullName VARCHAR(64) NOT NULL,
    email VARCHAR(64)
);

CREATE TABLE Tasks(
    id INT IDENTITY (1,1) PRIMARY KEY,
    title VARCHAR(255) UNIQUE,
    description TEXT,
    dateTime DATETIME,
    status VARCHAR(128) DEFAULT NULL  
);

CREATE TABLE TasksAssignations(
    taskId INT,
    userId INT,
    dateTime DATETIME,
    CONSTRAINT PK_TasksAssignations PRIMARY KEY (taskId, userId, dateTime),
    CONSTRAINT FK_TasksAssignations_Task FOREIGN KEY (taskId) REFERENCES Tasks (id),
    CONSTRAINT FK_TasksAssignations_User FOREIGN KEY (userId) REFERENCES Users (id)
);

-- action: (C)reate, (D)elete, (U)pdate
CREATE TABLE TasksHistory(
    taskId INT,
    userId INT,
    dateTime DATETIME DEFAULT GETDATE(),
    action CHAR(1) NOT NULL,
    CONSTRAINT PK_TasksHistory PRIMARY KEY (taskId, userId, dateTime),
    CONSTRAINT FK_TasksHistory_Users FOREIGN KEY (userId) REFERENCES Users (id),
    CONSTRAINT FK_TasksHistory_Tasks FOREIGN KEY (taskId) REFERENCES Tasks (id),
    CONSTRAINT CHK_TasksHistory_action CHECK (action IN ('C', 'D', 'U'))
);
