import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';

/// Base class for all task events
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all tasks
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

/// Event to load tasks by category
class LoadTasksByCategory extends TaskEvent {
  final String categoryId;

  const LoadTasksByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

/// Event to load completed tasks
class LoadCompletedTasks extends TaskEvent {
  const LoadCompletedTasks();
}

/// Event to load incomplete tasks
class LoadIncompleteTasks extends TaskEvent {
  const LoadIncompleteTasks();
}

/// Event to add a new task
class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

/// Event to update an existing task
class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

/// Event to delete a task
class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}

/// Event to toggle task completion status
class ToggleTaskCompletion extends TaskEvent {
  final Task task;

  const ToggleTaskCompletion(this.task);

  @override
  List<Object?> get props => [task];
}
