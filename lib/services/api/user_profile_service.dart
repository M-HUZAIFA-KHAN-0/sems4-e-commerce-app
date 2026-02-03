// import 'package:dio/dio.dart';
// import 'package:first/services/api/api_client.dart';
// import 'package:first/models/user_profile_model.dart';
// import 'package:first/models/user_model.dart';
// import 'package:first/services/user_session_manager.dart';

// class UserProfileService {
//   final ApiClient _apiClient = ApiClient();

//   /// Fetch user data (firstName, lastName, email, phone)
//   /// GET: /api/User/{userId}
//   Future<UserModel?> fetchUserData({required int userId}) async {
//     try {
//       print('👤 [UserProfileService] Fetching user data for userId: $userId');

//       final response = await _apiClient.dio.get('/api/User/$userId');

//       print('👤 [UserProfileService] Response status: ${response.statusCode}');
//       print('👤 [UserProfileService] Response data: ${response.data}');

//       if (response.statusCode == 200 && response.data != null) {
//         final data = response.data is Map ? response.data : {};
//         final userData = data['data'] ?? data;
//         final user = UserModel.fromJson(userData);
//         print(
//           '✅ [UserProfileService] User data fetched: ${user.firstName} ${user.lastName}',
//         );
//         return user;
//       }

//       print('❌ [UserProfileService] Invalid response: ${response.statusCode}');
//       return null;
//     } on DioException catch (e) {
//       print('❌ [UserProfileService] DioException: ${e.message}');
//       print('   Status: ${e.response?.statusCode}');
//       print('   Response: ${e.response?.data}');

//       if (e.response?.statusCode == 404) {
//         print('⚠️  [UserProfileService] User not found');
//         return null;
//       }

//       rethrow;
//     }
//   }

//   /// Update full profile (user data + profile data)
//   /// PUT: /api/UserProfile/update-profile/{id}
//   /// ID must be in URL path for security validation
//   /// Updates: firstName, lastName, email, phoneNumber, bio, profileImage
//   Future<bool> updateFullProfile({
//     required int userId,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phoneNumber,
//     String? bio,
//     String? imagePath,
//   }) async {
//     try {
//       print(
//         '💾 [UserProfileService] Updating full profile for userId: $userId',
//       );

//       // Ensure token is set in ApiClient
//       final sessionManager = UserSessionManager();
//       final token = sessionManager.token;
//       if (token != null && token.isNotEmpty) {
//         _apiClient.setAuthToken(token);
//         print('🔑 [UserProfileService] Authorization token set from session');
//       } else {
//         print('⚠️  [UserProfileService] WARNING: No token found in session!');
//       }

//       final formData = FormData();

//       if (firstName != null && firstName.isNotEmpty) {
//         formData.fields.add(MapEntry('FirstName', firstName));
//       }

//       if (lastName != null && lastName.isNotEmpty) {
//         formData.fields.add(MapEntry('LastName', lastName));
//       }

//       if (email != null && email.isNotEmpty) {
//         formData.fields.add(MapEntry('Email', email));
//       }

//       if (phoneNumber != null && phoneNumber.isNotEmpty) {
//         formData.fields.add(MapEntry('PhoneNumber', phoneNumber));
//       }

//       if (bio != null && bio.isNotEmpty) {
//         formData.fields.add(MapEntry('Bio', bio));
//       }

//       if (imagePath != null && imagePath.isNotEmpty) {
//         print('📸 [UserProfileService] Adding profile image from: $imagePath');
//         formData.files.add(
//           MapEntry(
//             'ProfileImage',
//             await MultipartFile.fromFile(
//               imagePath,
//               filename: imagePath.split('/').last,
//             ),
//           ),
//         );
//       }

//       // Use endpoint with ID in URL path: /api/UserProfile/update-profile/{id}
//       final endpoint = '/api/User/update-profile/$userId';
//       print('📤 [UserProfileService] Sending PUT request to $endpoint');
//       print('📤 [UserProfileService] Form fields: ${formData.fields}');
//       print(
//         '📤 [UserProfileService] Authorization header: ${_apiClient.dio.options.headers['Authorization']}',
//       );

//       final response = await _apiClient.dio.put(endpoint, data: formData);

//       print('📤 [UserProfileService] Response status: ${response.statusCode}');
//       print('📤 [UserProfileService] Response data: ${response.data}');

