import 'package:first/core/app_imports.dart';

class OrderAddressService {
  final ApiClient _apiClient = ApiClient();

  /// ✅ CREATE Order Address
  /// POST /api/OrderAddress
  Future<Map<String, dynamic>?> createOrderAddress({
    required int orderId,
    required int addressId,
    required String recipientName,
    required String phone,
  }) async {
    try {
      print('🔄 [OrderAddressService] Creating order address...');
      print('   OrderId: $orderId');
      print('   AddressId: $addressId');
      print('   RecipientName: $recipientName');
      print('   Phone: $phone');

      final response = await _apiClient.dio.post(
        '/api/OrderAddress',
        data: {
          'orderId': orderId,
          'addressId': addressId,
          'recipientName': recipientName,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['message'] != null) {
          print('✅ [OrderAddressService] Order address created successfully!');
          print('   OrderAddressId: ${data['orderAddressId']}');
          return {
            'success': true,
            'message': data['message'],
            'orderAddressId': data['orderAddressId'],
          };
        }
      }

      print('❌ [OrderAddressService] Failed to create order address');
      return {'success': false, 'message': 'Failed to create order address'};
    } catch (e) {
      print('❌ [OrderAddressService] Error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
