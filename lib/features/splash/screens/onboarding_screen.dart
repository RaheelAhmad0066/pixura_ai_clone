import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = true;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Ultra Resolution',
      'subtitle':
          'No more pixelated graphics or low-quality visuals every image is crafted for maximum impact.',
      'image': AssetsConstants.onboarding1,
    },
    {
      'title': 'Premium Images',
      'subtitle': 'Unlock unlimited images by a world of global creators.',
      'image': AssetsConstants.onboarding2,
    },
    {
      'title': 'Effortless Image Generation',
      'subtitle':
          'Simply type a prompt, choose a style, and watch as AI brings it idea to life.',
      'image': AssetsConstants.onboarding3,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Bypassing session check for UI-only testing so Onboarding shows on every reload
    _isLoading = false;
  }

  // ignore: unused_element
  Future<void> _checkSessionAndRedirect() async {
    bool hasSeenOnboarding = await secureStorage.getBoolAsync(
      AppString.hasSeenOnboarding,
    );

    if (hasSeenOnboarding) {
      if (!mounted) return;
      final authProvider = context.read<AuthProvider>();

      String accessToken = await secureStorage.getStringAsync(
        AppString.tokenKey,
      );
      bool isLoggedOut = await secureStorage.getBoolAsync(
        AppString.isLoggedOut,
      );

      if (accessToken.isNotEmpty && !isLoggedOut) {
        try {
          await authProvider.loadAndSyncUser().timeout(
            const Duration(seconds: 4),
            onTimeout: () {},
          );
        } catch (_) {}
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppRoutes.tabs);
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onNextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.cameraAccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              final item = _onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Fullscreen image
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                  // Dark gradient overlay for readability of text
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  // Content details
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h),
                          // Title
                          Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Subtitle
                          Text(
                            item['subtitle']!,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Intro Chip
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.purple.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'Intro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom Controls: Button & Indicators
          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular/Rounded action button
                GestureDetector(
                  onTap: _onNextPage,
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 5.h,
                      width: _currentPage == index ? 24.w : 6.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
