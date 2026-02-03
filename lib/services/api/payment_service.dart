import 'package:first/core/app_imports.dart';

class PaymentService {
  final ApiClient _apiClient = ApiClient();

  /// ✅ GET Payment Methods
  /// GET /api/PaymentMethod
  Future<List<PaymentMethod>?> getPaymentMethods() async {
    try {
      print('🔄 [PaymentService] Fetching payment methods...');

      final response = await _apiClient.dio.get('/api/PaymentMethod');

      if (response.statusCode == 200) {
        // API returns array directly, not wrapped in 'data' field
        if (response.data is List) {
          final paymentMethods = (response.data as List)
              .map(
                (method) =>
                    PaymentMethod.fromJson(method as Map<String, dynamic>),
              )
              .toList();

          print(
            '✅ [PaymentService] Loaded ${paymentMethods.length} payment methods',
          );
          for (var method in paymentMethods) {
            print(
              '   - ID: ${method.paymentMethodId}, Name: ${method.methodName}',
            );
          }
          return paymentMethods;
        }
      }

      print('❌ [PaymentService] Failed to load payment methods');
      return null;
    } catch (e) {
      print('❌ [PaymentService] Error fetching payment methods: $e');
      return null;
    }
  }

  /// ✅ CREATE Payment
  /// POST /api/Payment
  Future<Map<String, dynamic>?> createPayment({
    required int orderId,
    required int paymentMethodId,
    required double amount,
  }) async {
    try {
      print('🔄 [PaymentService] Creating payment...');

      // Get UserId from session
      final sessionManager = UserSessionManager();
      final userId = sessionManager.userId;

      if (userId == null || userId <= 0) {
        print('❌ [PaymentService] UserId not found in session');
        return {'success': false, 'message': 'User not authenticated'};
      }

      print('   UserId: $userId');
      print('   OrderId: $orderId');
      print('   PaymentMethodId: $paymentMethodId');
      print('   Amount: $amount');

      // Set authorization token
      final token = sessionManager.token;
      if (token != null && token.isNotEmpty) {
        _apiClient.setAuthToken(token);
        print('🔑 [PaymentService] Authorization header set');
      }

      final response = await _apiClient.dio.post(
        '/api/Payment',
        data: {
          'userId': userId,
          'orderId': orderId,
          'paymentMethodId': paymentMethodId,
          'amount': amount,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['message'] != null) {
          print('✅ [PaymentService] Payment created successfully!');
          print('   PaymentId: ${data['paymentId']}');
          return {
            'success': true,
            'message': data['message'],
            'paymentId': data['paymentId'],
          };
        }
      }

      print('❌ [PaymentService] Failed to create payment');
      return {'success': false, 'message': 'Failed to create payment'};
    } catch (e) {
      print('❌ [PaymentService] Error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}

/// Payment Method Model
class PaymentMethod {
  final int paymentMethodId;
  final String methodName;

  PaymentMethod({required this.paymentMethodId, required this.methodName});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethodId: json['paymentMethodId'] ?? 0,
      methodName: json['methodName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'paymentMethodId': paymentMethodId, 'methodName': methodName};
  }
}
