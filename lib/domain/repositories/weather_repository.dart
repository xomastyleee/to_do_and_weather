import '../entities/weather.dart';

/// Interface for weather repository
abstract class WeatherRepository {
  /// Get current weather for a city
  Future<Weather> getCurrentWeather(String city);
}
