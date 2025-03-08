// Mocks generated by Mockito 5.4.4 from annotations
// in to_do_and_weather/test/presentation/bloc/task/task_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:to_do_and_weather/domain/entities/task.dart' as _i4;
import 'package:to_do_and_weather/domain/usecases/task_usecases.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [GetTasksUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTasksUseCase extends _i1.Mock implements _i2.GetTasksUseCase {
  @override
  _i3.Future<List<_i4.Task>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);
}

/// A class which mocks [AddTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTaskUseCase extends _i1.Mock implements _i2.AddTaskUseCase {
  @override
  _i3.Future<void> call(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [task],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [UpdateTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateTaskUseCase extends _i1.Mock implements _i2.UpdateTaskUseCase {
  @override
  _i3.Future<void> call(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [task],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [DeleteTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTaskUseCase extends _i1.Mock implements _i2.DeleteTaskUseCase {
  @override
  _i3.Future<void> call(String? id) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [GetTasksByCategoryIdUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTasksByCategoryIdUseCase extends _i1.Mock
    implements _i2.GetTasksByCategoryIdUseCase {
  @override
  _i3.Future<List<_i4.Task>> call(String? categoryId) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [categoryId],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);
}

/// A class which mocks [GetCompletedTasksUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCompletedTasksUseCase extends _i1.Mock
    implements _i2.GetCompletedTasksUseCase {
  @override
  _i3.Future<List<_i4.Task>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);
}

/// A class which mocks [GetIncompleteTasksUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetIncompleteTasksUseCase extends _i1.Mock
    implements _i2.GetIncompleteTasksUseCase {
  @override
  _i3.Future<List<_i4.Task>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);
}

/// A class which mocks [GetTaskByIdUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskByIdUseCase extends _i1.Mock
    implements _i2.GetTaskByIdUseCase {
  @override
  _i3.Future<_i4.Task?> call(String? id) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [id],
        ),
        returnValue: _i3.Future<_i4.Task?>.value(),
        returnValueForMissingStub: _i3.Future<_i4.Task?>.value(),
      ) as _i3.Future<_i4.Task?>);
}
