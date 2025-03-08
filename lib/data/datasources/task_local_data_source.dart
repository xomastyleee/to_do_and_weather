import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../models/task_model.dart';

/// Local data source for tasks using Hive
class TaskLocalDataSource {
  final Box<TaskModel> _tasksBox;

  TaskLocalDataSource(this._tasksBox);

  /// Get all tasks
  List<TaskModel> getTasks() {
    return _tasksBox.values.toList();
  }

  /// Get task by id
  TaskModel? getTaskById(String id) {
    return _tasksBox.get(id);
  }

  /// Add a new task
  Future<void> addTask(TaskModel task) async {
    await _tasksBox.put(task.id, task);
  }

  /// Update an existing task
  Future<void> updateTask(TaskModel task) async {
    await _tasksBox.put(task.id, task);
  }

  /// Delete a task
  Future<void> deleteTask(String id) async {
    await _tasksBox.delete(id);
  }

  /// Get tasks by category id
  List<TaskModel> getTasksByCategoryId(String categoryId) {
    return _tasksBox.values
        .where((task) => task.categoryId == categoryId)
        .toList();
  }

  /// Get completed tasks
  List<TaskModel> getCompletedTasks() {
    return _tasksBox.values.where((task) => task.isCompleted).toList();
  }

  /// Get incomplete tasks
  List<TaskModel> getIncompleteTasks() {
    return _tasksBox.values.where((task) => !task.isCompleted).toList();
  }

  /// Initialize the data source
  static Future<TaskLocalDataSource> init() async {
    final box = await Hive.openBox<TaskModel>(AppConstants.tasksBoxName);
    return TaskLocalDataSource(box);
  }
}
