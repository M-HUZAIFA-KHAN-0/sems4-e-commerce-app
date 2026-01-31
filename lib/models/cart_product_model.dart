import 'package:flutter/material.dart';

/// Cart product item model
class CartProductItem {
  const CartProductItem({
    required this.id,
    required this.title,
    this.variantText,
    this.ramStorageText,
    this.color,
    required this.priceText,
    required this.quantity,
    required this.stock,
    this.imageProvider,
    this.imageUrl,
    this.isSelected = true,
  });

  final String id;
  final String title;
  final String? variantText;
  final String priceText;
  final String? ramStorageText;
  final String? color;

  /// Initial quantity from parent
  final int quantity;

  /// Max quantity allowed from parent
  final int stock;

  /// Provide either imageProvider or imageUrl
  final ImageProvider? imageProvider;
  final String? imageUrl;

  /// Used by "Clear selected items"
  final bool isSelected;

  CartProductItem copyWith({
    String? id,
    String? title,
    String? variantText,
    String? ramStorageText,
    String? color,
    String? priceText,
    int? quantity,
    int? stock,
    ImageProvider? imageProvider,
    String? imageUrl,
    bool? isSelected,
  }) {
    return CartProductItem(
      id: id ?? this.id,
      title: title ?? this.title,
      variantText: variantText ?? this.variantText,
      ramStorageText: ramStorageText ?? this.ramStorageText,
      color: color ?? this.color,
      priceText: priceText ?? this.priceText,
      quantity: quantity ?? this.quantity,
      stock: stock ?? this.stock,
      imageProvider: imageProvider ?? this.imageProvider,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
