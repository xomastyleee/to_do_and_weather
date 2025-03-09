import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'core/utils/color_adapter.dart';
import 'data/datasources/category_local_data_source.dart';
import 'data/datasources/task_local_data_source.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/models/category_model.dart';
import 'data/models/task_model.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/repositories/task_repository_impl.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/task_repository.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/category_usecases.dart';
import 'domain/usecases/task_usecases.dart';
import 'domain/usecases/weather_usecases.dart';
import 'presentation/bloc/category/category_bloc.dart';
import 'presentation/bloc/task/task_bloc.dart';
import 'presentation/bloc/weather/weather_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ColorAdapter());

  // Initialize data sources
  final taskLocalDataSource = await TaskLocalDataSource.init();
  final categoryLocalDataSource = await CategoryLocalDataSource.init();
  final weatherRemoteDataSource = WeatherRemoteDataSource(http.Client());

  // Initialize repositories
  final TaskRepository taskRepository = TaskRepositoryImpl(taskLocalDataSource);
  final CategoryRepository categoryRepository =
      CategoryRepositoryImpl(categoryLocalDataSource);
  final WeatherRepository weatherRepository =
      WeatherRepositoryImpl(weatherRemoteDataSource);

  // Initialize use cases
  final getTasksUseCase = GetTasksUseCase(taskRepository);
  final getTaskByIdUseCase = GetTaskByIdUseCase(taskRepository);
  final addTaskUseCase = AddTaskUseCase(taskRepository);
  final updateTaskUseCase = UpdateTaskUseCase(taskRepository);
  final deleteTaskUseCase = DeleteTaskUseCase(taskRepository);
  final getTasksByCategoryIdUseCase =
      GetTasksByCategoryIdUseCase(taskRepository);
  final getCompletedTasksUseCase = GetCompletedTasksUseCase(taskRepository);
  final getIncompleteTasksUseCase = GetIncompleteTasksUseCase(taskRepository);

  final getCategoriesUseCase = GetCategoriesUseCase(categoryRepository);
  final getCategoryByIdUseCase = GetCategoryByIdUseCase(categoryRepository);
  final addCategoryUseCase = AddCategoryUseCase(categoryRepository);
  final updateCategoryUseCase = UpdateCategoryUseCase(categoryRepository);
  final deleteCategoryUseCase = DeleteCategoryUseCase(categoryRepository);
  final initDefaultCategoriesUseCase =
      InitDefaultCategoriesUseCase(categoryRepository);

  final getCurrentWeatherUseCase = GetCurrentWeatherUseCase(weatherRepository);

  runApp(MyApp(
    taskBloc: TaskBloc(
      getTasksUseCase: getTasksUseCase,
      getTaskByIdUseCase: getTaskByIdUseCase,
      addTaskUseCase: addTaskUseCase,
      updateTaskUseCase: updateTaskUseCase,
      deleteTaskUseCase: deleteTaskUseCase,
      getTasksByCategoryIdUseCase: getTasksByCategoryIdUseCase,
      getCompletedTasksUseCase: getCompletedTasksUseCase,
      getIncompleteTasksUseCase: getIncompleteTasksUseCase,
    ),
    categoryBloc: CategoryBloc(
      getCategoriesUseCase: getCategoriesUseCase,
      getCategoryByIdUseCase: getCategoryByIdUseCase,
      addCategoryUseCase: addCategoryUseCase,
      updateCategoryUseCase: updateCategoryUseCase,
      deleteCategoryUseCase: deleteCategoryUseCase,
      initDefaultCategoriesUseCase: initDefaultCategoriesUseCase,
    ),
    weatherBloc: WeatherBloc(
      getCurrentWeatherUseCase: getCurrentWeatherUseCase,
    ),
  ));
}

/// Main application widget
class MyApp extends StatelessWidget {
  final TaskBloc taskBloc;
  final CategoryBloc categoryBloc;
  final WeatherBloc weatherBloc;

  const MyApp({
    super.key,
    required this.taskBloc,
    required this.categoryBloc,
    required this.weatherBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => taskBloc,
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => categoryBloc,
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => weatherBloc,
        ),
      ],
      child: MaterialApp(
        title: 'To-Do & Weather',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
