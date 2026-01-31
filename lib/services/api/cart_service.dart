import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';

class CartService {
  final ApiClient _apiClient = ApiClient();

  /// Get cart by user ID (creates if doesn't exist)
  Future<Map<String, dynamic>?> getCartByUserId({required int userId}) async {
    try {
      final response = await _apiClient.dio.get('/api/CartItem/user/$userId');

      if (response.statusCode == 200 && response.data is Map) {
        final cartData = response.data as Map<String, dynamic>;
        print('📦 Cart fetched successfully for user $userId');
        print('   Subtotal: ${cartData['subtotal']}');
        print('   Total Items: ${cartData['totalItems']}');
        return cartData;
      }
      return null;
    } catch (e) {
      print('❌ Error fetching cart: $e');
      return null;
    }
  }

  /// Get cart items by cart ID
  Future<Map<String, dynamic>?> getCartItemsByCartId({
    required int cartId,
  }) async {
    try {
      final response = await _apiClient.dio.get('/api/CartItem/cart/$cartId');

      if (response.statusCode == 200 && response.data is Map) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('❌ Error fetching cart items: $e');
      return null;
    }
  }

  /// Add item to cart
  /// variantSpecificationOptionsId is for color/size specifications
  Future<Map<String, dynamic>?> addItemToCart({
    required int cartId,
    required int variantId,
    required int quantity,
    int? variantSpecificationOptionsId,
  }) async {
    try {
      final requestData = {
        'cartId': cartId,
        'variantId': variantId,
        'quantity': quantity,
        'variantSpecificationOptionsId': variantSpecificationOptionsId,
      };

      print(
        '📤 [CartService] Posting to /api/CartItem with data: $requestData',
      );

      final response = await _apiClient.dio.post(
        '/api/CartItem',
        data: requestData,
      );

      print('📤 [CartService] POST Response Status: ${response.statusCode}');
      print('📤 [CartService] POST Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data is Map) {
        final responseData = response.data as Map<String, dynamic>;
        print('✅ Item added to cart: ${responseData['message']}');
        return responseData;
      } else if (response.statusCode == 201 && response.data is Map) {
        // Handle 201 Created response
        final responseData = response.data as Map<String, dynamic>;
        print('✅ Item added to cart (201): ${responseData}');
        return responseData;
      }
      print('⚠️ Unexpected response status: ${response.statusCode}');
      return null;
    } on DioException catch (e) {
      print('❌ [CartService] DioException adding to cart: ${e.message}');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');
      print('   Response Headers: ${e.response?.headers}');
      return null;
    } catch (e) {
      print('❌ [CartService] Error adding to cart: $e');
      return null;
    }
  }

  /// Update cart item quantity
  Future<Map<String, dynamic>?> updateCartItem({
    required int cartItemId,
    required int quantity,
    int? variantSpecificationOptionsId,
  }) async {
    try {
      if (quantity <= 0) {
        print('❌ Quantity must be > 0');
        return null;
      }

      final requestData = {
        'quantity': quantity,
        'variantSpecificationOptionsId': variantSpecificationOptionsId,
      };

      print('📝 Updating cart item $cartItemId: quantity=$quantity');

      final response = await _apiClient.dio.put(
        '/api/CartItem/$cartItemId',
        data: requestData,
      );

      if (response.statusCode == 200 && response.data is Map) {
        final responseData = response.data as Map<String, dynamic>;
        print('✅ Cart item updated: ${responseData['message']}');
        return responseData;
      }
      return null;
    } catch (e) {
      print('❌ Error updating cart item: $e');
      return null;
    }
  }

  /// Delete single cart item
  Future<bool> deleteCartItem({required int cartItemId}) async {
    try {
      print('🗑️ Deleting cart item $cartItemId');

      final response = await _apiClient.dio.delete('/api/CartItem/$cartItemId');

      if (response.statusCode == 200) {
        print('✅ Cart item deleted successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error deleting cart item: $e');
      return false;
    }
  }

  /// Delete multiple cart items
  Future<bool> deleteMultipleCartItems({required List<int> cartItemIds}) async {
    try {
      print('🗑️ Deleting ${cartItemIds.length} cart items');

      final results = await Future.wait(
        cartItemIds.map((id) => deleteCartItem(cartItemId: id)),
      );

      final allDeleted = results.every((result) => result);
      if (allDeleted) {
        print('✅ All cart items deleted successfully');
      }
      return allDeleted;
    } catch (e) {
      print('❌ Error deleting multiple items: $e');
      return false;
    }
  }

  /// Clear entire cart
  Future<bool> clearCart({required int cartId}) async {
    try {
      print('🗑️ Clearing entire cart $cartId');

      final response = await _apiClient.dio.delete(
        '/api/CartItem/clear/$cartId',
      );

      if (response.statusCode == 200) {
        print('✅ Cart cleared successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error clearing cart: $e');
      return false;
    }
  }
}
