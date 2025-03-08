import '../entities/category.dart';

/// Interface for category repository
abstract class CategoryRepository {
  /// Get all categories
  Future<List<Category>> getCategories();

  /// Get category by id
  Future<Category?> getCategoryById(String id);

  /// Add a new category
  Future<void> addCategory(Category category);

  /// Update an existing category
  Future<void> updateCategory(Category category);

  /// Delete a category
  Future<void> deleteCategory(String id);

  /// Initialize default categories if none exist
  Future<void> initDefaultCategories();
}
