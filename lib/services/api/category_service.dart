import 'package:first/services/api/api_client.dart';
import 'package:first/models/category_model.dart';

class CategoryService {
  final ApiClient _apiClient = ApiClient();

  /// Fetch all categories (Tree structure)
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _apiClient.dio.get('/api/Category');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
