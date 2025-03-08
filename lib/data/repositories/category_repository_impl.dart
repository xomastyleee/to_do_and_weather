import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../models/category_model.dart';

/// Implementation of CategoryRepository using local data source
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _localDataSource;

  CategoryRepositoryImpl(this._localDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final categoryModels = _localDataSource.getCategories();
    return categoryModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    final categoryModel = _localDataSource.getCategoryById(id);
    return categoryModel?.toEntity();
  }

  @override
  Future<void> addCategory(Category category) async {
    await _localDataSource.addCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _localDataSource.updateCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _localDataSource.deleteCategory(id);
  }

  @override
  Future<void> initDefaultCategories() async {
    await _localDataSource.initDefaultCategories();
  }
}
