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
export 'package:first/core/app_constant.dart';

// ==================== PROJECT WIDGETS ====================
// Barrel export for all common widgets
export 'package:first/widgets/widgets.dart' hide session;

// ==================== PROJECT SCREENS (Common Navigation) ====================
// Navigation screens used across multiple pages
export 'package:first/main-home.dart';
export 'package:first/screens/add_to_card_page.dart';
export 'package:first/screens/product_detail_page.dart';
export 'package:first/screens/profile_page.dart';
export 'package:first/screens/notification_page.dart';
export 'package:first/screens/wishlist_page.dart';
export 'package:first/screens/checkout_page.dart';
export 'package:first/screens/category_view_page.dart';
export 'package:first/screens/order_tracking_page.dart';
export 'package:first/screens/order_history_page.dart';
export 'package:first/screens/order_receipt_page.dart';
export 'package:first/screens/order_confirmation_success_screen.dart';
export 'package:first/screens/return_refund_page.dart';
export 'package:first/screens/email_verification_page.dart';
export 'package:first/screens/login_page.dart';
export 'package:first/screens/signup_page.dart';
export 'package:first/screens/comparison_page.dart';
export 'package:first/screens/edit_profile_page.dart';
export 'package:first/screens/faqs_page.dart';
export 'package:first/screens/contact_page.dart';
export 'package:first/screens/complaints_page.dart';
export 'package:first/screens/add_complaints_form_page.dart';
export 'package:first/screens/complaint_detail_page.dart';
// export 'package:first/screens/address_book_page.dart';
export 'package:first/widgets/categories_display_widget.dart';

// ==================== THIRD-PARTY PACKAGES ====================
// Image handling
export 'package:image_picker/image_picker.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:file_picker/file_picker.dart';
// API & Networking
export 'package:dio/dio.dart';

// ==================== PROJECT MODELS & SERVICES ====================
export 'package:first/models/models.dart';
export 'package:first/services/services.dart';
export 'package:first/services/user_session_manager.dart';
export 'package:first/services/api/address_service.dart';
export 'package:first/services/api/user_profile_service.dart';
export 'package:first/services/api/order_address_service.dart';
export 'package:first/services/api/payment_service.dart';
export 'package:first/models/create_address_model.dart';
export 'package:first/models/category_model.dart';
export 'package:first/services/api/category_service.dart';

// ==================== PROJECT Font ====================
export 'fontsize.dart';
