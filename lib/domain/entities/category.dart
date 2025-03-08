import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Entity representing a task category in the application
class Category extends Equatable {
  final String id;
  final String name;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.color,
  });

  /// Creates a copy of this category with the given fields replaced with the new values
  Category copyWith({
    String? id,
    String? name,
    Color? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [id, name, color];
}
