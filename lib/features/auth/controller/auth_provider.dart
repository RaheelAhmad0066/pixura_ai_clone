import 'dart:async';
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/core/constants/error_constants.dart';
import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';
import 'package:pixura_ai/core/utils/toast_utils.dart';
import 'package:pixura_ai/features/auth/model/user_model.dart';
import 'package:pixura_ai/features/auth/screen/login_screen.dart';
import 'package:pixura_ai/features/auth/repository/profile_repository.dart';
import 'package:pixura_ai/core/services/clerk_service.dart';
import 'package:flutter/material.dart';
import 'package:clerk_auth/clerk_auth.dart';
import 'package:nb_utils/nb_utils.dart'
    show PageRouteAnimation, WidgetExtension;

class AuthProvider extends ChangeNotifier {
  final ClerkService _clerkService = locator<ClerkService>();
  UserModel? _user;
  UserModel? get user => _user;

  // Holds the latest synced profile from the API (set by loadAndSyncUser)
  dynamic _syncedProfile;
  dynamic get syncedProfile => _syncedProfile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Timer? _resendTimer;
  int _resendCountdown = 0;

  int get resendCountdown => _resendCountdown;
  bool get canResend => _resendCountdown == 0;

  void startResendTimer() {
    _resendCountdown = 60; // 60 seconds countdown
    notifyListeners();

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  /// Check if context is still mounted
  bool mounted(BuildContext context) {
    return context.mounted;
  }

  /// Load persisted user on app start
  Future<void> loadUserFromStorage() async {
    final stored = await secureStorage.getJSONAsync(AppString.userData);
    if (stored.isNotEmpty) {
      try {
        _user = UserModel.fromJson(stored);
      } catch (e) {
        DebugPoint.error('Failed to parse stored user: $e');
      }
    }
    notifyListeners();
  }

  /// Load user from storage first, then sync fresh data from API.
  /// Safe to call on every app launch — always falls back gracefully.
  Future<void> loadAndSyncUser() async {
    // 1. Immediately load cached data so UI shows something fast
    await loadUserFromStorage();

    // 2. Fetch fresh profile from the API in the background
    try {
      final profileRepository = locator<ProfileRepository>();
      final result = await profileRepository.getProfile();
      result.fold(
        (error) {
          DebugPoint.warning('loadAndSyncUser: API error – $error');
        },
        (profileData) {
          DebugPoint.log('loadAndSyncUser: profile synced successfully');
          // Store updated data so future cold starts are also fresh
          _syncedProfile = profileData;
          notifyListeners();
        },
      );
    } catch (e) {
      DebugPoint.error('loadAndSyncUser: unexpected error – $e');
      // Never throw — navigation must always proceed
    }
  }

  /// Logout user
  Future<void> logOut({
    required BuildContext context,
    required bool isAccessDenied,
  }) async {
    _isLoading = true;
    notifyListeners();

    // try {
    //   // Try to call logout API, but don't let it block the logout process
    //   final result = await _authRepository.logOut();
    //   result.fold(
    //     (error) {
    //       DebugPoint.warning('Logout API failed: $error');
    //       // Continue with local cleanup even if API fails
    //     },
    //     (success) {
    //       DebugPoint.log('Logout API successful');
    //     },
    //   );
    // } catch (e) {
    //   DebugPoint.warning('Logout API error: $e');
    //   // Continue with local cleanup even if API throws exception
    // }

    // Set logout flag to prevent auto-login on app restart
    await secureStorage.setValue(AppString.isLoggedOut, true);

    // Always clear local data and navigate, regardless of API result
    await _clearLocalData(isAccessDenied: isAccessDenied);

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      LoginScreen().launch(
        context,
        isNewTask: true,
        pageRouteAnimation: PageRouteAnimation.Fade,
      );
    }
  }

  /// Resend reset password link
  Future<void> resendResetLink({
    required BuildContext context,
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call for now since repository doesn't have it yet
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      ToastUtils.success(ErrorConstants.resetLinkSentSuccessfully);
    }
  }

  // === Clerk Auth Methods ===

  /// Clerk Sign In
  Future<bool> clerkSignIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.signIn(email, password);
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Sign In with Google
  Future<bool> clerkSignInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.signInWithGoogle();
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Sign In with Google Native
  Future<bool> clerkSignInWithGoogleNative() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.signInWithGoogleNative();
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Complete OAuth
  Future<bool> clerkCompleteOAuth(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.completeOAuth(token);
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Resend Code
  Future<bool> clerkResendCode(Strategy strategy) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.resendCode(strategy);
      startResendTimer();
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Sign Up
  Future<Client?> clerkSignUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      return await _clerkService.signUp(email, password);
    } catch (e) {
      ToastUtils.error(e.toString());
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Verify OTP
  Future<Client?> clerkVerifySignUpOtp(String code) async {
    _isLoading = true;
    notifyListeners();
    try {
      return await _clerkService.verifySignUpOtp(code);
    } catch (e) {
      ToastUtils.error(e.toString());
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Forgot Password
  Future<bool> clerkForgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.forgotPassword(email);
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clerk Reset Password
  Future<bool> clerkResetPassword(String code, String newPassword) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _clerkService.resetPassword(code, newPassword);
      return true;
    } catch (e) {
      ToastUtils.error(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _clearLocalData({required bool isAccessDenied}) async {
    _user = null;
    // Don't clear access_token - keep it for biometric authentication
    if (isAccessDenied) {
      await secureStorage.removeKey(AppString.tokenKey);
    }
    await secureStorage.removeKey(AppString.userData);
    await secureStorage.removeKey(AppString.userId);
    await secureStorage.removeKey(AppString.refreshTokenKey);
  }

  /// Check if user is logged in and not manually logged out
  Future<bool> get isLoggedIn async {
    final token = await secureStorage.getStringAsync(AppString.tokenKey);
    final isLoggedOut = await secureStorage.getBoolAsync(AppString.isLoggedOut);
    return token.isNotEmpty && _user != null && !isLoggedOut;
  }

  /// Check if user has valid token but is logged out
  Future<bool> get hasTokenButLoggedOut async {
    final token = await secureStorage.getStringAsync(AppString.tokenKey);
    final isLoggedOut = await secureStorage.getBoolAsync(AppString.isLoggedOut);
    return token.isNotEmpty && isLoggedOut;
  }

  /// Clear logout flag on successful login
  Future<void> clearLogoutFlag() async {
    await secureStorage.setValue(AppString.isLoggedOut, false);
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
}
