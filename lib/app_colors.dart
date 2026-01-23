import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // theme Colors
  static const Color secondaryColor1 = Color(0xFF0995D3);
  static const Color secondaryColor2 = Color.fromARGB(228, 47, 134, 172);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(108 * 3.1415926535 / 180),
    colors: [Color.fromRGBO(161, 78, 150, 1), Color.fromRGBO(10, 133, 185, 1)],
    stops: [0.3264, 0.8233],
  );

  static const LinearGradient secondaryBGGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(128 * 3.1415926535 / 180), // 128deg
    colors: [
      Color.fromRGBO(191, 112, 180, 0.2),
      Color.fromRGBO(9, 150, 211, 0.1),
    ],
    stops: [0.089, 0.9154],
  );


  static const LinearGradient bgLightGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(135 * 3.1415926535 / 180),
    colors: [
      Color.fromRGBO(236, 136, 223, 0.712),
      Color.fromRGBO(17, 167, 231, 0.102),
    ],
    stops: [0.089, 0.9154],
  );

  static const LinearGradient tooLightGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(135 * 3.1415926535 / 180),
    colors: [
      Color.fromRGBO(241, 169, 231, 0.678),
      Color.fromRGBO(148, 223, 255, 0.527),
    ],
    stops: [0.089, 0.9154],
  );

  static const Color bluePrimaryColor = Color.fromRGBO(17, 167, 231, 0.102);
  static const Color pinkPrimaryColor = Color.fromRGBO(241, 169, 232, 1);
  static const Color bgPrimaryColor = Color.fromRGBO(161, 78, 150, 1);

  static const Color bgGradientHeading = Colors.white;
  static const Color productDisplayWidgetBackground = Color(0xFFF5F5F5);

  // glassmorphism Colors
  static const Color glassmorphismWhite = Color.fromARGB(35, 255, 255, 255);
  static const Color glassmorphismBlack = Color.fromARGB(35, 0, 0, 0);

  static const Color glassmorphismBorderWhite = Color.fromARGB(
    70,
    255,
    255,
    255,
  );
  static const Color glassmorphismBorderBlack = Color.fromARGB(70, 0, 0, 0);

  static const Color glassmorphismBoxShadowWhite = Color.fromARGB(
    100,
    255,
    255,
    255,
  );
  static const Color glassmorphismBoxShadowBlack = Color.fromARGB(100, 0, 0, 0);

  // specific widget Colors
  static const Color productCategoryCardBackground = Color.fromARGB(
    255,
    218,
    218,
    218,
  );

  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryBlueDark = Color(0xFF1976D2);
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryGreenLight = Color(0xFF7CB342);
  static const Color primaryGreenLighter = Color(0xFF9CCC65);
  static const Color primaryOrange = Color(0xFFF7941D);
  static const Color primaryOrangeAlt = Color(0xFFFF9800);
  static const Color primaryPurple = Color(0xFF9C27B0);
  static const Color primaryCyan = Color(0xFF00BCD4);
  static const Color primaryPink = Color(0xFFFF0090);
  static const Color primaryYellow = Color(0xFFFFE66D);
  static const Color primaryAmber = Color(0xFFFFC107);

  // Background Colors
  static const Color backgroundWhite = Colors.white;
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color backgroundGreyLight = Color(0xFFF2F2F2);
  static const Color backgroundGreyLighter = Color(0xFFF3F4F6);
  static const Color backgroundGreyLightest = Color(0xFFF7F7F8);
  static const Color backgroundGrey50 = Colors.grey;
  static const Color backgroundGrey100 = Colors.grey;
  static const Color backgroundBlue50 = Colors.blue;
  static const Color productCardBackgroundLight = Color(0xFFF2F3FA);

  // Text Colors
  static const Color textBlack = Colors.black;
  static const Color textBlack87 = Colors.black87;
  static const Color textGrey = Colors.grey;
  static const Color textGreyDark = Color(0xFF333333);
  static const Color textGreyMedium = Color(0xFF666666);
  static const Color textGreyLight = Color(0xFF999999);
  static const Color textGreyLighter = Color(0xFF888888);
  static const Color textGreyLightest = Color(0xFFCCCCCC);
  static const Color textGreyVeryLight = Color(0xFFBBBBBB);
  static const Color textGreyLabel = Color.fromARGB(255, 132, 134, 136);
  static const Color textGreyIcon = Color(0xFFBDBDBD);
  static const Color textBlack111 = Color(0xFF111111);

  // Border Colors
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color borderGreyLight = Color(0xFFE8E8E8);
  static const Color borderGreyLighter = Color(0xFFE7E9EE);
  static const Color borderGreyDivider = Color(0xFFEEEEEE);
  static const Color borderGreyMedium = Color.fromARGB(255, 158, 158, 158);
  static const Color borderblue = Color(0xFF2196F3);

  // Accent Colors
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color accentSilver = Color(0xFFC0C0C0);
  static const Color accentRed = Colors.red;
  static const Color accentGreen = Colors.green;
  static const Color accentAmber = Colors.amber;
  static const Color accentYellow = Colors.yellow;
  static const Color accentBlue = Colors.blue;

  // Status Colors
  static const Color statusGreen = Color(0xFF4CAF50);
  static const Color statusGreenDark = Color(0xFF2E7D32);
  static const Color statusGreenLight = Color(0xFFE8F5E9);
  static const Color statusOrange = Color(0xFFFF9800);
  static const Color statusOrangeDark = Color(0xFFE65100);
  static const Color statusOrangeLight = Color(0xFFFFF3E0);
  static const Color statusBlueLight = Color(0xFFE3F2FD);
  static const Color statusBlueVeryLight = Color(0xFFEBF6FF);

  // Rating Colors
  static const Color ratingFilled = Color(0xFFFFC107);
  static const Color ratingEmpty = Color(0xFFD0D0D0);

  // Product Colors
  static const Color productCardGrey = Color.fromARGB(183, 161, 161, 161);
  static const Color productCardBackground = Color(0xFFF2F3FA);
  static const Color productDetailGrey = Color.fromARGB(255, 97, 97, 97);
  static const Color productDetailLightGrey = Color.fromARGB(
    255,
    233,
    233,
    233,
  );
  static const Color productGreen = Color(0xFF63C7A8);
  static const Color productGreenAlt = Color(0xFF55C59A);

  // Form Colors
  static const Color formGrey = Color(0xFF999999);
  static const Color formGrey87 = Color.fromARGB(255, 87, 87, 87);
  static const Color formGrey77 = Color.fromARGB(255, 77, 77, 77);
  static const Color formGrey34 = Color.fromARGB(255, 34, 34, 34);
  static const Color formGrey155 = Color.fromARGB(221, 155, 155, 155);
  static const Color formGrey133 = Color.fromARGB(255, 133, 133, 133);
  static const Color formGrey221 = Color.fromARGB(255, 221, 221, 221);
  static const Color formGrey97 = Color.fromARGB(255, 97, 97, 97);
  static const Color formGrey96 = Color.fromARGB(255, 97, 96, 96);
  static const Color formBlack = Color.fromARGB(255, 0, 0, 0);
  static const Color formShadow = Color(0x22000000);

  // Social Media Colors (commented out but preserved)
  // static const Color socialFacebook = Color(0xFF1877F2);
  // static const Color socialInstagram = Color(0xFFE4405F);
  // static const Color socialMusic = Color(0xFF000000);

  // Error/Red Colors
  static const Color statusRed = Color(0xFFE53935);
  static const Color statusRedLight = Color(0xFFFFCDD2);
  static const Color red100 = Color(0xFFFFCDD2);
  static const Color red300 = Color(0xFFEF5350);

  // Additional Status Colors
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusDelivered = Color(0xFF55C59A);
  static const Color statusReturned = Color(0xFFE8F5E9);

  // Opaque/Overlay Colors
  static const Color shadowBlack = Color(0x22000000);
  static const Color shadowBlackLight = Color(0x0A000000);

  // Additional Hex Colors (Used in various places)
  static const Color color111111 = Color(0xFF111111);
  static const Color color2196F3 = Color(0xFF2196F3);
  static const Color color333333 = Color(0xFF333333);
  static const Color color4CAF50 = Color(0xFF4CAF50);
  static const Color color55C59A = Color(0xFF55C59A);
  static const Color color666666 = Color(0xFF666666);
  static const Color color7CB342 = Color(0xFF7CB342);
  static const Color color9AA0A6 = Color(0xFF9AA0A6);
  static const Color color9CCC65 = Color(0xFF9CCC65);
  static const Color colorCECECE = Color(0xFFCECECE);
  static const Color colorE0E0E0 = Color(0xFFE0E0E0);
  static const Color colorE5E5E5 = Color(0xFFE5E5E5);
  static const Color colorE8E8E8 = Color(0xFFE8E8E8);
  static const Color colorE8F5E9 = Color(0xFFE8F5E9);
  static const Color colorFF4757 = Color(0xFFFF4757);
  static const Color colorFFF3E0 = Color(0xFFFFF3E0);

  // Transparent
  static const Color transparent = Colors.transparent;
}
