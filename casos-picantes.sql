USE TaskManagementSystem;
GO

---

--- Mail repetido
CreateUser 'ckent', 'Clark Kent', 'johnd@example.com';
GO
CreateUser 'dprince', 'Diana Prince', 'alice@example.com';
GO

-- Colision de los IDs:

-- Colisiona con el usuario 1.
CreateTaskAssignation 11, 2, '2025-06-20 10:00:00';
GO
-- Colisiona con el usuario 4.
CreateTaskAssignation 14, 5, '2025-06-23 10:00:00';
GO
