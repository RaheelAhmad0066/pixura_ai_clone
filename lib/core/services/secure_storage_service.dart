import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'dart:convert';

/// Secure storage service to replace nb_utils storage methods
/// Provides encrypted storage for sensitive data like tokens and user information
class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device,
    ),
  );

  /// Write a value (handles String, int, bool, Map, List)
  Future<void> setValue(String key, dynamic value) async {
    String stringValue;
    if (value is Map || value is List) {
      stringValue = jsonEncode(value);
    } else {
      stringValue = value.toString();
    }
    await _storage.write(key: key, value: stringValue);
  }

  /// Read a string value
  Future<String> getStringAsync(String key, {String defaultValue = ''}) async {
    final value = await _storage.read(key: key);
    return value ?? defaultValue;
  }

  /// Read a boolean value
  Future<bool> getBoolAsync(String key, {bool defaultValue = false}) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  /// Read an integer value
  Future<int> getIntAsync(String key, {int defaultValue = 0}) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  /// Read a JSON object (Map)
  Future<Map<String, dynamic>> getJSONAsync(String key) async {
    final value = await _storage.read(key: key);
    if (value == null || value.isEmpty) return {};
    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  /// Remove a key
  Future<void> removeKey(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all storage
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Check if this is a fresh install and clear keychain if needed
  /// This solves the iOS Keychain persistence issue across app reinstalls
  Future<void> clearKeychainOnFreshInstall() async {
    const installFlagKey = 'app_installed_flag';

    // Check if the flag exists in SharedPreferences (via nb_utils)
    // SharedPreferences is cleared on app uninstall, unlike Keychain
    final hasInstallFlag = nb.getBoolAsync(installFlagKey, defaultValue: false);

    if (!hasInstallFlag) {
      // This is a fresh install - clear all keychain data
      await _storage.deleteAll();
      // Set the flag so we don't clear again (using nb_utils)
      await nb.setValue(installFlagKey, true);
    }
  }
}

// Global instance for easy access
final secureStorage = SecureStorageService();
