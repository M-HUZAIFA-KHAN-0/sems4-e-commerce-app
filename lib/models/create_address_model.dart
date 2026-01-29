class CreateAddressModel {
  final int userId;
  final int cityId;
  final String addressLine1;
  final String label;
  final bool isDefault;

  CreateAddressModel({
    required this.userId,
    required this.cityId,
    required this.addressLine1,
    required this.label,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'CityId': cityId,
      'AddressLine1': addressLine1,
      'AddressLine2': label,
      'IsDefault': isDefault,
    };
  }
}
