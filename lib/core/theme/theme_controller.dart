import 'package:flutter/material.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark;
  ThemeMode get currentTheme => _currentTheme;

  ThemeController() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    try {
      final isDark = await secureStorage.getBoolAsync(
        'is_dark',
        defaultValue: true,
      );
      _currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    } catch (e) {
      DebugPoint.log('Error loading theme preference: $e');
      _currentTheme = ThemeMode.dark;
    }
  }

  themeChange(bool isDark) {
    if (isDark) {
      _currentTheme = ThemeMode.dark;
    } else {
      _currentTheme = ThemeMode.light;
    }
    return;
  }

  void toggleTheme() async {
    if (_currentTheme == ThemeMode.light) {
      _currentTheme = ThemeMode.dark;

      DebugPoint.log('Dark Theme ${_currentTheme.toString()}');
      await secureStorage.setValue('is_dark', true);
    } else {
      _currentTheme = ThemeMode.light;
      DebugPoint.log('Light Theme ${_currentTheme.toString()}');
      await secureStorage.setValue('is_dark', false);
    }
    notifyListeners();
  }
}
