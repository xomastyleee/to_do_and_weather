import '../entities/task.dart';

/// Interface for task repository
abstract class TaskRepository {
  /// Get all tasks
  Future<List<Task>> getTasks();

  /// Get task by id
  Future<Task?> getTaskById(String id);

  /// Add a new task
  Future<void> addTask(Task task);

  /// Update an existing task
  Future<void> updateTask(Task task);

  /// Delete a task
  Future<void> deleteTask(String id);

  /// Get tasks by category id
  Future<List<Task>> getTasksByCategoryId(String categoryId);

  /// Get completed tasks
  Future<List<Task>> getCompletedTasks();

  /// Get incomplete tasks
  Future<List<Task>> getIncompleteTasks();
}
