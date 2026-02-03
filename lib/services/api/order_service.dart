import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';
import 'package:first/services/user_session_manager.dart';

class OrderService {
  final ApiClient _apiClient = ApiClient();

  /// Step 1: Create Order
  /// POST: /api/Order
  Future<Map<String, dynamic>?> createOrder({
    required int userId,
    required double totalAmount,
  }) async {
    try {
      print('📋 [OrderService] Creating order...');
      print('   UserId: $userId');
      print('   TotalAmount: $totalAmount');

      // Ensure token is set
      final sessionManager = UserSessionManager();
      final token = sessionManager.token;
      if (token != null && token.isNotEmpty) {
        _apiClient.setAuthToken(token);
        print('🔑 [OrderService] Authorization token set');
      }

      final requestBody = {'UserId': userId, 'TotalAmount': totalAmount};

      print('📤 [OrderService] Request payload: $requestBody');

      final response = await _apiClient.dio.post(
        '/api/Order',
        data: requestBody,
      );

      print('📥 [OrderService] Response status: ${response.statusCode}');
      print('📥 [OrderService] Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        if (data['success'] == true && data['orderId'] != null) {
          final orderId = data['orderId'] as int;
          print(
            '✅ [OrderService] Order created successfully! OrderId: $orderId',
          );
          return {'orderId': orderId, 'message': data['message']};
        }
      }

      print('❌ [OrderService] Failed to create order');
      return null;
    } on DioException catch (e) {
      print('❌ [OrderService] DioException: ${e.message}');
      print('   Status: ${e.response?.statusCode}');
      print('   Response: ${e.response?.data}');
      rethrow;
    }
  }

  /// Step 2: Create Order Item
  /// POST: /api/OrderItem
  /// Must be called after order is created
  Future<bool> createOrderItem({
    required int orderId,
    required int variantId,
    required int quantity,
    required int variantSpecificationOptionsId,
  }) async {
    try {
      print('🛍️  [OrderService] Creating order item...');
      print('   OrderId: $orderId');
      print('   VariantId: $variantId');
      print('   Quantity: $quantity');
      print('   VariantSpecificationOptionsId: $variantSpecificationOptionsId');

      // Ensure token is set
      final sessionManager = UserSessionManager();
      final token = sessionManager.token;
      if (token != null && token.isNotEmpty) {
        _apiClient.setAuthToken(token);
      }

      final requestBody = {
        'OrderId': orderId,
        'VariantId': variantId,
        'Quantity': quantity,
        'VariantSpecificationOptionsId': variantSpecificationOptionsId,
      };

      print('📤 [OrderService] Request payload: $requestBody');

      final response = await _apiClient.dio.post(
        '/api/OrderItem',
        data: requestBody,
      );

      print('📥 [OrderService] Response status: ${response.statusCode}');
      print('📥 [OrderService] Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final orderItemId = data['orderItemId'];
        if (orderItemId != null) {
          print(
            '✅ [OrderService] Order item created successfully! OrderItemId: $orderItemId',
          );
          return true;
        }
      }

      print('❌ [OrderService] Failed to create order item');
      return false;
    } on DioException catch (e) {
      print('❌ [OrderService] DioException: ${e.message}');
      print('   Status: ${e.response?.statusCode}');
      print('   Response: ${e.response?.data}');
      rethrow;
    }
  }

  /// Create all order items for an order
  /// Loops through items and creates each one
  Future<bool> createAllOrderItems({
    required int orderId,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      print('📦 [OrderService] Creating ${items.length} order items...');

      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final variantId = item['variantId'] as int?;
        final quantity = item['quantity'] as int?;
        final variantSpecificationOptionsId =
            item['variantSpecificationOptionsId'] as int?;

        if (variantId == null || quantity == null) {
          print('❌ [OrderService] Item $i missing variantId or quantity');
          return false;
        }

        final success = await createOrderItem(
          orderId: orderId,
          variantId: variantId,
          quantity: quantity,
          variantSpecificationOptionsId: variantSpecificationOptionsId ?? 0,
        );

        if (!success) {
          print('❌ [OrderService] Failed to create order item $i');
          return false;
        }

        print('✅ [OrderService] Order item ${i + 1}/${items.length} created');
      }

      print(
        '✅ [OrderService] All ${items.length} order items created successfully',
      );
      return true;
    } catch (e) {
      print('❌ [OrderService] Error creating order items: $e');
      rethrow;
    }
  }

  /// Fetch Orders by UserId
  /// GET: /api/Order/user/{userId}/orders
  Future<List<Map<String, dynamic>>?> getOrdersByUserId(int userId) async {
    try {
      print('📋 [OrderService] Fetching orders for userId: $userId');

      // Ensure token is set
      final sessionManager = UserSessionManager();
      final token = sessionManager.token;
      if (token != null && token.isNotEmpty) {
        _apiClient.setAuthToken(token);
        print('🔑 [OrderService] Authorization token set');
      }

      final response = await _apiClient.dio.get(
        '/api/Order/user/$userId/orders',
      );

      print('📥 [OrderService] Response status: ${response.statusCode}');
      print('📥 [OrderService] Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data as List<dynamic>;
        if (data.isNotEmpty) {
          final orders = List<Map<String, dynamic>>.from(
            data.map((order) => order as Map<String, dynamic>),
          );
          print(
            '✅ [OrderService] Orders fetched successfully! Count: ${orders.length}',
          );
          return orders;
        } else {
          print('ℹ️  [OrderService] No orders found for userId: $userId');
          return [];
        }
      }

      print('❌ [OrderService] Failed to fetch orders');
      return null;
    } on DioException catch (e) {
      print('❌ [OrderService] DioException: ${e.message}');
      print('   Status: ${e.response?.statusCode}');
      print('   Response: ${e.response?.data}');
      rethrow;
    }
  }
}
