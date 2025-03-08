import '../../core/constants/app_constants.dart';

/// Model for storing geographical coordinates
class CoordinatesModel {
  final double lat;
  final double lon;
  final String name;

  CoordinatesModel({
    required this.lat,
    required this.lon,
    required this.name,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      name: json['name'] as String,
    );
  }

  factory CoordinatesModel.defaultCoordinates() {
    return CoordinatesModel(
      lat: AppConstants.defaultLat,
      lon: AppConstants.defaultLon,
      name: AppConstants.defaultCity,
    );
  }
}
