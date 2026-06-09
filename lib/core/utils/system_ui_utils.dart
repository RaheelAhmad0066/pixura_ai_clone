import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUIUtils {
  /// Configure system UI overlay for light theme
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Configure system UI overlay for dark theme
  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Configure system UI overlay based on theme mode
  static void setStatusBarForTheme(ThemeMode themeMode, BuildContext context) {
    final isDarkMode =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    if (isDarkMode) {
      setDarkStatusBar();
    } else {
      setLightStatusBar();
    }
  }

  /// Ensure status bar is always visible
  static void ensureStatusBarVisible() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // Status bar
        SystemUiOverlay.bottom, // Navigation bar
      ],
    );
  }

  /// Configure system UI for app initialization
  static void initializeSystemUI() {
    // Ensure status bar is visible
    ensureStatusBarVisible();

    // Set initial light theme
    setLightStatusBar();
  }
}
