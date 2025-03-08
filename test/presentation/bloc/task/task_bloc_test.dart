import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_and_weather/domain/entities/task.dart';
import 'package:to_do_and_weather/domain/usecases/task_usecases.dart';
import 'package:to_do_and_weather/presentation/bloc/task/task_bloc.dart';
import 'package:to_do_and_weather/presentation/bloc/task/task_event.dart';
import 'package:to_do_and_weather/presentation/bloc/task/task_state.dart';
import 'task_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetTasksUseCase>(),
  MockSpec<AddTaskUseCase>(),
  MockSpec<UpdateTaskUseCase>(),
  MockSpec<DeleteTaskUseCase>(),
  MockSpec<GetTasksByCategoryIdUseCase>(),
  MockSpec<GetCompletedTasksUseCase>(),
  MockSpec<GetIncompleteTasksUseCase>(),
  MockSpec<GetTaskByIdUseCase>(),
])
void main() {
  late TaskBloc taskBloc;
  late MockGetTasksUseCase mockGetTasksUseCase;
  late MockAddTaskUseCase mockAddTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockGetTasksByCategoryIdUseCase mockGetTasksByCategoryIdUseCase;
  late MockGetCompletedTasksUseCase mockGetCompletedTasksUseCase;
  late MockGetIncompleteTasksUseCase mockGetIncompleteTasksUseCase;
  late MockGetTaskByIdUseCase mockGetTaskByIdUseCase;

  setUp(() {
    mockGetTasksUseCase = MockGetTasksUseCase();
    mockAddTaskUseCase = MockAddTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockGetTasksByCategoryIdUseCase = MockGetTasksByCategoryIdUseCase();
    mockGetCompletedTasksUseCase = MockGetCompletedTasksUseCase();
    mockGetIncompleteTasksUseCase = MockGetIncompleteTasksUseCase();
    mockGetTaskByIdUseCase = MockGetTaskByIdUseCase();

    taskBloc = TaskBloc(
      getTasksUseCase: mockGetTasksUseCase,
      addTaskUseCase: mockAddTaskUseCase,
      updateTaskUseCase: mockUpdateTaskUseCase,
      deleteTaskUseCase: mockDeleteTaskUseCase,
      getTasksByCategoryIdUseCase: mockGetTasksByCategoryIdUseCase,
      getCompletedTasksUseCase: mockGetCompletedTasksUseCase,
      getIncompleteTasksUseCase: mockGetIncompleteTasksUseCase,
      getTaskByIdUseCase: mockGetTaskByIdUseCase,
    );
  });

  tearDown(() {
    taskBloc.close();
  });

  test('initial state should be TaskInitial', () {
    expect(taskBloc.state, isA<TaskInitial>());
  });

  group('GetTasks', () {
    final tasks = [
      Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: false,
        categoryId: 'test_category',
        createdAt: DateTime.now(),
      ),
    ];

    test(
        'should emit [TaskLoading, TaskLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTasksUseCase.call()).thenAnswer((_) async => tasks);

      // act
      taskBloc.add(const LoadTasks());

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskLoaded>(),
        ]),
      );
    });

    test('should emit [TaskLoading, TaskError] when getting data fails',
        () async {
      // arrange
      when(mockGetTasksUseCase.call())
          .thenThrow(Exception('Failed to get tasks'));

      // act
      taskBloc.add(const LoadTasks());

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskError>(),
        ]),
      );
    });
  });

  group('AddTask', () {
    final task = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      isCompleted: false,
      categoryId: 'test_category',
      createdAt: DateTime.now(),
    );

    test('should emit [TaskLoading, TaskLoaded] when adding task successfully',
        () async {
      // arrange
      when(mockAddTaskUseCase.call(any))
          .thenAnswer((_) async => 'Task added successfully');

      // act
      taskBloc.add(AddTask(task));

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskOperationSuccess>(),
          isA<TaskLoading>(),
          isA<TaskLoaded>(),
        ]),
      );
    });

    test('should emit [TaskLoading, TaskError] when adding task fails',
        () async {
      // arrange
      when(mockAddTaskUseCase.call(any))
          .thenThrow(Exception('Failed to add task'));

      // act
      taskBloc.add(AddTask(task));

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskError>(),
        ]),
      );
    });
  });

  group('UpdateTask', () {
    final task = Task(
      id: '1',
      title: 'Updated Task',
      description: 'Updated Description',
      isCompleted: true,
      categoryId: 'test_category',
      createdAt: DateTime.now(),
    );

    test(
        'should emit [TaskLoading, TaskLoaded] when updating task successfully',
        () async {
      // arrange
      when(mockUpdateTaskUseCase.call(any))
          .thenAnswer((_) async => 'Task updated successfully');

      // act
      taskBloc.add(UpdateTask(task));

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskOperationSuccess>(),
          isA<TaskLoading>(),
          isA<TaskLoaded>(),
        ]),
      );
    });

    test('should emit [TaskLoading, TaskError] when updating task fails',
        () async {
      // arrange
      when(mockUpdateTaskUseCase.call(any))
          .thenThrow(Exception('Failed to update task'));

      // act
      taskBloc.add(UpdateTask(task));

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskError>(),
        ]),
      );
    });
  });

  group('DeleteTask', () {
    const taskId = '1';

    test(
        'should emit [TaskLoading, TaskLoaded] when deleting task successfully',
        () async {
      // arrange
      when(mockDeleteTaskUseCase.call(any))
          .thenAnswer((_) async => 'Task deleted successfully');

      // act
      taskBloc.add(const DeleteTask(taskId));

      // assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoading>(),
          isA<TaskOperationSuccess>(),
          isA<TaskLoading>(),
          isA<TaskLoaded>(),
        ]),
      );
    });
  });
}
