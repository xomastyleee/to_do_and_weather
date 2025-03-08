import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../models/category_model.dart';

/// Local data source for categories using Hive
class CategoryLocalDataSource {
  final Box<CategoryModel> _categoriesBox;

  CategoryLocalDataSource(this._categoriesBox);

  /// Get all categories
  List<CategoryModel> getCategories() {
    return _categoriesBox.values.toList();
  }

  /// Get category by id
  CategoryModel? getCategoryById(String id) {
    return _categoriesBox.get(id);
  }

  /// Add a new category
  Future<void> addCategory(CategoryModel category) async {
    await _categoriesBox.put(category.id, category);
  }

  /// Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    await _categoriesBox.put(category.id, category);
  }

  /// Delete a category
  Future<void> deleteCategory(String id) async {
    await _categoriesBox.delete(id);
  }

  /// Initialize default categories if none exist
  Future<void> initDefaultCategories() async {
    if (_categoriesBox.isEmpty) {
      final defaultCategories = [
        CategoryModel(
          id: AppConstants.workCategoryId,
          name: 'Work',
          colorValue: Colors.blue.value,
        ),
        CategoryModel(
          id: AppConstants.personalCategoryId,
          name: 'Personal',
          colorValue: Colors.green.value,
        ),
        CategoryModel(
          id: AppConstants.shoppingCategoryId,
          name: 'Shopping',
          colorValue: Colors.orange.value,
        ),
        CategoryModel(
          id: AppConstants.healthCategoryId,
          name: 'Health',
          colorValue: Colors.red.value,
        ),
      ];

      for (final category in defaultCategories) {
        await addCategory(category);
      }
    }
  }

  /// Initialize the data source
  static Future<CategoryLocalDataSource> init() async {
    final box =
        await Hive.openBox<CategoryModel>(AppConstants.categoriesBoxName);
    return CategoryLocalDataSource(box);
  }
}
