USE TaskManagementSystem;
GO

---

GetTask 21;
GO

UpdateTask 21, 'Hacer cosas', 'Muchas cosas', 'Done';
GO

GetTask 21;
GO

DeleteTask 21;
GO

GetTaskHistoryByTaskId 21;
GO

GetAllTasks;
GO
