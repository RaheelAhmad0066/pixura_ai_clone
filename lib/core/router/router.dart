import 'package:flutter/material.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/features/splash/screens/splash_screen.dart';
import 'package:pixura_ai/features/splash/screens/onboarding_screen.dart';
import 'package:pixura_ai/features/splash/screens/camera_access_screen.dart';
import 'package:pixura_ai/features/auth/screen/account_setup_screen.dart';
import 'package:pixura_ai/features/tab/screen/tab_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    case AppRoutes.cameraAccess:
      return MaterialPageRoute(builder: (_) => const CameraAccessScreen());
    case AppRoutes.tabs:
      return MaterialPageRoute(builder: (_) => const TabScreen(initialIndex: 0));
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const AccountSetupScreen());

    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
