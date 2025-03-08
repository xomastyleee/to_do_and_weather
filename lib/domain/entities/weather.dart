import 'package:equatable/equatable.dart';

/// Entity representing weather information in the application
class Weather extends Equatable {
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String description;
  final String icon;
  final String cityName;
  final DateTime timestamp;

  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.cityName,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        temperature,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        description,
        icon,
        cityName,
        timestamp,
      ];
}
