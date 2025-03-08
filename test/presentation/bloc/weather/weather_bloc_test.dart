import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_and_weather/domain/entities/weather.dart';
import 'package:to_do_and_weather/domain/usecases/weather_usecases.dart';
import 'package:to_do_and_weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:to_do_and_weather/presentation/bloc/weather/weather_event.dart';
import 'package:to_do_and_weather/presentation/bloc/weather/weather_state.dart';
import 'weather_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetCurrentWeatherUseCase>()])
void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc =
        WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
  });

  tearDown(() {
    weatherBloc.close();
  });

  test('initial state should be WeatherInitial', () {
    expect(weatherBloc.state, isA<WeatherInitial>());
  });

  group('GetCurrentWeather', () {
    final weather = Weather(
      temperature: 20.0,
      feelsLike: 22.0,
      tempMin: 18.0,
      tempMax: 25.0,
      pressure: 1013,
      humidity: 65,
      description: 'Clear sky',
      icon: '01d',
      cityName: 'Test City',
      timestamp: DateTime.now(),
    );

    test(
        'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => weather);

      // act
      weatherBloc.add(const LoadWeather('Kyiv'));

      // assert
      await expectLater(
        weatherBloc.stream,
        emitsInOrder([
          isA<WeatherLoading>(),
          isA<WeatherLoaded>(),
        ]),
      );
    });

    test('should emit [WeatherLoading, WeatherError] when getting data fails',
        () async {
      // arrange
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenThrow(Exception('Failed to get weather'));

      // act
      weatherBloc.add(const LoadWeather('Kyiv'));

      // assert
      await expectLater(
        weatherBloc.stream,
        emitsInOrder([
          isA<WeatherLoading>(),
          isA<WeatherError>(),
        ]),
      );
    });
  });
}
