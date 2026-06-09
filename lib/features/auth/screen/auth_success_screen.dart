import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/features/auth/controller/profile_provider.dart';


class AuthSuccessScreen extends StatefulWidget {
  const AuthSuccessScreen({super.key});

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile in case it wasn't loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final profile = profileProvider.profile;
    
    // Fallback display values
    final displayName = profile?.fullName ?? authProvider.user?.firstName ?? 'Welcome Back';
    final displayEmail = profile?.email ?? authProvider.user?.email ?? 'Logged In Successfully';
    final displayInitials = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

    return Scaffold(
      body: Stack(
        children: [
          // 1 ── Harmonic Background Gradients
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F172A), // Deep Slate
                    Color(0xFF1E1B4B), // Indigo Dark
                    Color(0xFF311042), // Deep Plum/Aubergine
                  ],
                ),
              ),
            ),
          ),
          
          // Glowing Ambient Orbs for depth
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                    blurRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50.h,
            right: -50.w,
            child: Container(
              width: 350.w,
              height: 350.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD946EF).withValues(alpha: 0.15),
                    blurRadius: 100,
                  ),
                ],
              ),
            ),
          ),

          // 2 ── Main Scrollable View with UI Layout
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 150.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),

                    // Beautiful App Name Branding
                    Text(
                      'BLOOMSY',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 8,
                        color: Colors.white.withValues(alpha: 0.9),
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ).animate().fade(duration: 600.ms).slideY(begin: -0.2, end: 0),

                    SizedBox(height: 40.h),

                    // 3 ── Glassmorphic Dashboard Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Interactive Profile Avatar with subtle glowing rings
                              Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFFD946EF)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 46.r,
                                  backgroundColor: const Color(0xFF1E1E2E),
                                  backgroundImage: profile?.profileImageUrl != null
                                      ? NetworkImage(profile!.profileImageUrl!)
                                      : null,
                                  child: profile?.profileImageUrl == null
                                      ? Text(
                                          displayInitials,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                ),
                              ).animate().scale(delay: 200.ms, duration: 500.ms, curve: Curves.easeOutBack),

                              SizedBox(height: 24.h),

                              // Welcome Text
                              Text(
                                'Account Dashboard',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFD946EF),
                                  letterSpacing: 2,
                                ),
                              ).animate().fade(delay: 350.ms).slideY(begin: 0.2, end: 0),

                              SizedBox(height: 8.h),

                              // Full Name
                              profileProvider.isLoading
                                  ? SizedBox(
                                      height: 36.h,
                                      width: 120.w,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      displayName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ).animate().fade(delay: 450.ms).slideY(begin: 0.2, end: 0),

                              SizedBox(height: 6.h),

                              // Email Info
                              Text(
                                displayEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.6),
                                ),
                              ).animate().fade(delay: 550.ms).slideY(begin: 0.2, end: 0),

                              SizedBox(height: 30.h),
                              
                              Divider(color: Colors.white.withValues(alpha: 0.1)),
                              
                              SizedBox(height: 20.h),

                              // Account Status Widget
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Secure Auth Status',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 8.r,
                                          height: 8.r,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF10B981),
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          'Active',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF34D399),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).animate().fade(delay: 650.ms).slideY(begin: 0.2, end: 0),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fade(delay: 100.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),

                    SizedBox(height: 40.h),

                    // 4 ── Animated Logout Button
                    authProvider.isLoading
                        ? const CircularProgressIndicator(color: Color(0xFFD946EF))
                        : InkWell(
                            onTap: () {
                              authProvider.logOut(context: context, isAccessDenied: false);
                            },
                            borderRadius: BorderRadius.circular(16.r),
                            child: Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFDC2626), // Premium crimson red
                                    Color(0xFF991B1B),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFDC2626).withValues(alpha: 0.2),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ).animate().fade(delay: 750.ms).slideY(begin: 0.3, end: 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
