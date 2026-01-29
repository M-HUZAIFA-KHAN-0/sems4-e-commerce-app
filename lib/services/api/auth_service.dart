import 'package:dio/dio.dart';
import 'package:first/services/api/api_client.dart';
import 'package:first/services/api/cart_wishlist_service.dart';
import 'package:first/services/user_session_manager.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final UserSessionManager _sessionManager = UserSessionManager();
  final CartWishlistService _cartWishlistService = CartWishlistService();

  /// Sign up a new user
  Future<Map<String, dynamic>> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    String? phoneNumber,
  }) async {
    try {
      final dto = {
        "Username": email,
        "Email": email,
        "FirstName": firstName,
        "LastName": lastName,
        "Password": password,
        "PhoneNumber": phoneNumber ?? "",
      };

      print('=== SIGNUP REQUEST ===');
      print('Email: $email');

      final response = await _apiClient.dio.post('/api/user/signup', data: dto);

      print('=== SIGNUP RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract userId from response
        final responseData = response.data;
        final userId = responseData is Map ? responseData['userId'] : null;

        if (userId != null) {
          // Store user data in session manager
          _sessionManager.setSignupData(
            userId: userId is int ? userId : int.parse(userId.toString()),
            email: email,
            firstName: firstName,
            lastName: lastName,
          );
        }

        return {
          'success': true,
          'data': response.data,
          'userId': userId,
          'message': response.data['message'] ?? 'Signup successful',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Signup failed',
        };
      }
    } on DioException catch (e) {
      print('Dio error during signup: $e');
      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during signup: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Verify email with OTP
  Future<Map<String, dynamic>> verifyEmail({
    required dynamic userId,
    required String otp,
  }) async {
    try {
      final useridInt = userId is int ? userId : int.parse(userId.toString());
      final dto = {"userId": useridInt, "code": otp};

      print('=== VERIFY EMAIL REQUEST ===');
      print('UserId: $useridInt');
      print('Code: $otp');
      print('Payload: $dto');

      final response = await _apiClient.dio.post(
        '/api/user/verify-email',
        data: dto,
      );

      print('=== VERIFY EMAIL RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      print('Data Type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        // Mark user as logged in after successful email verification
        _sessionManager.setLoggedIn(isLoggedIn: true);

        // Response is plain text string, not JSON
        String message = response.data is String
            ? response.data
            : (response.data['message'] ?? 'Email verified successfully');

        return {'success': true, 'data': response.data, 'message': message};
      } else {
        String errorMsg = response.data is String
            ? response.data
            : (response.data['message'] ?? 'Verification failed');

        return {'success': false, 'message': errorMsg};
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('=== GENERAL ERROR ===');
      print('Error: $e');
      return {'success': false, 'message': 'An unexpected error occurred: $e'};
    }
  }

  /// Login user
  Future<Map<String, dynamic>> login({
    required String usernameOrEmail,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final dto = {"UsernameOrEmail": usernameOrEmail, "Password": password};

      print('=== LOGIN REQUEST ===');
      print('UsernameOrEmail: $usernameOrEmail');

      final response = await _apiClient.dio.post('/api/user/login', data: dto);

      print('=== LOGIN RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData is Map ? responseData['token'] : null;
        final userId = responseData is Map ? responseData['userId'] : null;

        // Mark user as logged in
        _sessionManager.setLoggedIn(isLoggedIn: true);

        // Store userId in session manager if available
        if (userId != null) {
          final userIdInt = userId is int
              ? userId
              : int.parse(userId.toString());
          _sessionManager.setLoginData(userId: userIdInt);

          // Initialize cart and wishlist after successful login
          print('🔄 Initializing cart and wishlist...');
          try {
            final result = await _cartWishlistService.initializeCartAndWishlist(userIdInt);
            print('✅ Cart and Wishlist initialized successfully');
            print('📋 Init result: $result');
            print('💾 Session wishlistId: ${_sessionManager.wishlistId}');
          } catch (e) {
            print('⚠️ Error initializing cart and wishlist: $e');
            // Don't fail login if cart/wishlist initialization fails
          }
        }

        return {
          'success': true,
          'data': response.data,
          'token': token,
          'userId': userId,
          'message': response.data['message'] ?? 'Login successful',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Login failed',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      // Handle 400 and 401 errors with message from backend
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ?? 'Login failed');

        // Check if email is not verified
        if (errorMsg.toString().contains('Email not verified')) {
          final userId = e.response?.data is Map
              ? e.response?.data['userId']
              : null;

          print('⚠️ Email not verified - redirecting to OTP screen');
          return {
            'success': false,
            'emailNotVerified': true,
            'message': errorMsg,
            'userId': userId,
          };
        }

        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during login: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Resend OTP to email
  Future<Map<String, dynamic>> resendOtp({
    required String email,
    required dynamic userId,
  }) async {
    try {
      final useridInt = userId is int ? userId : int.parse(userId.toString());

      print('=== RESEND OTP REQUEST ===');
      print('Email: $email');
      print('UserId: $useridInt');

      final response = await _apiClient.dio.post(
        '/api/user/resend-otp',
        data: {'Email': email, 'UserId': useridInt},
      );

      print('=== RESEND OTP RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'OTP sent successfully',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to resend OTP',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 404) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ?? 'User not found');
        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during resend OTP: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset({
    required String email,
  }) async {
    try {
      print('=== PASSWORD RESET REQUEST ===');
      print('Email: $email');

      final response = await _apiClient.dio.post(
        '/api/user/request-password-reset',
        data: {'Email': email},
      );

      print('=== PASSWORD RESET RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              response.data['message'] ??
              'Password reset token sent to your email',
        };
      } else {
        return {
          'success': false,
          'message':
              response.data['message'] ?? 'Failed to request password reset',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 400) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ??
                  'Failed to request password reset');
        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during password reset request: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Reset password with token
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      print('=== RESET PASSWORD REQUEST ===');
      print('Token: $token');

      final response = await _apiClient.dio.post(
        '/api/user/reset-password',
        data: {'Token': token, 'NewPassword': newPassword},
      );

      print('=== RESET PASSWORD RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Password reset successfully',
          'userId': response.data['userId'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to reset password',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 400) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ?? 'Failed to reset password');
        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during password reset: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Refresh JWT token
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      print('=== REFRESH TOKEN REQUEST ===');

      final response = await _apiClient.dio.post('/api/user/refresh-token');

      print('=== REFRESH TOKEN RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        final token = response.data['token'];

        // Store new token in session manager
        if (token != null) {
          _sessionManager.setToken(token);
          _apiClient.setAuthToken(token);
        }

        return {
          'success': true,
          'token': token,
          'userId': response.data['userId'],
          'message': response.data['message'] ?? 'Token refreshed successfully',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to refresh token',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');

      if (e.response?.statusCode == 401) {
        // Refresh token expired, need to logout
        logout();
        return {
          'success': false,
          'message': 'Session expired. Please login again.',
        };
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during token refresh: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Get user profile by userId
  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      print('=== GET USER PROFILE REQUEST ===');
      print('UserId: $userId');

      final response = await _apiClient.dio.get('/api/user/$userId');

      print('=== GET USER PROFILE RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
          'message':
              response.data['message'] ?? 'User profile fetched successfully',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to fetch user profile',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 404) {
        return {'success': false, 'message': 'User not found'};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error fetching user profile: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Logout user and clear all session data
  void logout() {
    // Clear user session data
    _sessionManager.clearSession();
    // Clear authorization token from API client
    _apiClient.clearAuthToken();
    print('✅ User logged out successfully');
  }

  /// Request password reset
  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      print('=== FORGOT PASSWORD REQUEST ===');
      print('Email: $email');

      final response = await _apiClient.dio.post(
        '/api/user/request-password-reset',
        data: {'Email': email},
      );

      print('=== FORGOT PASSWORD RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              response.data['message'] ??
              'Password reset token sent to your email',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to send reset token',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 400) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ?? 'Invalid email');
        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during forgot password: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Reset password with token
  Future<Map<String, dynamic>> resetPasswordWithToken({
    required String token,
    required String newPassword,
  }) async {
    try {
      print('=== RESET PASSWORD REQUEST ===');
      print('Token: $token');

      final response = await _apiClient.dio.post(
        '/api/user/reset-password',
        data: {'Token': token, 'NewPassword': newPassword},
      );

      print('=== RESET PASSWORD RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Password reset successfully',
          'userId': response.data['userId'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to reset password',
        };
      }
    } on DioException catch (e) {
      print('=== DIO EXCEPTION ===');
      print('Error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      if (e.response?.statusCode == 400) {
        final errorMsg = e.response?.data is String
            ? e.response?.data
            : (e.response?.data['message'] ?? 'Invalid or expired token');
        return {'success': false, 'message': errorMsg};
      }

      return {'success': false, 'message': _handleDioError(e)};
    } catch (e) {
      print('Error during password reset: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  /// Handle Dio errors
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Response timeout. Please try again.';
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 400) {
          return error.response?.data['message'] ?? 'Invalid request';
        } else if (error.response?.statusCode == 409) {
          return error.response?.data['message'] ?? 'User already exists';
        } else if (error.response?.statusCode == 500) {
          return 'Server error. Please try again later.';
        }
        return 'Request failed. Please try again.';
      case DioExceptionType.connectionError:
        return 'Network error. Please check your connection.';
      case DioExceptionType.unknown:
        return 'Unknown error occurred. Please try again.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
