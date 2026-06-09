import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    canvasColor: const Color(0xFFFAFAFA),
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    useMaterial3: true,
    brightness: Brightness.light,
    cardColor: Color(0xFF6B7280),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFAFAFA)),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: const Color(0xFF6B7280),
      surface: const Color(0xFFF3F4F6),
      onSurface: const Color(0xFF1F2937),
      inversePrimary: const Color(0xFFF3E8FF),
      tertiary: const Color(0xFF6B7280),
      onTertiary: const Color(0xFF111827),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppColorsExtension(
        greySolid: const Color(0xFF6B7280),
        grey200: const Color(0xFFE5E7EB),
        grey100: const Color(0xFFF3F4F6),
        grey: const Color(0xFF6B7280),
        lightGrey: const Color(0xFFF9FAFB),
        backgroundColor: const Color(0xFFFAFAFA),
        componentBackgroundColor: Colors.white,
        secondaryBlack: const Color(0xFF1F2937),
        primaryTextColor: const Color(0xFF111827),
        secondaryTextColor: const Color(0xFF6B7280),
        blue300: const Color(0xFF93C5FD),
        blue400: const Color(0xFF60A5FA),
        switchActiveTrack: AppColors.switchActiveTrack,
        switchInactiveTrack: const Color(0xFFD1D5DB),
        switchThumb: AppColors.switchThumb,
        selectionHighlight: AppColors.selectionHighlight,
        selectionHighlightText: AppColors.selectionHighlightText,
        successBackground: const Color(0xFFF0FDF4),
        successForeground: const Color(0xFF10B981),
        successBorder: const Color(0xFFA7F3D0),
        warningBackground: const Color(0xFFFEF3C7),
        warningForeground: const Color(0xFFF59E0B),
        infoBackground: const Color(0xFFEFF6FF),
        infoBorder: const Color(0xFFBFDBFE),
        infoColor: const Color(0xFF3B82F6),
        iconBackgroundYellow: const Color(0xFFFEF3C7),
        statusScheduledColor: const Color(0xFFF59E0B),
        statusScheduledBg: const Color(0xFFFEF3C7),
        statusInProgressColor: const Color(0xFF3B82F6),
        statusInProgressBg: const Color(0xFFEFF6FF),
        statusCompletedColor: const Color(0xFF10B981),
        statusCompletedBg: const Color(0xFFF0FDF4),
        statusDelayedColor: const Color(0xFFEF4444),
        statusDelayedBg: const Color(0xFFFEE2E2),
        statusCancelledColor: const Color(0xFF9CA3AF),
        statusCancelledBg: const Color(0xFFF3F4F6),
        gradientOrangeStart: AppColors.gradientOrangeStart,
        gradientOrangeEnd: AppColors.gradientOrangeEnd,
        fieldLogBrown: const Color(0xFF92400E),
        jobStatusOrange: const Color(0xFFF97316),
      ),
    ],
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF111827),
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111827),
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111827),
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF111827),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111827),
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF374151),
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F2937),
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF374151),
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF6B7280),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111827),
      ),
      labelMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF111827),
      ),
      labelSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF111827),
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1F2937),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF374151),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF6B7280),
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff111111),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: const Color(0xff282828),
      surface: const Color(0xFF18181F),
      inversePrimary: Color.fromARGB(255, 24, 24, 24),
      onSurface: Colors.white,
      tertiary: Color(0xFF9CA3AF),
      onTertiary: Colors.white,
    ),
    brightness: Brightness.dark,
    cardColor: const Color(0xFF18181F),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff111111)),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xff1E1E1E),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const Color(0xff1E1E1E),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppColorsExtension(
        greySolid: Color(0xFFB0B3B8), // Lighter grey for dark mode
        grey200: Color(0xFF2C3036), // Darker grey for containers
        grey100: Color(0xFF1F2937),
        grey: Color(0xFF9CA3AF),
        lightGrey: Color(0xFF374151),
        backgroundColor: Color(0xff111111),
        componentBackgroundColor: const Color(0xFF18181F),
        secondaryBlack: Colors.white,
        primaryTextColor: Colors.white,
        secondaryTextColor: Color(0xFF9CA3AF),
        blue300: Color(0xFFD1D5DB), // Light grey for dark mode
        blue400: Color(0xFF9CA3AF), // Slightly darker grey for dark mode
        switchActiveTrack: AppColors.switchActiveTrack,
        switchInactiveTrack: Color(0xFF4A4A4A), // Darker for dark mode
        switchThumb: AppColors.switchThumb,
        selectionHighlight: AppColors.selectionHighlight,
        selectionHighlightText: AppColors.selectionHighlightText,
        successBackground: AppColors.successBackgroundDark,
        successForeground: AppColors.successForeground,
        successBorder: Color(0xFF1A5A3A), // Darker border for dark mode
        warningBackground: AppColors.warningBackgroundDark,
        warningForeground: AppColors.warningForeground,
        infoBackground: Color(0xFF1E3A5F), // Darker blue for dark mode
        infoBorder: Color(0xFF2E5A8F), // Darker border for dark mode
        infoColor: Color(0xFF64B5F6), // Lighter blue for dark mode
        iconBackgroundYellow: Color(
          0xFF4A4020,
        ), // Darker yellow bg for dark mode
        statusScheduledColor: AppColors.statusScheduledColor,
        statusScheduledBg: Color(0xFF4A3F1A), // Darker for dark mode
        statusInProgressColor: Color(0xFF64B5F6), // Lighter blue for dark mode
        statusInProgressBg: Color(0xFF1E3A5F), // Darker for dark mode
        statusCompletedColor: AppColors.statusCompletedColor,
        statusCompletedBg: Color(0xFF1A3A2A), // Darker for dark mode
        statusDelayedColor: Color(0xFFEF5350), // Lighter red for dark mode
        statusDelayedBg: Color(0xFF4A1A1A), // Darker for dark mode
        statusCancelledColor: Color(0xFFBDBDBD), // Lighter grey for dark mode
        statusCancelledBg: Color(0xFF2A2A2A), // Darker for dark mode
        gradientOrangeStart: AppColors.gradientOrangeStart,
        gradientOrangeEnd: AppColors.gradientOrangeEnd,
        fieldLogBrown: Color(0xFFBCAAA4), // Lighter brown for dark mode
        jobStatusOrange: Color(0xFFFF9800), // Lighter orange for dark mode
      ),
    ],
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
