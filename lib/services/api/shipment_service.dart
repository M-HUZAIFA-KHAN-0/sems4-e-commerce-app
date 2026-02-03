import 'package:first/core/app_imports.dart';

class ShipmentService {
  final ApiClient _apiClient = ApiClient();

  /// ✅ CREATE Shipment
  /// POST /api/Shipment
  Future<Map<String, dynamic>?> createShipment({
    required int orderId,
    required String courierName,
    required double shippingPrice,
  }) async {
    try {
      print('🔄 [ShipmentService] Creating shipment...');

      // Get token from session
      final sessionManager = UserSessionManager();
      final token = sessionManager.token;

      if (token != null && token.isNotEmpty) {
        _apiClient.setAuthToken(token);
        print('🔑 [ShipmentService] Authorization header set');
      }

      print('   OrderId: $orderId');
      print('   CourierName: $courierName');
      print('   ShippingPrice: $shippingPrice');

      final response = await _apiClient.dio.post(
        '/api/Shipment',
        data: {
          'orderId': orderId,
          'courierName': courierName,
          'shippingPrice': shippingPrice,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['message'] != null) {
          print('✅ [ShipmentService] Shipment created successfully!');
          print('   ShipmentId: ${data['shipmentId']}');
          print('   TrackingNumber: ${data['trackingNumber']}');
          return {
            'success': true,
            'message': data['message'],
            'shipmentId': data['shipmentId'],
            'trackingNumber': data['trackingNumber'],
          };
        }
      }

      print('❌ [ShipmentService] Failed to create shipment');
      return {'success': false, 'message': 'Failed to create shipment'};
    } catch (e) {
      print('❌ [ShipmentService] Error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
