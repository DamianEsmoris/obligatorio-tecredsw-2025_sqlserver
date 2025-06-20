USE TaskManagementSystem;
GO

---

GetTask 21;
GO
UpdateTask 21, 'Hacer cosas', 'Muchas cosas', '2025-11-28 10:00:00', 'Done';
GO
GetTask 21;
GO
DeleteTask 21;
GO
GetAllTasks;
GO
