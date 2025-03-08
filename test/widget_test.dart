// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_and_weather/data/datasources/category_local_data_source.dart';
import 'package:to_do_and_weather/data/datasources/task_local_data_source.dart';
import 'package:to_do_and_weather/data/datasources/weather_remote_data_source.dart';
import 'package:to_do_and_weather/data/repositories/category_repository_impl.dart';
import 'package:to_do_and_weather/data/repositories/task_repository_impl.dart';
import 'package:to_do_and_weather/data/repositories/weather_repository_impl.dart';
import 'package:to_do_and_weather/domain/usecases/category_usecases.dart';
import 'package:to_do_and_weather/domain/usecases/task_usecases.dart';
import 'package:to_do_and_weather/domain/usecases/weather_usecases.dart';
import 'package:to_do_and_weather/presentation/bloc/category/category_bloc.dart';
import 'package:to_do_and_weather/presentation/bloc/task/task_bloc.dart';
import 'package:to_do_and_weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:to_do_and_weather/presentation/pages/home_page.dart';
import 'package:to_do_and_weather/core/utils/color_adapter.dart';
import 'widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TaskBloc taskBloc;
  late CategoryBloc categoryBloc;
  late WeatherBloc weatherBloc;
  late MockClient mockHttpClient;

  setUpAll(() async {
    // Initialize Hive for testing
    Hive.init('./test/hive_testing_path');
    Hive.registerAdapter(ColorAdapter());
  });

  setUp(() async {
    mockHttpClient = MockClient();

    final taskLocalDataSource = await TaskLocalDataSource.init();
    final categoryLocalDataSource = await CategoryLocalDataSource.init();
    final weatherRemoteDataSource = WeatherRemoteDataSource(mockHttpClient);

    final taskRepository = TaskRepositoryImpl(taskLocalDataSource);
    final categoryRepository = CategoryRepositoryImpl(categoryLocalDataSource);
    final weatherRepository = WeatherRepositoryImpl(weatherRemoteDataSource);

    taskBloc = TaskBloc(
      getTasksUseCase: GetTasksUseCase(taskRepository),
      getTaskByIdUseCase: GetTaskByIdUseCase(taskRepository),
      addTaskUseCase: AddTaskUseCase(taskRepository),
      updateTaskUseCase: UpdateTaskUseCase(taskRepository),
      deleteTaskUseCase: DeleteTaskUseCase(taskRepository),
      getTasksByCategoryIdUseCase: GetTasksByCategoryIdUseCase(taskRepository),
      getCompletedTasksUseCase: GetCompletedTasksUseCase(taskRepository),
      getIncompleteTasksUseCase: GetIncompleteTasksUseCase(taskRepository),
    );

    categoryBloc = CategoryBloc(
      getCategoriesUseCase: GetCategoriesUseCase(categoryRepository),
      getCategoryByIdUseCase: GetCategoryByIdUseCase(categoryRepository),
      addCategoryUseCase: AddCategoryUseCase(categoryRepository),
      updateCategoryUseCase: UpdateCategoryUseCase(categoryRepository),
      deleteCategoryUseCase: DeleteCategoryUseCase(categoryRepository),
      initDefaultCategoriesUseCase:
          InitDefaultCategoriesUseCase(categoryRepository),
    );

    weatherBloc = WeatherBloc(
      getCurrentWeatherUseCase: GetCurrentWeatherUseCase(weatherRepository),
    );
  });

  tearDownAll(() async {
    // Clean up Hive boxes
    await Hive.deleteFromDisk();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Mock weather data
    when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          '{"current":{"temp":20,"feels_like":22,"pressure":1013,"humidity":65},"weather":[{"description":"Clear sky","icon":"01d"}]}',
          200,
        ));

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(create: (context) => taskBloc),
          BlocProvider<CategoryBloc>(create: (context) => categoryBloc),
          BlocProvider<WeatherBloc>(create: (context) => weatherBloc),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Wait for initial data loading
    await tester.pump();

    // Check if main UI elements are displayed
    expect(find.text('To-Do & Weather'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Check if filter button is present
    expect(find.byIcon(Icons.filter_list), findsOneWidget);

    // Tap the filter button to show the menu
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pump();

    // Check if filter options are present in the menu
    expect(find.text('All Tasks'), findsOneWidget);
    expect(find.text('Completed Tasks'), findsOneWidget);
    expect(find.text('Incomplete Tasks'), findsOneWidget);
  });
}
