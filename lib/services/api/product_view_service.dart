import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';

class ProductViewDTO {
  final int viewId;
  final int productId;
  final String productName;
  final String? productImage;
  final double originalPrice;
  final double discountPrice;
  final double discountPercentage;
  final bool isDiscounted;
  final int userId;
  final String username;
  final DateTime viewedAt;

  ProductViewDTO({
    required this.viewId,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.isDiscounted,
    required this.userId,
    required this.username,
    required this.viewedAt,
  });

  factory ProductViewDTO.fromJson(Map<String, dynamic> json) {
    return ProductViewDTO(
      viewId: json['viewId'] ?? 0,
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? 'Unknown',
      productImage: json['productImage'],
      originalPrice:
          double.tryParse(json['originalPrice']?.toString() ?? '0') ?? 0,
      discountPrice:
          double.tryParse(json['discountPrice']?.toString() ?? '0') ?? 0,
      discountPercentage:
          double.tryParse(json['discountPercentage']?.toString() ?? '0') ?? 0,
      isDiscounted: json['isDiscounted'] ?? false,
      userId: json['userId'] ?? 0,
      username: json['username'] ?? 'Guest',
      viewedAt: json['viewedAt'] != null
          ? DateTime.parse(json['viewedAt'] as String)
          : DateTime.now(),
    );
  }
}

class ProductViewService {
  final ApiClient _apiClient = ApiClient();

  /// Fetch all product views
  /// GET: /api/ProductView
  Future<List<ProductViewDTO>?> getAllProductViews() async {
    try {
      print('📺 [ProductViewService] Fetching all product views');

      final response = await _apiClient.dio.get('/api/ProductView');

      print('📺 [ProductViewService] Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data is List) {
        final views = (response.data as List)
            .map(
              (item) => ProductViewDTO.fromJson(item as Map<String, dynamic>),
            )
            .toList();

        print('✅ [ProductViewService] Fetched ${views.length} product views');
        return views;
      }

      print('❌ [ProductViewService] Invalid response: ${response.statusCode}');
      return null;
    } on DioException catch (e) {
      print('❌ [ProductViewService] DioException: ${e.message}');
      print('   Status: ${e.response?.statusCode}');
      print('   Response: ${e.response?.data}');
      return null;
    }
  }

  /// Filter product views - exclude discounted products
  List<ProductViewDTO> filterNonDiscounted(List<ProductViewDTO> views) {
    return views.where((view) => !view.isDiscounted).toList();
  }

  /// Filter product views by days
  List<ProductViewDTO> filterByDays(List<ProductViewDTO> views, int days) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return views.where((view) => view.viewedAt.isAfter(cutoffDate)).toList();
  }

  /// Get recent non-discounted views (carousel)
  /// Can work with a pre-fetched list or fetch fresh
  List<ProductViewDTO> getRecentNonDiscountedViews(
    List<ProductViewDTO> views, {
    int limit = 10,
  }) {
    final nonDiscounted = filterNonDiscounted(views);
    return nonDiscounted.take(limit).toList();
  }
}
