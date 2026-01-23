// Central imports file for the E-Commerce App

// This file centralizes all commonly used imports across the application.
// Import this file instead of repeating the same imports in every screen/widget.
//
// Usage:
// ```dart
// import 'package:first/core/app_imports.dart';
// ```

// ==================== FLUTTER FRAMEWORK ====================
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';

// ==================== DART STANDARD LIBRARY ====================
export 'dart:io';
export 'dart:async';

// ==================== PROJECT CORE & UTILITIES ====================
export 'package:first/app_colors.dart';
export 'package:first/constants/app_spacing.dart';

// ==================== PROJECT WIDGETS ====================
// Barrel export for all common widgets
export 'package:first/widgets/widgets.dart';

// ==================== PROJECT SCREENS (Common Navigation) ====================
// Navigation screens used across multiple pages
export 'package:first/main-home.dart';
export 'package:first/screens/add_to_card_page.dart';
export 'package:first/screens/product_detail_page.dart';
export 'package:first/screens/profile_page.dart';
export 'package:first/screens/notification_page.dart';
export 'package:first/screens/wishlist_page.dart';
export 'package:first/screens/checkout_page.dart';

// ==================== THIRD-PARTY PACKAGES ====================
// Image handling
export 'package:image_picker/image_picker.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:file_picker/file_picker.dart';
