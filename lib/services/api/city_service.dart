import 'dart:convert';
import 'package:first/core/app_imports.dart';

class CityModel {
  final int cityId;
  final int countryId;
  final String cityName;

  CityModel({
    required this.cityId,
    required this.countryId,
    required this.cityName,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['cityId'],
      countryId: json['countryId'],
      cityName: json['cityName'],
    );
  }
}

class CityService {
  // Updated API endpoint to match your requirement: api/city
  // static const String _baseUrl = 'https://your-api.com/api/city';

  /// Fetches the list of cities from the API.
  /// Returns a Future because network calls are asynchronous.

  final ApiClient _apiClient = ApiClient();

  Future<List<CityModel>> fetchCities() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response = await _apiClient.dio.get('/api/city');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is String
            ? json.decode(response.data)
            : response.data;
        return data.map((json) => CityModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      rethrow;
    }
  }
}
