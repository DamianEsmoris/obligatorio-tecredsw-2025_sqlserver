IF EXISTS (SELECT * FROM sys.databases WHERE name = "TaskManagementSystem")
BEGIN
    DROP DATABASE TaskManagementSystem;
END;

CREATE DATABASE TaskManagementSystem;
GO

USE TaskManagementSystem;
GO
