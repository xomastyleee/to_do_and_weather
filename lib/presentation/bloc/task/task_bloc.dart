import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/task_usecases.dart';
import 'task_event.dart';
import 'task_state.dart';

/// BLoC for managing task state
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetTasksByCategoryIdUseCase _getTasksByCategoryIdUseCase;
  final GetCompletedTasksUseCase _getCompletedTasksUseCase;
  final GetIncompleteTasksUseCase _getIncompleteTasksUseCase;

  TaskBloc({
    required GetTasksUseCase getTasksUseCase,
    required GetTaskByIdUseCase getTaskByIdUseCase,
    required AddTaskUseCase addTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
    required GetTasksByCategoryIdUseCase getTasksByCategoryIdUseCase,
    required GetCompletedTasksUseCase getCompletedTasksUseCase,
    required GetIncompleteTasksUseCase getIncompleteTasksUseCase,
  })  : _getTasksUseCase = getTasksUseCase,
        _addTaskUseCase = addTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _getTasksByCategoryIdUseCase = getTasksByCategoryIdUseCase,
        _getCompletedTasksUseCase = getCompletedTasksUseCase,
        _getIncompleteTasksUseCase = getIncompleteTasksUseCase,
        super(const TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<LoadTasksByCategory>(_onLoadTasksByCategory);
    on<LoadCompletedTasks>(_onLoadCompletedTasks);
    on<LoadIncompleteTasks>(_onLoadIncompleteTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
  }

  /// Handle LoadTasks event
  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasks = await _getTasksUseCase();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle LoadTasksByCategory event
  Future<void> _onLoadTasksByCategory(
      LoadTasksByCategory event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasks = await _getTasksByCategoryIdUseCase(event.categoryId);
      emit(TaskLoaded(
        tasks: tasks,
        filterCategoryId: event.categoryId,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle LoadCompletedTasks event
  Future<void> _onLoadCompletedTasks(
      LoadCompletedTasks event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasks = await _getCompletedTasksUseCase();
      emit(TaskLoaded(
        tasks: tasks,
        filterCompleted: true,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle LoadIncompleteTasks event
  Future<void> _onLoadIncompleteTasks(
      LoadIncompleteTasks event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasks = await _getIncompleteTasksUseCase();
      emit(TaskLoaded(
        tasks: tasks,
        filterCompleted: false,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle AddTask event
  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      await _addTaskUseCase(event.task);
      emit(const TaskOperationSuccess('Task added successfully'));

      // Reload tasks based on current filter
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;
        if (loadedState.filterCategoryId != null) {
          add(LoadTasksByCategory(loadedState.filterCategoryId!));
        } else if (loadedState.filterCompleted == true) {
          add(const LoadCompletedTasks());
        } else if (loadedState.filterCompleted == false) {
          add(const LoadIncompleteTasks());
        } else {
          add(const LoadTasks());
        }
      } else {
        add(const LoadTasks());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle UpdateTask event
  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      await _updateTaskUseCase(event.task);
      emit(const TaskOperationSuccess('Task updated successfully'));

      // Reload tasks based on current filter
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;
        if (loadedState.filterCategoryId != null) {
          add(LoadTasksByCategory(loadedState.filterCategoryId!));
        } else if (loadedState.filterCompleted == true) {
          add(const LoadCompletedTasks());
        } else if (loadedState.filterCompleted == false) {
          add(const LoadIncompleteTasks());
        } else {
          add(const LoadTasks());
        }
      } else {
        add(const LoadTasks());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle DeleteTask event
  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      await _deleteTaskUseCase(event.id);
      emit(const TaskOperationSuccess('Task deleted successfully'));

      // Reload tasks based on current filter
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;
        if (loadedState.filterCategoryId != null) {
          add(LoadTasksByCategory(loadedState.filterCategoryId!));
        } else if (loadedState.filterCompleted == true) {
          add(const LoadCompletedTasks());
        } else if (loadedState.filterCompleted == false) {
          add(const LoadIncompleteTasks());
        } else {
          add(const LoadTasks());
        }
      } else {
        add(const LoadTasks());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// Handle ToggleTaskCompletion event
  Future<void> _onToggleTaskCompletion(
      ToggleTaskCompletion event, Emitter<TaskState> emit) async {
    try {
      final updatedTask = event.task.copyWith(
        isCompleted: !event.task.isCompleted,
      );
      await _updateTaskUseCase(updatedTask);
      emit(const TaskOperationSuccess('Task status updated'));

      // Reload tasks based on current filter
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;
        if (loadedState.filterCategoryId != null) {
          add(LoadTasksByCategory(loadedState.filterCategoryId!));
        } else if (loadedState.filterCompleted == true) {
          add(const LoadCompletedTasks());
        } else if (loadedState.filterCompleted == false) {
          add(const LoadIncompleteTasks());
        } else {
          add(const LoadTasks());
        }
      } else {
        add(const LoadTasks());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
