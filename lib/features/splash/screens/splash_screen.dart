// ignore_for_file: library_private_types_in_public_api
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/features/auth/screen/login_screen.dart';
// import 'package:pixura_ai/features/onboarding/screen/onboarding_screen.dart';
// import 'package:pixura_ai/features/settings/controller/profile_provider.dart';
import 'package:pixura_ai/features/tab/screen/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Logo animation - starts from top and moves to center
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -30), // Start above the screen
      end: Offset.zero, // End at center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Wait for 500ms before starting the transition
        Future.delayed(const Duration(milliseconds: 500), () async {
          if (!mounted) return;

          // Capture providers synchronously before any await gap
          final authProvider = context.read<AuthProvider>();
          // final profileProvider = context.read<ProfileProvider>();

          bool hasSeenOnboarding = await secureStorage.getBoolAsync(
            AppString.hasSeenOnboarding,
          );

          if (!hasSeenOnboarding) {
            if (!mounted) return;
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            // );
            return;
          }

          String accessToken = await secureStorage.getStringAsync(
            AppString.tokenKey,
          );
          bool isLoggedOut = await secureStorage.getBoolAsync(
            AppString.isLoggedOut,
          );

          // Check if user has token but is logged out
          if (accessToken.isNotEmpty && isLoggedOut) {
            // User was logged out, go to welcome screen
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionDuration: const Duration(milliseconds: 800),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutQuart,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
              ),
            );
            return;
          }

          if (accessToken.isNotEmpty && !isLoggedOut) {
            // Load and sync user, then navigate
            // Add timeout to ensure navigation happens even if sync takes too long
            try {
              await authProvider.loadAndSyncUser().timeout(
                const Duration(seconds: 5),
                onTimeout: () {
                  DebugPoint.warning(
                    'loadAndSyncUser timeout - proceeding with navigation',
                  );
                },
              );
              // Also refresh the ProfileProvider so UI reflects latest data
              // if (mounted) {
              //   await profileProvider.fetchProfile().timeout(
              //     const Duration(seconds: 5),
              //     onTimeout: () {},
              //   );
              // }
            } catch (e) {
              DebugPoint.error('Error in loadAndSyncUser: $e');
            }

            if (!mounted) return;

            // Session is still valid, go directly to target screen
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const TabScreen(initialIndex: 0),
                transitionDuration: const Duration(milliseconds: 800),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutQuart,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
              ),
            );
          } else {
            if (!mounted) return;

            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionDuration: const Duration(milliseconds: 800),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutQuart,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
              ),
            );
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo (from top to center)
            SlideTransition(
              position: _logoAnimation,
              child: Hero(
                tag: 'logo',
                child: SvgPicture.asset(
                  AssetsConstants.heartstyle,
                  height: 100.h,
                  width: 150.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
