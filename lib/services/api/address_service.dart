import 'package:first/core/app_imports.dart';

class AddressService {
  final ApiClient _apiClient = ApiClient();

  /// Create a new address
  Future<bool> createAddress(CreateAddressModel address) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/Address',
        data: address.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Address created successfully');
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('❌ Error creating address: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return false;
    }
  }

  /// Get all addresses for a user
  Future<List<Map<String, dynamic>>?> getUserAddresses(int userId) async {
    try {
      print('📍 Fetching addresses for user: $userId');
      final response = await _apiClient.dio.get('/api/Address/user/$userId');

      if (response.statusCode == 200 && response.data is List) {
        final addresses = List<Map<String, dynamic>>.from(response.data);
        print('✅ Fetched ${addresses.length} addresses');

        // Print each address
        for (var i = 0; i < addresses.length; i++) {
          print(
            '   Address ${i + 1}: ${addresses[i]['cityName']} - ${addresses[i]['addressLine1']}',
          );
        }

        return addresses;
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print('⚠️ No addresses found for this user');
        return [];
      }
      print('❌ Error fetching addresses: ${e.response?.data}');
      return null;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return null;
    }
  }

  /// Update an address
  Future<bool> updateAddress(int addressId, CreateAddressModel address) async {
    try {
      print('✏️ Updating address $addressId');
      final response = await _apiClient.dio.put(
        '/api/Address/$addressId',
        data: address.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Address updated successfully');
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('❌ Error updating address: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return false;
    }
  }

  /// Delete an address
  Future<bool> deleteAddress(int addressId) async {
    try {
      print('🗑️ Deleting address $addressId');
      final response = await _apiClient.dio.delete('/api/Address/$addressId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Address deleted successfully');
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('❌ Error deleting address: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return false;
    }
  }
}
