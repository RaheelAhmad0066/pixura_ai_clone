import 'package:flutter/material.dart';

class AppColors {
  // Main Colors
  static const lemon = Color(0xFFDEFF55);
  static const lavender = Color(0xFFE0CEF5);
  static const mustard = Color(0xFFFAD4B2);
  static const aqua = Color(0xFFCFF8EB);
  static const foggy = Color(0xFFF0F5ED);
  static const cyan = Color(0xFFDFF9FD);
  static const lightGreen = Color(0xFFE4F9D3);
  static const olive = Color(0xFFFEFAE0);
  static const mint = Color(0xFFBFF3D6);
  static const skies = Color(0xFFB6DDF9);
  static const frost = Color(0xFFC9F5D3);
  static const breeze = Color(0xFF98E8D9);
  static const rose = Color(0xFFFBCDE0);
  static const purple = Color(0xFFC0ACFB);

  // Color Shades (Grayscale)
  static const shade900 = Color(0xFF000000); // Black
  static const shade800 = Color(0xFF333333);
  static const shade700 = Color(0xFF666666);
  static const shade600 = Color(0xFF999999);
  static const shade500 = Color(0xFFCCCCCC);
  static const shade400 = Color(0xFFE6E6E6);
  static const shade300 = Color(0xFFF2F2F2);
  static const shade200 = Color(0xFFF9F9F9);
  static const shade100 = Color(0xFFFFFFFF); // White

  // Shadows
  static const BoxShadow shadowSoft = BoxShadow(
    color: Color(0x0C000000), // 5% opacity
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static const BoxShadow shadowMedium = BoxShadow(
    color: Color(0x1A000000), // 10% opacity
    blurRadius: 20,
    offset: Offset(0, 8),
  );

  static const BoxShadow shadowStrong = BoxShadow(
    color: Color(0x26000000), // 15% opacity
    blurRadius: 30,
    offset: Offset(0, 12),
  );

  // ── TextField ────────────────────────────────────────────────
  /// Default fill for light-mode text fields
  static const textFieldFillLight = Color(0xFFEDEBEE);

  /// Default fill for dark-mode text fields
  static const textFieldFillDark = Color(0xff242424);

  // ── Button states ────────────────────────────────────────────
  /// Disabled button background
  static const buttonDisabledBg = Color.fromARGB(255, 108, 108, 109);

  /// Disabled button text / icon color
  static const buttonDisabledText = Colors.white;
}
