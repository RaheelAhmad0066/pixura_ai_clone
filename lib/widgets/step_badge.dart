import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';

class StepBadge extends StatelessWidget {
  final String text;
  final Color? color;

  const StepBadge({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -4.5 * math.pi / 180, // Tilted to the left by ~4.5 degrees
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.lemon, // Use provided color or default lemon
          borderRadius: BorderRadius.circular(8.r), // Rounded rect matching mockup
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w900, // Thick bold text
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
