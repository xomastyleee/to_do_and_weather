import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';

/// Base class for all task states
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class TaskInitial extends TaskState {
  const TaskInitial();
}

/// Loading state
class TaskLoading extends TaskState {
  const TaskLoading();
}

/// Loaded state with tasks
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? filterCategoryId;
  final bool? filterCompleted;

  const TaskLoaded({
    required this.tasks,
    this.filterCategoryId,
    this.filterCompleted,
  });

  @override
  List<Object?> get props => [tasks, filterCategoryId, filterCompleted];
}

/// Error state
class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Task operation success state
class TaskOperationSuccess extends TaskState {
  final String message;

  const TaskOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
