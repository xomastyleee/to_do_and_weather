import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/category_usecases.dart';
import 'category_event.dart';
import 'category_state.dart';

/// BLoC for managing category state
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;
  final AddCategoryUseCase _addCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final InitDefaultCategoriesUseCase _initDefaultCategoriesUseCase;

  CategoryBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetCategoryByIdUseCase getCategoryByIdUseCase,
    required AddCategoryUseCase addCategoryUseCase,
    required UpdateCategoryUseCase updateCategoryUseCase,
    required DeleteCategoryUseCase deleteCategoryUseCase,
    required InitDefaultCategoriesUseCase initDefaultCategoriesUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getCategoryByIdUseCase = getCategoryByIdUseCase,
        _addCategoryUseCase = addCategoryUseCase,
        _updateCategoryUseCase = updateCategoryUseCase,
        _deleteCategoryUseCase = deleteCategoryUseCase,
        _initDefaultCategoriesUseCase = initDefaultCategoriesUseCase,
        super(const CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<InitDefaultCategories>(_onInitDefaultCategories);
  }

  /// Handle LoadCategories event
  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(const CategoryLoading());
    try {
      final categories = await _getCategoriesUseCase();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  /// Handle AddCategory event
  Future<void> _onAddCategory(
      AddCategory event, Emitter<CategoryState> emit) async {
    emit(const CategoryLoading());
    try {
      await _addCategoryUseCase(event.category);
      emit(const CategoryOperationSuccess('Category added successfully'));
      add(const LoadCategories());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  /// Handle UpdateCategory event
  Future<void> _onUpdateCategory(
      UpdateCategory event, Emitter<CategoryState> emit) async {
    emit(const CategoryLoading());
    try {
      await _updateCategoryUseCase(event.category);
      emit(const CategoryOperationSuccess('Category updated successfully'));
      add(const LoadCategories());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  /// Handle DeleteCategory event
  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(const CategoryLoading());
    try {
      await _deleteCategoryUseCase(event.id);
      emit(const CategoryOperationSuccess('Category deleted successfully'));
      add(const LoadCategories());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  /// Handle InitDefaultCategories event
  Future<void> _onInitDefaultCategories(
      InitDefaultCategories event, Emitter<CategoryState> emit) async {
    emit(const CategoryLoading());
    try {
      await _initDefaultCategoriesUseCase();
      add(const LoadCategories());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
