class CategoryModel {
  final int categoryId;
  final String categoryName;
  final String? categoryImage;
  final int? parentCategoryId;
  final List<CategoryModel> subcategories;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    this.categoryImage,
    this.parentCategoryId,
    this.subcategories = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      categoryImage: json['categoryImage'],
      parentCategoryId: json['parentCategoryId'],
      subcategories:
          (json['subcategories'] as List?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'parentCategoryId': parentCategoryId,
      'subcategories': subcategories.map((e) => e.toJson()).toList(),
    };
  }
}
