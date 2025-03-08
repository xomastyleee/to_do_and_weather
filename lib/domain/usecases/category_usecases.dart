import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Get all categories use case
class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}

/// Get category by id use case
class GetCategoryByIdUseCase {
  final CategoryRepository _repository;

  GetCategoryByIdUseCase(this._repository);

  Future<Category?> call(String id) async {
    return await _repository.getCategoryById(id);
  }
}

/// Add category use case
class AddCategoryUseCase {
  final CategoryRepository _repository;

  AddCategoryUseCase(this._repository);

  Future<void> call(Category category) async {
    await _repository.addCategory(category);
  }
}

/// Update category use case
class UpdateCategoryUseCase {
  final CategoryRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<void> call(Category category) async {
    await _repository.updateCategory(category);
  }
}

/// Delete category use case
class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteCategory(id);
  }
}

/// Initialize default categories use case
class InitDefaultCategoriesUseCase {
  final CategoryRepository _repository;

  InitDefaultCategoriesUseCase(this._repository);

  Future<void> call() async {
    await _repository.initDefaultCategories();
  }
}