//       if (response.statusCode == 200) {
//         final message =
//             response.data?['message'] ?? 'Profile updated successfully';
//         print('✅ [UserProfileService] $message');
//         return true;
//       }

//       print(
//         '❌ [UserProfileService] Failed to update profile: ${response.statusCode}',
//       );
//       return false;
//     } on DioException catch (e) {
//       print('❌ [UserProfileService] DioException: ${e.message}');
//       print('   Status: ${e.response?.statusCode}');
//       print('   Response: ${e.response?.data}');
//       rethrow;
//     }
//   }

//   /// Update user data (firstName, lastName, email, phone)
//   /// PUT: /api/User/{userId}
//   Future<bool> updateUserData({
//     required int userId,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phoneNumber,
//   }) async {
//     try {
//       print('📝 [UserProfileService] Updating user data for userId: $userId');

//       final data = <String, dynamic>{};
//       if (firstName != null) data['firstName'] = firstName;
//       if (lastName != null) data['lastName'] = lastName;
//       if (email != null) data['email'] = email;
//       if (phoneNumber != null) data['phoneNumber'] = phoneNumber;

//       print('📤 [UserProfileService] Updating with data: $data');

//       final response = await _apiClient.dio.put(
//         '/api/update-profile/$userId',
//         data: data,
//       );

//       print('📤 [UserProfileService] Response status: ${response.statusCode}');
//       print('📤 [UserProfileService] Response data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         print('✅ [UserProfileService] User data updated successfully');
//         return true;
//       }

//       print(
//         '❌ [UserProfileService] Failed to update user data: ${response.statusCode}',
//       );
//       return false;
//     } on DioException catch (e) {
//       print('❌ [UserProfileService] DioException: ${e.message}');
//       print('   Status: ${e.response?.statusCode}');
//       print('   Response: ${e.response?.data}');
//       rethrow;
//     }
//   }

//   /// Fetch user profile by userId
//   /// GET: /api/UserProfile/user/{userId}
//   Future<UserProfileModel?> fetchUserProfile({required int userId}) async {
//     try {
//       print('📋 [UserProfileService] Fetching profile for userId: $userId');

//       final response = await _apiClient.dio.get(
//         '/api/UserProfile/user/$userId',
//       );

//       print('📋 [UserProfileService] Response status: ${response.statusCode}');
//       print('📋 [UserProfileService] Response data: ${response.data}');

//       if (response.statusCode == 200 && response.data != null) {
//         final profile = UserProfileModel.fromJson(response.data);
//         print(
//           '✅ [UserProfileService] Profile fetched successfully: ${profile.bio}',
//         );
//         return profile;
//       }

//       print('❌ [UserProfileService] Invalid response: ${response.statusCode}');
//       return null;
//     } on DioException catch (e) {
//       print('❌ [UserProfileService] DioException: ${e.message}');
//       print('   Status: ${e.response?.statusCode}');
//       print('   Response: ${e.response?.data}');

//       // Handle 404 - profile doesn't exist yet (not an error for first-time users)
//       if (e.response?.statusCode == 404) {
//         print(
//           '⚠️  [UserProfileService] Profile not found (user may not have created one yet)',
//         );
//         return null;
//       }

//       rethrow;
//     }
//   }

//   /// Create or update user profile with image
//   /// POST: /api/UserProfile (create)
//   /// PUT: /api/UserProfile/{id} (update)
//   Future<bool> saveUserProfile({
//     required int userId,
//     int? profileId,
//     String? bio,
//     String? imagePath,
//   }) async {
//     try {
//       final formData = FormData();
//       formData.fields.add(MapEntry('UserId', userId.toString()));

//       if (bio != null && bio.isNotEmpty) {
//         formData.fields.add(MapEntry('Bio', bio));
//       }

//       if (imagePath != null && imagePath.isNotEmpty) {
//         print('📸 [UserProfileService] Adding image from path: $imagePath');
//         formData.files.add(
//           MapEntry(
//             'ProfileImage',
//             await MultipartFile.fromFile(
//               imagePath,
//               filename: imagePath.split('/').last,
//             ),
//           ),
//         );
//       }

//       // Determine if creating or updating
//       final isCreate = profileId == null || profileId <= 0;
//       final endpoint = isCreate
//           ? '/api/UserProfile'
//           : '/api/UserProfile/$profileId';
//       final method = isCreate ? 'POST' : 'PUT';

