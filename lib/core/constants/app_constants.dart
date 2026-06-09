import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  AppConstants._();

  static Duration pageTransitionDuration = const Duration(milliseconds: 300);
  static Duration defaultDuration = const Duration(milliseconds: 300);
  static Duration bannerDuration = const Duration(milliseconds: 800);

  static double profilePhotoRadius = 100.r;

  static double largeRadius = 16.r;
  static double mediumRadius = 12.r;
  static double smallRadius = 8.r;
  static double extraLargeRadius = 20.r;
  static double circleRadius = 50.r;

  static double paddingOnly = 12.w;

  static final EdgeInsets defaultPaddingHorizental = EdgeInsets.symmetric(
    horizontal: paddingOnly,
  );

  static final EdgeInsets defaultAllPadding = EdgeInsets.all(paddingOnly);

  // Chip Styling
  static double chipRadius = 20.r;
  static EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 6.h,
  );

  // PRODUCT DETAIL CONSTANTS
  static double productDetailImageHeight = 400.h;
  static double indicatorSize = 8.r;
  static double sizeChipSize = 38.r;

  // ICON BUTTON CONSTANTS
  static double defaultIconButtonSize = 40.r;
  static double defaultIconSize = 20.r;
  // AI ASSISTANT CONSTANTS
  static double aiBubbleRadius = 16.r;
  static double aiProductCardRadius = 12.r;
  static double aiInputRadius = 30.r;
  static double aiIconSize = 16.sp;

  // PRODUCT TILE CONSTANTS
  static double primaryTileHeight = 214.h;
  static double primaryTileWidth = 0.43.sw;
  static double secondaryTileHeight = 100.h;
  static double secondaryTileWidth = 0.8.sw;
}
