/// Address Model
/// Maps to backend AddressDTO response from GET API

class AddressModel {
  final int? addressId;
  final int? userId;
  final String? label; // Home, Office, etc.
  final String? addressLine1;
  final String? addressLine2;
  final String? cityName;
  final String? postalCode;
  final String? countryName;
  final String? phoneNumber;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddressModel({
    this.addressId,
    this.userId,
    this.label,
    this.addressLine1,
    this.addressLine2,
    this.cityName,
    this.postalCode,
    this.countryName,
    this.phoneNumber,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  /// Create from JSON response (AddressDTO from API)
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId: json['addressId'] as int?,
      userId: json['userId'] as int?,
      label: json['label'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      cityName: json['cityName'] as String?,
      postalCode: json['postalCode'] as String?,
      countryName: json['countryName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : null,
    );
  }

  /// Convert to Map for display
  Map<String, String> toDisplayMap() {
    final addressParts = <String>[
      if (addressLine1 != null && addressLine1!.isNotEmpty) addressLine1!,
      // if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2!,
      if (cityName != null && cityName!.isNotEmpty) cityName!,
      if (postalCode != null && postalCode!.isNotEmpty) postalCode!,
      if (countryName != null && countryName!.isNotEmpty) countryName!,
    ];

    return {
      'label': addressLine2 ?? 'addressLine2',
      'tag': isDefault == true ? 'Default' : '',
      'address': addressParts.join(', '),
      'addressId': addressId?.toString() ?? '0',
    };
  }

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'addressId': addressId,
      'userId': userId,
      'label': label,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'cityName': cityName,
      'postalCode': postalCode,
      'countryName': countryName,
      'phoneNumber': phoneNumber,
      'isDefault': isDefault,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