//       print('$method [UserProfileService] Saving profile to: $endpoint');
//       print('📤 [UserProfileService] Form data: ${formData.fields}');

//       final response = isCreate
//           ? await _apiClient.dio.post(endpoint, data: formData)
//           : await _apiClient.dio.put(endpoint, data: formData);

//       print('📤 [UserProfileService] Response status: ${response.statusCode}');
//       print('📤 [UserProfileService] Response data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final message =
//             response.data?['message'] ?? 'Profile saved successfully';
//         print('✅ [UserProfileService] $message');
//         return true;
//       }

//       print(
//         '❌ [UserProfileService] Failed to save profile: ${response.statusCode}',
//       );
//       return false;
//     } on DioException catch (e) {
//       print('❌ [UserProfileService] DioException: ${e.message}');
//       print('   Status: ${e.response?.statusCode}');
//       print('   Response: ${e.response?.data}');
//       rethrow;
//     }
//   }

//   /// Get profile image URL
//   /// Constructs the full URL for the profile image stored on the server
//   String getProfileImageUrl(String? imageName) {
//     if (imageName == null || imageName.isEmpty) {
//       return 'https://via.placeholder.com/150?text=No+Image';
//     }
//     // Adjust the URL based on your backend configuration
//     return 'http://127.0.0.1:5230/upload/UserProfiles/$imageName';
//   }
// }

import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';
import 'package:first/models/user_profile_model.dart';
import 'package:first/models/user_model.dart';
import 'package:first/services/user_session_manager.dart';

class UserProfileService {
  final ApiClient _apiClient = ApiClient();

  /// 🔐 Ensure JWT token is attached before secure requests
  void _attachAuthToken() {
    // ✅ Get token from session manager
    final sessionManager = UserSessionManager();
    final token = sessionManager.token;

    if (token != null && token.isNotEmpty) {
      // ✅ Set Authorization header
      _apiClient.dio.options.headers['Authorization'] = 'Bearer $token';
      print('🔑 [UserProfileService] Authorization token attached');
    } else {
      print('⚠️ [UserProfileService] WARNING: No token found in session');
    }
  }

  /// Fetch user data (firstName, lastName, email, phone)
  Future<UserModel?> fetchUserData({required int userId}) async {
    try {
      print('👤 [UserProfileService] Fetching user data for userId: $userId');
      _attachAuthToken();

      final response = await _apiClient.dio.get('/api/User/$userId');

      print('👤 [UserProfileService] Response status: ${response.statusCode}');
      print('👤 [UserProfileService] Response data: ${response.data}');
      print(
        '👤 [UserProfileService] Response data type: ${response.data.runtimeType}',
      );

      if (response.statusCode == 200 && response.data != null) {
        // Handle different response formats
        final data = response.data is Map ? response.data : {};
        final userData = data['data'] ?? data;

        print('👤 [UserProfileService] Parsing userData: $userData');

        final user = UserModel.fromJson(userData as Map<String, dynamic>);
        print(
          '✅ [UserProfileService] User fetched: ${user.firstName} ${user.lastName}',
        );
        return user;
      }

      print(
        '❌ [UserProfileService] Invalid response code: ${response.statusCode}',
      );
      return null;
    } on DioException catch (e) {
      print(
        '❌ [UserProfileService] DioException in fetchUserData: ${e.message}',
      );
      _handleDioError(e, 'Fetch user data');
      return null;
    } catch (e) {
      print('❌ [UserProfileService] Unexpected error in fetchUserData: $e');
      return null;
    }
  }

  /// Update full profile (user data + profile data)
  Future<bool> updateFullProfile({
    required int userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? imagePath,
  }) async {
    try {
      print('💾 Updating profile for userId: $userId');
      _attachAuthToken();

      final formData = FormData();
      if (firstName?.isNotEmpty == true)
        formData.fields.add(MapEntry('FirstName', firstName!));
      if (lastName?.isNotEmpty == true)
        formData.fields.add(MapEntry('LastName', lastName!));
      if (email?.isNotEmpty == true)
        formData.fields.add(MapEntry('Email', email!));
      if (phoneNumber?.isNotEmpty == true)
        formData.fields.add(MapEntry('PhoneNumber', phoneNumber!));
      if (bio?.isNotEmpty == true) formData.fields.add(MapEntry('Bio', bio!));

      if (imagePath?.isNotEmpty == true) {
        formData.files.add(
          MapEntry(
            'ProfileImage',
            await MultipartFile.fromFile(
              imagePath!,
              filename: imagePath.split('/').last,
            ),
          ),
        );
      }

      final response = await _apiClient.dio.put(
        '/api/User/update-profile/$userId',
        data: formData,
      );
      print('💾 Response: ${response.statusCode}');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _handleDioError(e, 'Update full profile');
      return false;
    }
  }

