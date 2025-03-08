import 'package:equatable/equatable.dart';
import '../../../domain/entities/category.dart';

/// Base class for all category events
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all categories
class LoadCategories extends CategoryEvent {
  const LoadCategories();
}

/// Event to add a new category
class AddCategory extends CategoryEvent {
  final Category category;

  const AddCategory(this.category);

  @override
  List<Object?> get props => [category];
}

/// Event to update an existing category
class UpdateCategory extends CategoryEvent {
  final Category category;

  const UpdateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

/// Event to delete a category
class DeleteCategory extends CategoryEvent {
  final String id;

  const DeleteCategory(this.id);

  @override
  List<Object?> get props => [id];
}

/// Event to initialize default categories
class InitDefaultCategories extends CategoryEvent {
  const InitDefaultCategories();
}
