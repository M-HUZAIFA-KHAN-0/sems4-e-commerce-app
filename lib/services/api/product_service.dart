import 'package:first/models/product_model.dart';
import 'package:first/models/product_detail_model.dart';
import 'package:first/services/api/api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();

  /// Fetch all products with their ratings
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _apiClient.dio.get('/api/Products/display');

      // Handle paginated API response
      Map<String, dynamic> responseData = {};
      List<dynamic> productList = [];

      if (response.data is Map) {
        responseData = response.data as Map<String, dynamic>;
        productList = (responseData['data'] as List?) ?? [];
      } else if (response.data is List) {
        productList = response.data as List;
      }

      List<ProductModel> products = [];

      for (var p in productList) {
        try {
          // averageRating is now in the API response, no need for extra call
          products.add(ProductModel.fromJson(p));
        } catch (e) {
          // If parsing fails, add product with 0 rating
          print('Error parsing product: $e');
          products.add(ProductModel.fromJson(p, rating: 0.0));
        }
      }

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  // *************************************************************
  // ********************* Product Detail ************************
  // *************************************************************

  /// ⭐ Fetch COMPLETE product details by ID (FOR DETAIL PAGE)
  /// Returns full variant, specification, and image data
  Future<ProductDetailModel?> fetchProductDetailById(int productId) async {
    try {
      final response = await _apiClient.dio.get('/api/Products/$productId');

      Map<String, dynamic> data = {};

      // Handle API response structure
      if (response.data is Map) {
        final dataMap = response.data as Map<String, dynamic>;

        // Check if response has 'data' wrapper
        if (dataMap.containsKey('data')) {
          if (dataMap['data'] is List && (dataMap['data'] as List).isNotEmpty) {
            data = (dataMap['data'] as List)[0] as Map<String, dynamic>;
          } else if (dataMap['data'] is Map) {
            data = dataMap['data'] as Map<String, dynamic>;
          }
        } else {
          // Direct response without wrapper
          data = dataMap;
        }
      } else if (response.data is List && (response.data as List).isNotEmpty) {
        data = (response.data as List)[0] as Map<String, dynamic>;
      }

      if (data.isEmpty) {
        print('❌ No product data found for ID: $productId');
        return null;
      }

      print('✅ Product detail loaded: ${data['productName']}');
      return ProductDetailModel.fromJson(data);
    } catch (e) {
      print('❌ Error fetching product detail $productId: $e');
      return null;
    }
  }

  // *************************************************************
  // ********************* Product View Logging ******************
  // *************************************************************

  /// Log that a user has viewed a product. This is a fire-and-forget call.
  Future<void> logProductView({
    required int productId,
    int? userId,
  }) async {
    try {
      print('📊 Logging product view for productId: $productId, userId: $userId');
      await _apiClient.dio.post(
        '/api/ProductView',
        data: {
          'productId': productId,
          'userId': userId,
        },
      );
      print('✅ Product view logged successfully.');
    } catch (e) {
      // Silently fail as this is not a critical user-facing feature
      print('⚠️ Failed to log product view: $e');
    }
  }

  // *************************************************************

  /// Fetch a single product by ID (LEGACY - returns simple ProductModel)
  Future<ProductModel?> fetchProductById(int productId) async {
    try {
      final response = await _apiClient.dio.get('/api/Products/$productId');

      Map<String, dynamic> data = {};

      // Handle paginated response
      if (response.data is Map) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap['data'] is List && (dataMap['data'] as List).isNotEmpty) {
          data = (dataMap['data'] as List)[0] as Map<String, dynamic>;
        } else if (dataMap['data'] is Map) {
          data = dataMap['data'] as Map<String, dynamic>;
        } else {
          data = dataMap;
        }
      } else if (response.data is List && (response.data as List).isNotEmpty) {
        data = (response.data as List)[0] as Map<String, dynamic>;
      }

      if (data.isEmpty) {
        print('No data found for product $productId');
        return null;
      }

      return ProductModel.fromJson(data);
    } catch (e) {
      print('Error fetching product $productId: $e');
      return null;
    }
  }

  /// Fetch products by category
  Future<List<ProductModel>> fetchProductsByCategory(
    String categoryName,
  ) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/Products',
        queryParameters: {'category': categoryName},
      );

      // Handle paginated API response
      Map<String, dynamic> responseData = {};
      List<dynamic> productList = [];

      if (response.data is Map) {
        responseData = response.data as Map<String, dynamic>;
        productList = (responseData['data'] as List?) ?? [];
      } else if (response.data is List) {
        productList = response.data as List;
      }

      List<ProductModel> products = [];

      for (var p in productList) {
        try {
          products.add(ProductModel.fromJson(p));
        } catch (e) {
          print('Error parsing product: $e');
          products.add(ProductModel.fromJson(p, rating: 0.0));
        }
      }

      return products;
    } catch (e) {
      print('Error fetching products by category: $e');
      rethrow;
    }
  }

  /// Search products
  Future<List<ProductModel>> searchProducts(String searchQuery) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/Products/search',
        queryParameters: {'q': searchQuery},
      );

      // Handle paginated API response
      Map<String, dynamic> responseData = {};
      List<dynamic> productList = [];

      if (response.data is Map) {
        responseData = response.data as Map<String, dynamic>;
        productList = (responseData['data'] as List?) ?? [];
      } else if (response.data is List) {
        productList = response.data as List;
      }

      List<ProductModel> products = [];

      for (var p in productList) {
        try {
          products.add(ProductModel.fromJson(p));
        } catch (e) {
          print('Error parsing product: $e');
          products.add(ProductModel.fromJson(p, rating: 0.0));
        }
      }

      return products;
    } catch (e) {
      print('Error searching products: $e');
      rethrow;
    }
  }
}
