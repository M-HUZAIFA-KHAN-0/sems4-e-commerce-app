/// Complete Product Detail Model - Maps to API response structure
/// Supports full variant selection, specifications, and images
library;

class ProductDetailModel {
  final int productId;
  final String productName;
  final String description;
  final String? brandName;
  final String? categoryName;
  final int warrantyMonths;
  final bool isActive;
  final String? coverImage;
  final List<String> galleryImages;
  final List<ProductVariant> variants;
  final List<ProductSpecification> specifications;
  final double averageRating;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProductDetailModel({
    required this.productId,
    required this.productName,
    required this.description,
    this.brandName,
    this.categoryName,
    required this.warrantyMonths,
    required this.isActive,
    this.coverImage,
    this.galleryImages = const [],
    this.variants = const [],
    this.specifications = const [],
    this.averageRating = 0.0,
    required this.createdAt,
    this.updatedAt,
  });

  /// Get the cheapest variant by finalPrice
  ProductVariant? getCheapestVariant() {
    if (variants.isEmpty) return null;
    return variants.reduce((a, b) {
      final priceA = a.finalPrice ?? a.price ?? 999999;
      final priceB = b.finalPrice ?? b.price ?? 999999;
      return priceA < priceB ? a : b;
    });
  }

  /// Get all unique RAM values from variants
  List<String> getUniqueRAMOptions() {
    final ramSet = <String>{};
    for (var variant in variants) {
      if (variant.sku.contains('GB')) {
        final ramMatch = RegExp(r'(\d+GB)').firstMatch(variant.sku);
        if (ramMatch != null) {
          ramSet.add(ramMatch.group(1)!);
        }
      }
    }
    return ramSet.toList();
  }

  /// Get all unique Storage values from variants
  List<String> getUniqueStorageOptions() {
    final storageSet = <String>{};
    for (var variant in variants) {
      if (variant.sku.contains('TB') || variant.sku.contains('GB')) {
        final storageMatch = RegExp(r'(\d+TB|\d+GB)').firstMatch(variant.sku);
        if (storageMatch != null) {
          storageSet.add(storageMatch.group(1)!);
        }
      }
    }
    return storageSet.toList();
  }

  /// Find variants matching specific criteria
  List<ProductVariant> findVariantsByRAMAndStorage(
    String? ram,
    String? storage,
  ) {
    return variants.where((v) {
      bool ramMatch = ram == null || v.sku.contains(ram);
      bool storageMatch = storage == null || v.sku.contains(storage);
      return ramMatch && storageMatch;
    }).toList();
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    final variantsList =
        (json['variants'] as List?)
            ?.map((v) => ProductVariant.fromJson(v))
            .toList() ??
        [];

    final specificationsList =
        (json['specifications'] as List?)
            ?.map((s) => ProductSpecification.fromJson(s))
            .toList() ??
        [];

    return ProductDetailModel(
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      brandName: json['brandName'] as String?,
      categoryName: json['categoryName'] as String?,
      warrantyMonths: json['warrantyMonths'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      coverImage: json['coverImage'] as String?,
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      variants: variantsList,
      specifications: specificationsList,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'brandName': brandName,
      'categoryName': categoryName,
      'warrantyMonths': warrantyMonths,
      'isActive': isActive,
      'coverImage': coverImage,
      'galleryImages': galleryImages,
      'variants': variants.map((v) => v.toJson()).toList(),
      'specifications': specifications.map((s) => s.toJson()).toList(),
      'averageRating': averageRating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

/// Product Variant Model
class ProductVariant {
  final int variantId;
  final String sku;
  final decimal? price;
  final decimal? finalPrice;
  final int stock;
  final decimal? discountPercentage;
  final decimal? discountAmount;
  final DateTime? discountStart;
  final DateTime? discountEnd;
  final List<String> specifications;
  final List<Map<String, dynamic>> variantSpecifications;

  ProductVariant({
    required this.variantId,
    required this.sku,
    this.price,
    this.finalPrice,
    required this.stock,
    this.discountPercentage,
    this.discountAmount,
    this.discountStart,
    this.discountEnd,
    this.specifications = const [],
    this.variantSpecifications = const [],
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      variantId: json['variantId'] as int? ?? 0,
      sku: json['sku'] as String? ?? '',
      price: _parseDecimal(json['price']),
      finalPrice: _parseDecimal(json['finalPrice']),
      stock: json['stock'] as int? ?? 0,
      discountPercentage: _parseDecimal(json['discountPercentage']),
      discountAmount: _parseDecimal(json['discountAmount']),
      discountStart: json['discountStart'] != null
          ? DateTime.parse(json['discountStart'] as String)
          : null,
      discountEnd: json['discountEnd'] != null
          ? DateTime.parse(json['discountEnd'] as String)
          : null,
      specifications: List<String>.from(json['specifications'] ?? []),
      variantSpecifications: List<Map<String, dynamic>>.from(
        (json['variantSpecifications'] as List?)?.map(
              (spec) => Map<String, dynamic>.from(spec as Map),
            ) ??
            [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variantId': variantId,
      'sku': sku,
      'price': price,
      'finalPrice': finalPrice,
      'stock': stock,
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'discountStart': discountStart?.toIso8601String(),
      'discountEnd': discountEnd?.toIso8601String(),
      'specifications': specifications,
      'variantSpecifications': variantSpecifications,
    };
  }
}

/// Product Specification Model
class ProductSpecification {
  final String specificationName;
  final String dataType;
  final String? valueText;
  final double? valueNumber;
  final bool? valueBool;
  final String? optionValue;

  ProductSpecification({
    required this.specificationName,
    required this.dataType,
    this.valueText,
    this.valueNumber,
    this.valueBool,
    this.optionValue,
  });

  factory ProductSpecification.fromJson(Map<String, dynamic> json) {
    return ProductSpecification(
      specificationName: json['specificationName'] as String? ?? '',
      dataType: json['dataType'] as String? ?? 'text',
      valueText: json['valueText'] as String?,
      valueNumber: (json['valueNumber'] as num?)?.toDouble(),
      valueBool: json['valueBool'] as bool?,
      optionValue: json['optionValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specificationName': specificationName,
      'dataType': dataType,
      'valueText': valueText,
      'valueNumber': valueNumber,
      'valueBool': valueBool,
      'optionValue': optionValue,
    };
  }

  /// Get display value based on data type
  String getDisplayValue() {
    if (valueText != null) return valueText!;
    if (valueNumber != null) return valueNumber.toString();
    if (valueBool != null) return valueBool! ? 'Yes' : 'No';
    if (optionValue != null) return optionValue!;
    return 'N/A';
  }
}

/// Helper function to parse decimal values from JSON
decimal? _parseDecimal(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

// Alias for double (represents decimal price values)
typedef decimal = double;
