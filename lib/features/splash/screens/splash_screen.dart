// ignore_for_file: library_private_types_in_public_api
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/features/tab/screen/tab_screen.dart';
import 'package:pixura_ai/core/router/routes.dart';
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
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _taglineFadeAnimation;
  late Animation<double> _subtitleFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Logo slides from top and scales in
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -2.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _logoScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Tagline fades in after logo
    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    // Subtitle fades in later
    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.9, curve: Curves.easeIn),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 800), () async {
          if (!mounted) return;

          final authProvider = context.read<AuthProvider>();

          bool hasSeenOnboarding = await secureStorage.getBoolAsync(
            AppString.hasSeenOnboarding,
          );

          if (!hasSeenOnboarding) {
            if (!mounted) return;
            Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
            return;
          }

          String accessToken = await secureStorage.getStringAsync(
            AppString.tokenKey,
          );
          bool isLoggedOut = await secureStorage.getBoolAsync(
            AppString.isLoggedOut,
          );

          if (accessToken.isNotEmpty && isLoggedOut) {
            if (!mounted) return;
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            return;
          }

          if (accessToken.isNotEmpty && !isLoggedOut) {
            try {
              await authProvider.loadAndSyncUser().timeout(
                const Duration(seconds: 5),
                onTimeout: () {
                  DebugPoint.warning(
                    'loadAndSyncUser timeout - proceeding with navigation',
                  );
                },
              );
            } catch (e) {
              DebugPoint.error('Error in loadAndSyncUser: $e');
            }

            if (!mounted) return;

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
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
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
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.08),
              theme.colorScheme.surface,
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            // Animated logo
            SlideTransition(
              position: _logoSlideAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    AssetsConstants.heartstyle,
                    height: 100.h,
                    width: 150.w,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // App name
            FadeTransition(
              opacity: _taglineFadeAnimation,
              child: Text(
                'Pixura AI',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // Subtitle
            FadeTransition(
              opacity: _subtitleFadeAnimation,
              child: Text(
                'Create. Post. Inspire.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 2.0,
                ),
              ),
            ),

            const Spacer(flex: 4),

            // Loading indicator at bottom
            Padding(
              padding: EdgeInsets.only(bottom: 48.h),
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
