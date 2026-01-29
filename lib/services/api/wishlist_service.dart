import 'package:first/services/api/api_client.dart';

class WishlistService {
  final ApiClient _apiClient = ApiClient();

  /// Get user's complete wishlist with all items
  Future<Map<String, dynamic>?> getUserWishlist({required int userId}) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/WishlistItem/user/$userId',
      );

      print('=== GET WISHLIST RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200 && response.data is Map) {
        final wishlistData = response.data as Map<String, dynamic>;
        print('📋 Wishlist ID: ${wishlistData['wishlistId']}');
        print('👤 User ID: ${wishlistData['userId']}');

        final items = wishlistData['items'] as List?;
        if (items != null) {
          print('📦 Total items in wishlist: ${items.length}');
          for (var i = 0; i < items.length; i++) {
            final item = items[i] as Map<String, dynamic>;
            print('  Item ${i + 1}:');
            print('    - Variant ID: ${item['variantId']}');
            print('    - Product Name: ${item['productName']}');
            print('    - Price: ${item['price']}');
          }
        }

        return wishlistData;
      }
      return null;
    } catch (e) {
      print('❌ Error getting wishlist: $e');
      return null;
    }
  }

  /// Check if variant exists in user's wishlist
  Future<bool> isInWishlist({
    required int wishlistId,
    required int variantId,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/WishlistItem/wishlist/$wishlistId',
      );

      print('=== CHECK WISHLIST RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        // Handle response as Map with variantIds array
        if (response.data is Map) {
          final responseData = response.data as Map<String, dynamic>;
          final variantIds = responseData['variantIds'] as List?;

          if (variantIds != null) {
            final found = variantIds.contains(variantId);
            print('✓ Variant $variantId in wishlist: $found');
            return found;
          }
        }
      }
      return false;
    } catch (e) {
      print('❌ Error checking wishlist: $e');
      return false;
    }
  }

  /// Add variant to wishlist (backend expects UserId + VariantId)
  Future<bool> addToWishlist({
    required int userId,
    required int variantId,
  }) async {
    try {
      print('=== ADD TO WISHLIST REQUEST ===');
      print('User ID: $userId');
      print('Variant ID: $variantId');

      final response = await _apiClient.dio.post(
        '/api/WishlistItem',
        data: {'userId': userId, 'variantId': variantId},
      );

      print('=== ADD TO WISHLIST RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      // Handle both success (200/201) and "already exists" (400) cases
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Item added to wishlist');

        // Print wishlist items returned from API
        if (response.data is Map) {
          final wishlistData = response.data as Map<String, dynamic>;
          final items = wishlistData['items'] as List?;
          if (items != null) {
            print('📦 Wishlist now has ${items.length} items');
          }
        }
        return true;
      } else if (response.statusCode == 400) {
        // Check if error is "already exists"
        if (response.data is Map) {
          final responseData = response.data as Map<String, dynamic>;
          final errorMessage = responseData['error'] as String?;

          if (errorMessage != null && errorMessage.contains('already exists')) {
            print('✅ Item already exists in wishlist (treating as success)');
            return true; // Return true so heart turns red
          }
        }
        return false;
      }
      return false;
    } catch (e) {
      print('❌ Error adding to wishlist: $e');
      return false;
    }
  }

  /// Remove variant from wishlist
  Future<bool> removeFromWishlist({
    required int wishlistId,
    required int variantId,
  }) async {
    try {
      print('=== REMOVE FROM WISHLIST REQUEST ===');
      print('Wishlist ID: $wishlistId');
      print('Variant ID: $variantId');

      final response = await _apiClient.dio.delete(
        '/api/WishlistItem/wishlist/$wishlistId/variant/$variantId',
      );

      print('=== REMOVE FROM WISHLIST RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Item removed from wishlist');
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error removing from wishlist: $e');
      return false;
    }
  }
}
