import 'package:flutter/material.dart';

class AppSpacing {
  // Height spacing
  static const double spacing4 = 4.0;
  static const double spacing6 = 6.0;
  static const double spacing8 = 8.0;
  static const double spacing10 = 10.0;
  static const double spacing12 = 12.0;
  static const double spacing14 = 14.0;
  static const double spacing16 = 16.0;
  static const double spacing18 = 18.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;

  // Common SizedBox instances
  static const SizedBox verticalSpacing4 = SizedBox(height: spacing4);
  static const SizedBox verticalSpacing6 = SizedBox(height: spacing6);
  static const SizedBox verticalSpacing8 = SizedBox(height: spacing8);
  static const SizedBox verticalSpacing10 = SizedBox(height: spacing10);
  static const SizedBox verticalSpacing12 = SizedBox(height: spacing12);
  static const SizedBox verticalSpacing16 = SizedBox(height: spacing16);
  static const SizedBox verticalSpacing20 = SizedBox(height: spacing20);
  static const SizedBox verticalSpacing24 = SizedBox(height: spacing24);
  static const SizedBox verticalSpacing32 = SizedBox(height: spacing32);
  static const SizedBox verticalSpacing40 = SizedBox(height: spacing40);

  static const SizedBox horizontalSpacing4 = SizedBox(width: spacing4);
  static const SizedBox horizontalSpacing6 = SizedBox(width: spacing6);
  static const SizedBox horizontalSpacing8 = SizedBox(width: spacing8);
  static const SizedBox horizontalSpacing10 = SizedBox(width: spacing10);
  static const SizedBox horizontalSpacing12 = SizedBox(width: spacing12);
  static const SizedBox horizontalSpacing16 = SizedBox(width: spacing16);
  static const SizedBox horizontalSpacing20 = SizedBox(width: spacing20);
  static const SizedBox horizontalSpacing24 = SizedBox(width: spacing24);

  // Common padding instances
  static const EdgeInsets padding4 = EdgeInsets.all(spacing4);
  static const EdgeInsets padding6 = EdgeInsets.all(spacing6);
  static const EdgeInsets padding8 = EdgeInsets.all(spacing8);
  static const EdgeInsets padding10 = EdgeInsets.all(spacing10);
  static const EdgeInsets padding12 = EdgeInsets.all(spacing12);
  static const EdgeInsets padding14 = EdgeInsets.all(spacing14);
  static const EdgeInsets padding16 = EdgeInsets.all(spacing16);
  static const EdgeInsets padding20 = EdgeInsets.all(spacing20);
  static const EdgeInsets padding24 = EdgeInsets.all(spacing24);

  static const EdgeInsets paddingHorizontal12Vertical12 = EdgeInsets.symmetric(
    horizontal: spacing12,
    vertical: spacing12,
  );
  static const EdgeInsets paddingHorizontal12Vertical14 = EdgeInsets.symmetric(
    horizontal: spacing12,
    vertical: spacing14,
  );
  static const EdgeInsets paddingHorizontal14Vertical14 = EdgeInsets.symmetric(
    horizontal: spacing14,
    vertical: spacing14,
  );
  static const EdgeInsets paddingHorizontal16Vertical8 = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing8,
  );
  static const EdgeInsets paddingHorizontal16Vertical16 = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing16,
  );
  static const EdgeInsets paddingHorizontal8Vertical8 = EdgeInsets.symmetric(
    horizontal: spacing8,
    vertical: spacing8,
  );
}
