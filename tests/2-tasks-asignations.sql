USE TaskManagementSystem;
GO

---

GetTaskAssignation
    10,
    1,
    '2025-06-19 17:00:00';
GO

UpdateTaskAssignation
    10,
    1,
    '2025-06-19 17:00:00',
    10,
    3,
    '2025-06-19 15:00:00'
GO

GetTaskAssignation
    10,
    3,
    '2025-06-19 15:00:00';
GO

DeleteTaskAssignation
    10,
    3,
    '2025-06-19 15:00:00';
GO

GetAllTasksAssignations;
GO
