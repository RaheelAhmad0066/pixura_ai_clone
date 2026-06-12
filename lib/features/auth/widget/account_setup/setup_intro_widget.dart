import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/widgets/custom_button.dart';

class SetupIntroWidget extends StatelessWidget {
  const SetupIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AccountSetupProvider>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Card
          Container(
            height: 410.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.asset(
                AssetsConstants.illustration7,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          // Title
          Text(
            'Create any image\nyou can dream up.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 32.h),
          // Continue with Phone
          CustomButton(
            text: 'Continue with Phone',
            onPressed: () {
              provider.setAuthMode(AuthMode.phone);
              provider.nextStep();
            },
            buttonColor: Colors.black,
            textColor: Colors.white,
            buttonBorderRadius: AppConstants.mediumRadius,
          ),
          SizedBox(height: 12.h),
          // Continue with Email
          CustomButton(
            text: 'Continue with Email',
            onPressed: () {
              provider.setAuthMode(AuthMode.email);
              provider.nextStep();
            },
            buttonColor: Colors.grey.shade100,
            textColor: Colors.black,
            buttonBorderRadius: AppConstants.mediumRadius,
          ),
          SizedBox(height: 14.h),
          // Social buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Apple Sign In
              GestureDetector(
                onTap: () {
                  provider.setStep(3); // Direct to welcome for simulation
                },
                child: Container(
                  width: 152.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(
                      AppConstants.mediumRadius,
                    ),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Center(
                    child: Icon(Icons.apple, color: Colors.black, size: 24),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Google Sign In
              GestureDetector(
                onTap: () {
                  provider.setStep(3); // Direct to welcome for simulation
                },
                child: Container(
                  width: 152.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(
                      AppConstants.mediumRadius,
                    ),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/social media.svg',
                      width: 22.w,
                      height: 22.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
