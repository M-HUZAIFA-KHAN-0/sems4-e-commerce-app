/// User Model
/// Maps to backend UserDTO response

class UserModel {
  final int? userId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final bool? isActive;
  final DateTime? createdAt;
  final List<String>? roles;

  UserModel({
    this.userId,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.isActive,
    this.createdAt,
    this.roles,
  });

  /// Create from JSON response (UserDTO)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : null,
      roles: json['roles'] != null
          ? List<String>.from(json['roles'] as List)
          : [],
    );
  }

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'roles': roles,
    };
  }

  /// Copy with method for immutability
  UserModel copyWith({
    int? userId,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isActive,
    DateTime? createdAt,
    List<String>? roles,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      roles: roles ?? this.roles,
    );
  }

  @override
  String toString() =>
      'UserModel(userId: $userId, username: $username, email: $email, firstName: $firstName, lastName: $lastName, phone: $phoneNumber)';
}
