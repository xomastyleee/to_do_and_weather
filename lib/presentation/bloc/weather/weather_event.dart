import 'package:equatable/equatable.dart';

/// Base class for all weather events
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load weather for a city
class LoadWeather extends WeatherEvent {
  final String city;

  const LoadWeather(this.city);

  @override
  List<Object?> get props => [city];
}
