import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/usecases/weather_usecases.dart';
import 'weather_event.dart';
import 'weather_state.dart';

/// BLoC for managing weather state
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
  })  : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(const WeatherInitial()) {
    on<LoadWeather>(_onLoadWeather);
  }

  /// Handle LoadWeather event
  Future<void> _onLoadWeather(
      LoadWeather event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading());
    try {
      final city = event.city.isEmpty ? AppConstants.defaultCity : event.city;
      final weather = await _getCurrentWeatherUseCase(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
