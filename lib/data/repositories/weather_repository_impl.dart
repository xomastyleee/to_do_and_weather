import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

/// Implementation of WeatherRepository using remote data source
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl(this._remoteDataSource);

  @override
  Future<Weather> getCurrentWeather(String city) async {
    try {
      final weatherModel = await _remoteDataSource.getCurrentWeather(city);
      return weatherModel.toEntity();
    } catch (e) {
      throw Exception('Failed to get weather: $e');
    }
  }
}
