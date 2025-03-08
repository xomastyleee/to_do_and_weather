import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/category.dart';

part 'category_model.g.dart';

/// Data model for Category entity, used for storage with Hive
@HiveType(typeId: 2)
class CategoryModel extends Category {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String name;

  @HiveField(2)
  final int colorValue;

  CategoryModel({
    required this.id,
    required this.name,
    required this.colorValue,
  }) : super(
          id: id,
          name: name,
          color: Color(colorValue),
        );

  /// Creates a CategoryModel from a Category entity
  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      colorValue: category.color.value,
    );
  }

  /// Creates a Category entity from this model
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      color: Color(colorValue),
    );
  }

  /// Creates a copy of this model with the given fields replaced with the new values
  @override
  CategoryModel copyWith({
    String? id,
    String? name,
    int? colorValue,
    Color? color,
  }) {
    if (color != null) {
      return CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        colorValue: color.value,
      );
    }
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
    );
  }
}
