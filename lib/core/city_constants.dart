import 'package:first/services/api/city_service.dart';

/// City constants for dropdown selector
class CityConstants {
  static List<CityModel> cities = [];

  static Future<void> initialize() async {
    try {
      final service = CityService();
      cities = await service.fetchCities();
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }
}
