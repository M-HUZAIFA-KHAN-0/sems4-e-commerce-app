class ProductModel {
  final int productId;
  final String productName;
  final String description;
  final String? coverImage;
  final List<String> galleryImages;
  final double price;
  final int stock;
  final double rating; // from ProductReview API
  final int discount; // static 10%
  final String? brandName;
  final String? categoryName;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.description,
    this.coverImage,
    this.galleryImages = const [],
    required this.price,
    required this.stock,
    required this.rating,
    required this.discount,
    this.brandName,
    this.categoryName,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json, {
    double rating = 0.0,
  }) {
    final variant = (json['variants'] as List?)?.isNotEmpty == true
        ? json['variants'][0]
        : null;

    return ProductModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      description: json['description'] ?? '',
      coverImage: json['coverImage'] as String?,
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      price: variant != null ? (variant['price'] as num).toDouble() : 0.0,
      stock: variant != null ? (variant['stock'] as int) : 0,
      rating: rating,
      discount: 10, // static 10%
      brandName: json['brandName'] as String?,
      categoryName: json['categoryName'] as String?,
    );
  }

  // Convert to JSON (if needed for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'coverImage': coverImage,
      'galleryImages': galleryImages,
      'price': price,
      'stock': stock,
      'rating': rating,
      'discount': discount,
      'brandName': brandName,
      'categoryName': categoryName,
    };
  }

  // Convert to Map (alias for toJson)
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
