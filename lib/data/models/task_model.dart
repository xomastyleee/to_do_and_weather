import 'package:hive/hive.dart';
import '../../domain/entities/task.dart';

part 'task_model.g.dart';

/// Data model for Task entity, used for storage with Hive
@HiveType(typeId: 1)
class TaskModel extends Task {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final String description;

  @override
  @HiveField(3)
  final bool isCompleted;

  @override
  @HiveField(4)
  final String categoryId;

  @override
  @HiveField(5)
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.categoryId,
    required this.createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          isCompleted: isCompleted,
          categoryId: categoryId,
          createdAt: createdAt,
        );

  /// Creates a TaskModel from a Task entity
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      categoryId: task.categoryId,
      createdAt: task.createdAt,
    );
  }

  /// Creates a Task entity from this model
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      categoryId: categoryId,
      createdAt: createdAt,
    );
  }

  /// Creates a copy of this model with the given fields replaced with the new values
  @override
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? categoryId,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