  /// Update basic user data
  Future<bool> updateUserData({
    required int userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) async {
    try {
      _attachAuthToken();

      final data = <String, dynamic>{};
      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (email != null) data['email'] = email;
      if (phoneNumber != null) data['phoneNumber'] = phoneNumber;

      final response = await _apiClient.dio.put(
        '/api/update-profile/$userId',
        data: data,
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      _handleDioError(e, 'Update user data');
      return false;
    }
  }

  /// Fetch user profile
  Future<UserProfileModel?> fetchUserProfile({required int userId}) async {
    try {
      print('📋 [UserProfileService] Fetching profile for userId: $userId');
      _attachAuthToken();

      final response = await _apiClient.dio.get(
        '/api/UserProfile/user/$userId',
      );

      print('📋 [UserProfileService] Response status: ${response.statusCode}');
      print('📋 [UserProfileService] Response data: ${response.data}');
      print(
        '📋 [UserProfileService] Response data type: ${response.data.runtimeType}',
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is Map ? response.data : {};
        final profileData = data['data'] ?? data;

        // Ensure userId is included in the profile data
        if (profileData['userId'] == null) {
          profileData['userId'] = userId;
        }

        print('📋 [UserProfileService] Parsing profile data: $profileData');

        final profile = UserProfileModel.fromJson(
          profileData as Map<String, dynamic>,
        );
        print(
          '✅ [UserProfileService] Profile fetched: bio="${profile.bio}", userId=${profile.userId}',
        );
        return profile;
      }

      print(
        '⚠️ [UserProfileService] Invalid response code: ${response.statusCode}',
      );
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print(
          '⚠️ [UserProfileService] Profile not found (404) - this is ok for new users',
        );
        return null;
      }
      print(
        '❌ [UserProfileService] DioException in fetchUserProfile: ${e.message}',
      );
      _handleDioError(e, 'Fetch user profile');
      return null;
    } catch (e) {
      print('❌ [UserProfileService] Unexpected error in fetchUserProfile: $e');
      return null;
    }
  }

  /// Create or update user profile
  Future<bool> saveUserProfile({
    required int userId,
    int? profileId,
    String? bio,
    String? imagePath,
  }) async {
    try {
      _attachAuthToken();

      final formData = FormData();
      formData.fields.add(MapEntry('UserId', userId.toString()));
      if (bio?.isNotEmpty == true) formData.fields.add(MapEntry('Bio', bio!));
      if (imagePath?.isNotEmpty == true) {
        formData.files.add(
          MapEntry(
            'ProfileImage',
            await MultipartFile.fromFile(
              imagePath!,
              filename: imagePath.split('/').last,
            ),
          ),
        );
      }

      final endpoint = profileId == null || profileId <= 0
          ? '/api/UserProfile'
          : '/api/UserProfile/$profileId';

      final response = profileId == null
          ? await _apiClient.dio.post(endpoint, data: formData)
          : await _apiClient.dio.put(endpoint, data: formData);

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      _handleDioError(e, 'Save user profile');
      return false;
    }
  }

  /// Central Dio error handler
  void _handleDioError(DioException e, String source) {
    final status = e.response?.statusCode;
    print('❌ [$source] Dio error: ${e.message}');
    print('   Status: $status');
    print('   Response: ${e.response?.data}');
    if (status == 401) print('🔒 Unauthorized – token invalid or expired');
    if (status == 403) print('🚫 Forbidden – access denied');
    if (status == 500) print('🔥 Server error');
  }

  /// Get profile image URL
  String getProfileImageUrl(String? imageName) {
    if (imageName == null || imageName.isEmpty)
      return 'https://via.placeholder.com/150?text=No+Image';
    return 'http://127.0.0.1:5230/upload/UserProfiles/$imageName';
  }
}
