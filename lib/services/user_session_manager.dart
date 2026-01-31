/// Global user session manager to store userId and user data
class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();

  int? _userId;
  String? _userEmail;
  String? _userName;
  bool _isLoggedIn = false;
  String? _token; // Add a private variable to store the token
  int? _wishlistId; // Store user's wishlist ID
  int? _cartId; // Store user's cart ID

  factory UserSessionManager() {
    return _instance;
  }

  UserSessionManager._internal() {
    _userId = null;
    _userEmail = null;
    _userName = null;
    _isLoggedIn = false;
    _wishlistId = null;
    _cartId = null;
  }

  /// Set user data after signup
  void setSignupData({
    required int userId,
    required String email,
    required String firstName,
    required String lastName,
  }) {
    _userId = userId;
    _userEmail = email;
    _userName = '$firstName $lastName';
    print('✅ User session created: userId=$_userId, email=$_userEmail');
  }

  /// Set user data after login
  void setLoginData({required int userId}) {
    _userId = userId;
    print('✅ User login data stored: userId=$_userId');
  }

  /// Set user as logged in after successful verification
  void setLoggedIn({required bool isLoggedIn}) {
    _isLoggedIn = isLoggedIn;
    print('Login status: $_isLoggedIn');
  }

  /// Store authentication token
  void setToken(String token) {
    _token = token;
  }

  /// Store user's wishlist ID
  void setWishlistId(int wishlistId) {
    _wishlistId = wishlistId;
    print('🔖 WISHLIST ID SET: $_wishlistId');
  }

  /// Store user's cart ID
  void setCartId(int cartId) {
    _cartId = cartId;
  }

  /// Get userId
  int? get userId => _userId;

  /// Get user email
  String? get userEmail => _userEmail;

  /// Get user name
  String? get userName => _userName;

  /// Check if user is logged in
  bool get isLoggedIn => _isLoggedIn;

  /// Check if user data exists
  bool get hasUserData => _userId != null && _userEmail != null;

  /// Get authentication token
  String? get token => _token;

  /// Get wishlist ID
  int? get wishlistId {
    print('📖 WISHLIST ID GET: $_wishlistId');
    return _wishlistId;
  }

  /// Get cart ID
  int? get cartId => _cartId;

  /// Clear session (on logout)
  void clearSession() {
    _userId = null;
    _userEmail = null;
    _userName = null;
    _isLoggedIn = false;
    _wishlistId = null;
    _cartId = null;
    print('✅ User session cleared');
  }

  /// Print current session info (for debugging)
  void printSessionInfo() {
    print('=== USER SESSION INFO ===');
    print('UserId: $_userId');
    print('Email: $_userEmail');
    print('Name: $_userName');
    print('Is Logged In: $_isLoggedIn');
  }
}
