import 'package:equatable/equatable.dart';

/// Entity representing a task in the application
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String categoryId;
  final DateTime createdAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.categoryId,
    required this.createdAt,
  });

  /// Creates a copy of this task with the given fields replaced with the new values
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? categoryId,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, isCompleted, categoryId, createdAt];
}
