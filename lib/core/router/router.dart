import 'package:flutter/material.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/features/auth/screen/verify_otp_screen.dart';
import 'package:pixura_ai/features/auth/screen/signup_screen.dart';
import 'package:pixura_ai/features/auth/screen/login_screen.dart';
import 'package:pixura_ai/features/auth/screen/forgot_password_screen.dart';
import 'package:pixura_ai/features/auth/screen/reset_password_screen.dart';
import 'package:pixura_ai/features/auth/screen/auth_success_screen.dart';
import 'package:pixura_ai/features/splash/screens/splash_screen.dart';
import 'package:pixura_ai/features/tab/screen/tab_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case AppRoutes.tabs:
      return MaterialPageRoute(builder: (_) => const TabScreen(initialIndex: 0));
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => const SignupScreen());
    case AppRoutes.forgotPassword:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case AppRoutes.otpVerify:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder:
            (_) => VerifyOtpScreen(
              email: args?['email'] as String? ?? '',
              isReset: args?['isReset'] as bool? ?? false,
            ),
      );
    case AppRoutes.resetPassword:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder:
            (_) => ResetPasswordScreen(
              isChangePassword: args?['isChangePassword'] as bool? ?? false,
            ),
      );
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const AuthSuccessScreen());

    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
