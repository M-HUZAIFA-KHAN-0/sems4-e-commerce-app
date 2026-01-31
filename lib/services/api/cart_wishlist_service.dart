import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';
import 'package:first/services/user_session_manager.dart';

class CartWishlistService {
  final ApiClient _apiClient = ApiClient();
  final UserSessionManager _sessionManager = UserSessionManager();

  /// Initialize cart and wishlist IDs after user logs in
  /// Calls both cart and wishlist APIs to get/create the IDs
  Future<Map<String, dynamic>> initializeCartAndWishlist(int userId) async {
    try {
      print('=== INITIALIZING CART AND WISHLIST ===');

      // Call both APIs in parallel
      final results = await Future.wait([
        _fetchOrCreateCart(userId),
        _fetchOrCreateWishlist(userId),
      ], eagerError: true);

      final cartResult = results[0];
      final wishlistResult = results[1];

      print('Cart result: $cartResult');
      print('Wishlist result: $wishlistResult');

      // Extract and store cart ID
      var cartId = cartResult['cartId'];
      print('📦 [CartWishlistService] cartResult keys: ${cartResult.keys}');
      print(
        '📦 [CartWishlistService] cartId value: $cartId, type: ${cartId.runtimeType}',
      );

      if (cartId != null) {
        final parsedCartId = cartId is int
            ? cartId
            : int.parse(cartId.toString());
        _sessionManager.setCartId(parsedCartId);
        print('✅ Cart ID stored in session: $parsedCartId');
        print('✅ Verify from session: ${_sessionManager.cartId}');
      } else {
        print('❌ cartId is null in cart result');
      }

      // Extract and store wishlist ID
      final wishlistId = wishlistResult['wishlistId'];
      if (wishlistId != null) {
        final parsedWishlistId = wishlistId is int
            ? wishlistId
            : int.parse(wishlistId.toString());
        _sessionManager.setWishlistId(parsedWishlistId);
        print('✅ Wishlist ID stored: $parsedWishlistId');
      } else {
        print('⚠️ WARNING: wishlistId is null in result: $wishlistResult');
      }

      return {'success': true, 'cartId': cartId, 'wishlistId': wishlistId};
    } catch (e) {
      print('❌ Error initializing cart and wishlist: $e');
      return {
        'success': false,
        'message': 'Failed to initialize cart and wishlist',
        'error': e.toString(),
      };
    }
  }

  /// Fetch or create cart for user
  Future<Map<String, dynamic>> _fetchOrCreateCart(int userId) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/Cart',
        data: {'UserId': userId},
      );

      print('=== CART API RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      print('Data type: ${response.data.runtimeType}');
      if (response.data is Map) {
        print('Data keys: ${(response.data as Map).keys}');
      }

      // Extract cartId from response regardless of status code
      // Backend may return 400 with "Cart already exists" but still include cartId
      final responseData = response.data is Map ? response.data : {};
      final cartId =
          responseData['cartId'] ??
          responseData['id'] ??
          responseData['CartId'];

      if (cartId != null) {
        print('📦 Extracted cartId: $cartId');
        return {
          'success': true,
          'cartId': cartId,
          'message': responseData['message'] ?? 'Cart retrieved/created',
        };
      } else {
        print('❌ No cartId in response');
        return {'success': false, 'message': 'Failed to fetch cart'};
      }
    } on DioException catch (e) {
      print('Cart API error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      // Try to extract cartId from error response
      if (e.response?.data is Map) {
        final responseData = e.response!.data as Map<String, dynamic>;
        final cartId =
            responseData['cartId'] ??
            responseData['id'] ??
            responseData['CartId'];
        if (cartId != null) {
          return {
            'success': true,
            'cartId': cartId,
            'message': responseData['message'] ?? 'Cart already exists',
          };
        }
      }

      rethrow;
    }
  }

  /// Fetch or create wishlist for user
  Future<Map<String, dynamic>> _fetchOrCreateWishlist(int userId) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/Wishlist/Create/$userId',
      );

      print('=== WISHLIST API RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      // Extract wishlistId from response regardless of HTTP status
      if (response.data is Map) {
        final responseData = response.data as Map<String, dynamic>;
        final wishlistId = responseData['wishlistId'];

        if (wishlistId != null) {
          print('✅ Wishlist ID extracted: $wishlistId');
          return {
            'success': true,
            'wishlistId': wishlistId,
            'message':
                responseData['message'] ??
                responseData['error'] ??
                'Wishlist retrieved/created',
          };
        }
      }

      // If no wishlistId found
      print('❌ No wishlistId found in response');
      return {'success': false, 'message': 'Failed to retrieve wishlist ID'};
    } catch (e) {
      print('❌ Error in _fetchOrCreateWishlist: $e');
      rethrow;
    }
  }
}
