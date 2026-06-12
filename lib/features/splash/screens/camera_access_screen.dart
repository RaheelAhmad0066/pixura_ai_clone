import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/widgets/custom_button.dart';

class CameraAccessScreen extends StatefulWidget {
  const CameraAccessScreen({super.key});

  @override
  State<CameraAccessScreen> createState() => _CameraAccessScreenState();
}

class _CameraAccessScreenState extends State<CameraAccessScreen> {
  bool _showPermissionDialog = false;

  Future<void> _completeOnboarding() async {
    await secureStorage.setValue(AppString.hasSeenOnboarding, true);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  void _showIOSDialog() {
    setState(() {
      _showPermissionDialog = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  // Access control pill chip
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mint,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'access control',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Allow access to camera to import and save photos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Illustration in the center
                  SvgPicture.asset(
                    AssetsConstants.lightBubble,
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  // Bottom Buttons
                  CustomButton(
                    text: 'Allow',
                    onPressed: _showIOSDialog,
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                    buttonBorderRadius: 16.r,
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Skip for later',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),

          // Simulated iOS Permission Dialog Overlay
          if (_showPermissionDialog)
            Container(
              color: Colors.black.withValues(alpha: 0.4),
              alignment: Alignment.center,
              child: ZoomInDialog(
                onPressed: (bool allowed) {
                  _completeOnboarding();
                },
              ),
            ),
        ],
      ),
    );
  }
}

class ZoomInDialog extends StatefulWidget {
  final Function(bool) onPressed;

  const ZoomInDialog({super.key, required this.onPressed});

  @override
  State<ZoomInDialog> createState() => _ZoomInDialogState();
}

class _ZoomInDialogState extends State<ZoomInDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 270.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 16.w,
                right: 16.w,
                bottom: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '“Pixura” Would Like to Access the Camera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'The camera is not used directly, but the user is allowed to select a photo from the photo library to transfer through the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            // Divider line
            Container(
              height: 0.5.h,
              color: Colors.grey.shade300,
            ),
            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => widget.onPressed(false),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14.r),
                        ),
                      ),
                    ),
                    child: Text(
                      "Don't Allow",
                      style: TextStyle(
                        color: const Color(0xFF007AFF),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                // Vertical divider
                Container(
                  width: 0.5.w,
                  height: 44.h,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => widget.onPressed(true),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(14.r),
                        ),
                      ),
                    ),
                    child: Text(
                      'Allow',
                      style: TextStyle(
                        color: const Color(0xFF007AFF),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
