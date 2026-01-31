/// User Profile Model
/// Maps to backend UserProfileDTO response

class UserProfileModel {
  final int? profileId;
  final int? userId;
  final String? profileImage;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    this.profileId,
    this.userId,
    this.profileImage,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });

  /// Create from JSON response
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      profileId: json['profileId'] as int?,
      userId: json['userId'] as int?,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : null,
    );
  }

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'userId': userId,
      'profileImage': profileImage,
      'bio': bio,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Copy with method for immutability
  UserProfileModel copyWith({
    int? profileId,
    int? userId,
    String? profileImage,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      profileId: profileId ?? this.profileId,
      userId: userId ?? this.userId,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'UserProfileModel(profileId: $profileId, userId: $userId, bio: $bio, image: $profileImage)';
}
