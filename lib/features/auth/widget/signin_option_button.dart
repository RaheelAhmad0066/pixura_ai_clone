import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignInOptionButton extends StatelessWidget {
  const SignInOptionButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final VoidCallback onTap;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70.sp,
        decoration: BoxDecoration(
          color: AppColors.shade100,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 45.sp,
                height: 45.sp,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.lavender,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(icon),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Iconsax.arrow_right_1,
                color: AppColors.shade600,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
