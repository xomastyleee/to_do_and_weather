import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

/// Get current weather use case
class GetCurrentWeatherUseCase {
  final WeatherRepository _repository;

  GetCurrentWeatherUseCase(this._repository);

  Future<Weather> call(String city) async {
    return await _repository.getCurrentWeather(city);
  }
}
