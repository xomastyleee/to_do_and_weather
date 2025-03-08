import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_and_weather/domain/entities/category.dart';
import 'package:to_do_and_weather/domain/usecases/category_usecases.dart';
import 'package:to_do_and_weather/presentation/bloc/category/category_bloc.dart';
import 'package:to_do_and_weather/presentation/bloc/category/category_event.dart';
import 'package:to_do_and_weather/presentation/bloc/category/category_state.dart';
import 'category_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetCategoriesUseCase>(),
  MockSpec<GetCategoryByIdUseCase>(),
  MockSpec<AddCategoryUseCase>(),
  MockSpec<UpdateCategoryUseCase>(),
  MockSpec<DeleteCategoryUseCase>(),
  MockSpec<InitDefaultCategoriesUseCase>(),
])
void main() {
  late CategoryBloc categoryBloc;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetCategoryByIdUseCase mockGetCategoryByIdUseCase;
  late MockAddCategoryUseCase mockAddCategoryUseCase;
  late MockUpdateCategoryUseCase mockUpdateCategoryUseCase;
  late MockDeleteCategoryUseCase mockDeleteCategoryUseCase;
  late MockInitDefaultCategoriesUseCase mockInitDefaultCategoriesUseCase;

  setUp(() {
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetCategoryByIdUseCase = MockGetCategoryByIdUseCase();
    mockAddCategoryUseCase = MockAddCategoryUseCase();
    mockUpdateCategoryUseCase = MockUpdateCategoryUseCase();
    mockDeleteCategoryUseCase = MockDeleteCategoryUseCase();
    mockInitDefaultCategoriesUseCase = MockInitDefaultCategoriesUseCase();

    categoryBloc = CategoryBloc(
      getCategoriesUseCase: mockGetCategoriesUseCase,
      getCategoryByIdUseCase: mockGetCategoryByIdUseCase,
      addCategoryUseCase: mockAddCategoryUseCase,
      updateCategoryUseCase: mockUpdateCategoryUseCase,
      deleteCategoryUseCase: mockDeleteCategoryUseCase,
      initDefaultCategoriesUseCase: mockInitDefaultCategoriesUseCase,
    );
  });

  tearDown(() {
    categoryBloc.close();
  });

  test('initial state should be CategoryInitial', () {
    expect(categoryBloc.state, isA<CategoryInitial>());
  });

  group('GetCategories', () {
    final categories = [
      const Category(
        id: 'test_category',
        name: 'Test Category',
        color: Colors.blue,
      ),
    ];

    test(
        'should emit [CategoryLoading, CategoryLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => categories);

      // act
      categoryBloc.add(const LoadCategories());

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryLoaded>(),
        ]),
      );
    });

    test('should emit [CategoryLoading, CategoryError] when getting data fails',
        () async {
      // arrange
      when(mockGetCategoriesUseCase.call())
          .thenThrow(Exception('Failed to get categories'));

      // act
      categoryBloc.add(const LoadCategories());

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryError>(),
        ]),
      );
    });
  });

  group('AddCategory', () {
    const category = Category(
      id: 'test_category',
      name: 'Test Category',
      color: Colors.blue,
    );

    test(
        'should emit [CategoryLoading, CategoryLoaded] when adding category successfully',
        () async {
      // arrange
      when(mockAddCategoryUseCase.call(any))
          .thenAnswer((_) async => 'Category added successfully');

      // act
      categoryBloc.add(const AddCategory(category));

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryOperationSuccess>(),
          isA<CategoryLoading>(),
          isA<CategoryLoaded>(),
        ]),
      );
    });

    test(
        'should emit [CategoryLoading, CategoryError] when adding category fails',
        () async {
      // arrange
      when(mockAddCategoryUseCase.call(any))
          .thenThrow(Exception('Failed to add category'));

      // act
      categoryBloc.add(const AddCategory(category));

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryError>(),
        ]),
      );
    });
  });

  group('UpdateCategory', () {
    const category = Category(
      id: 'test_category',
      name: 'Updated Category',
      color: Colors.red,
    );

    test(
        'should emit [CategoryLoading, CategoryLoaded] when updating category successfully',
        () async {
      // arrange
      when(mockUpdateCategoryUseCase.call(any))
          .thenAnswer((_) async => 'Category updated successfully');

      // act
      categoryBloc.add(const UpdateCategory(category));

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryOperationSuccess>(),
          isA<CategoryLoading>(),
          isA<CategoryLoaded>(),
        ]),
      );
    });

    test(
        'should emit [CategoryLoading, CategoryError] when updating category fails',
        () async {
      // arrange
      when(mockUpdateCategoryUseCase.call(any))
          .thenThrow(Exception('Failed to update category'));

      // act
      categoryBloc.add(const UpdateCategory(category));

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryError>(),
        ]),
      );
    });
  });

  group('DeleteCategory', () {
    const categoryId = 'test_category';

    test(
        'should emit [CategoryLoading, CategoryLoaded] when deleting category successfully',
        () async {
      // arrange
      when(mockDeleteCategoryUseCase.call(any))
          .thenAnswer((_) async => 'Category deleted successfully');

      // act
      categoryBloc.add(const DeleteCategory(categoryId));

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryOperationSuccess>(),
          isA<CategoryLoading>(),
          isA<CategoryLoaded>(),
        ]),
      );
    });
  });

  group('InitDefaultCategories', () {
    final defaultCategories = [
      const Category(
        id: 'work',
        name: 'Work',
        color: Colors.blue,
      ),
      const Category(
        id: 'personal',
        name: 'Personal',
        color: Colors.green,
      ),
    ];

    test(
        'should emit [CategoryLoading, CategoryLoaded] when initializing default categories successfully',
        () async {
      // arrange
      when(mockInitDefaultCategoriesUseCase.call())
          .thenAnswer((_) async => defaultCategories);
      when(mockGetCategoriesUseCase.call())
          .thenAnswer((_) async => defaultCategories);

      // act
      categoryBloc.add(const InitDefaultCategories());

      // assert
      await expectLater(
        categoryBloc.stream,
        emitsInOrder([
          isA<CategoryLoading>(),
          isA<CategoryLoaded>(),
        ]),
      );
    });
  });
}
