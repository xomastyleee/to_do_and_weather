import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Get all tasks use case
class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<List<Task>> call() async {
    return await _repository.getTasks();
  }
}

/// Get task by id use case
class GetTaskByIdUseCase {
  final TaskRepository _repository;

  GetTaskByIdUseCase(this._repository);

  Future<Task?> call(String id) async {
    return await _repository.getTaskById(id);
  }
}

/// Add task use case
class AddTaskUseCase {
  final TaskRepository _repository;

  AddTaskUseCase(this._repository);

  Future<void> call(Task task) async {
    await _repository.addTask(task);
  }
}

/// Update task use case
class UpdateTaskUseCase {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<void> call(Task task) async {
    await _repository.updateTask(task);
  }
}

/// Delete task use case
class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteTask(id);
  }
}

/// Get tasks by category id use case
class GetTasksByCategoryIdUseCase {
  final TaskRepository _repository;

  GetTasksByCategoryIdUseCase(this._repository);

  Future<List<Task>> call(String categoryId) async {
    return await _repository.getTasksByCategoryId(categoryId);
  }
}

/// Get completed tasks use case
class GetCompletedTasksUseCase {
  final TaskRepository _repository;

  GetCompletedTasksUseCase(this._repository);

  Future<List<Task>> call() async {
    return await _repository.getCompletedTasks();
  }
}

/// Get incomplete tasks use case
class GetIncompleteTasksUseCase {
  final TaskRepository _repository;

  GetIncompleteTasksUseCase(this._repository);

  Future<List<Task>> call() async {
    return await _repository.getIncompleteTasks();
  }
}
