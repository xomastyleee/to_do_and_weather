import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../models/coordinates_model.dart';
import '../models/weather_model.dart';

/// Remote data source for weather using OpenWeatherMap API
class WeatherRemoteDataSource {
  final http.Client _client;

  WeatherRemoteDataSource(this._client);

  /// Get coordinates for a city name using Geocoding API
  Future<CoordinatesModel> getCoordinates(String cityName) async {
    try {
      final url = Uri.parse(
        '${AppConstants.geocodingApiBaseUrl}/direct?q=$cityName&limit=1&appid=${AppConstants.weatherApiKey}',
      );

      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          return CoordinatesModel.defaultCoordinates();
        }
        final locationData = data.first;
        locationData['name'] = cityName;
        return CoordinatesModel.fromJson(locationData);
      } else {
        return CoordinatesModel.defaultCoordinates();
      }
    } catch (e) {
      return CoordinatesModel.defaultCoordinates();
    }
  }

  /// Get current weather for a city
  Future<WeatherModel> getCurrentWeather(String city) async {
    // For One Call API 3.0, we need coordinates instead of city name
    // In a real app, we would use Geocoding API to convert city to coordinates
    // For simplicity, we'll use default coordinates for Kyiv if city is default
    final coordinates = await getCoordinates(city);

    // Build the URL for One Call API 3.0
    final url = Uri.parse(
      '${AppConstants.weatherApiBaseUrl}/onecall?lat=${coordinates.lat}&lon=${coordinates.lon}&exclude=minutely,hourly,daily,alerts&units=${AppConstants.weatherUnits}&appid=${AppConstants.weatherApiKey}',
    );

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Add city name to the response since One Call API doesn't return it
      data['name'] = coordinates.name;
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
