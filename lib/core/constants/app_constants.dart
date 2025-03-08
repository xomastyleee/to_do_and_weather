import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Constants used throughout the application
class AppConstants {
  // Hive box names
  static const String tasksBoxName = 'tasks';
  static const String categoriesBoxName = 'categories';

  // Weather API
  static const String weatherApiBaseUrl =
      'https://api.openweathermap.org/data/3.0';
  static const String geocodingApiBaseUrl =
      'https://api.openweathermap.org/geo/1.0';
  static String get weatherApiKey => dotenv.env['WEATHER_API_KEY'] ?? '';
  static const String weatherIconBaseUrl = 'https://openweathermap.org/img/wn/';
  static const String defaultCity = 'Kyiv';
  static const String weatherUnits = 'metric'; // Use Celsius

  // Default coordinates for Kyiv
  static const double defaultLat = 50.4501; // Kyiv latitude
  static const double defaultLon = 30.5234; // Kyiv longitude

  // Default categories
  static const String workCategoryId = 'work';
  static const String personalCategoryId = 'personal';
  static const String shoppingCategoryId = 'shopping';
  static const String healthCategoryId = 'health';

  // UI constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 8.0;

  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}
