import 'package:equatable/equatable.dart';
import '../../../domain/entities/weather.dart';

/// Base class for all weather states
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

/// Loading state
class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

/// Loaded state with weather data
class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}

/// Error state
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
