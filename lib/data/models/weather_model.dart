import '../../domain/entities/weather.dart';

/// Data model for Weather entity, used for API responses
class WeatherModel extends Weather {
  const WeatherModel({
    required super.temperature,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.description,
    required super.icon,
    required super.cityName,
    required super.timestamp,
  });

  /// Creates a WeatherModel from a JSON map
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // One Call API 3.0 has a different structure
    final current = json['current'];
    final weather = current['weather'][0];

    return WeatherModel(
      temperature: (current['temp'] as num).toDouble(),
      feelsLike: (current['feels_like'] as num).toDouble(),
      // One Call API doesn't provide min/max in current weather
      // We'll use the same value for now
      tempMin: (current['temp'] as num).toDouble(),
      tempMax: (current['temp'] as num).toDouble(),
      pressure: current['pressure'] as int,
      humidity: current['humidity'] as int,
      description: weather['description'] as String,
      icon: weather['icon'] as String,
      cityName: json['name'] as String, // Added by our data source
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (current['dt'] as int) * 1000,
        isUtc: true,
      ).toLocal(),
    );
  }

  /// Creates a Weather entity from this model
  Weather toEntity() {
    return Weather(
      temperature: temperature,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      humidity: humidity,
      description: description,
      icon: icon,
      cityName: cityName,
      timestamp: timestamp,
    );
  }
}
