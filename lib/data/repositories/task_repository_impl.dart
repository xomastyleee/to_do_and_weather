import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

/// Implementation of TaskRepository using local data source
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _localDataSource;

  TaskRepositoryImpl(this._localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = _localDataSource.getTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Task?> getTaskById(String id) async {
    final taskModel = _localDataSource.getTaskById(id);
    return taskModel?.toEntity();
  }

  @override
  Future<void> addTask(Task task) async {
    await _localDataSource.addTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> updateTask(Task task) async {
    await _localDataSource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> deleteTask(String id) async {
    await _localDataSource.deleteTask(id);
  }

  @override
  Future<List<Task>> getTasksByCategoryId(String categoryId) async {
    final taskModels = _localDataSource.getTasksByCategoryId(categoryId);
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    final taskModels = _localDataSource.getCompletedTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Task>> getIncompleteTasks() async {
    final taskModels = _localDataSource.getIncompleteTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }
}
