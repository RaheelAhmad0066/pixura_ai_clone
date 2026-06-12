import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/step_badge.dart';

class SetupVerificationWidget extends StatefulWidget {
  const SetupVerificationWidget({super.key});

  @override
  State<SetupVerificationWidget> createState() =>
      _SetupVerificationWidgetState();
}

class _SetupVerificationWidgetState extends State<SetupVerificationWidget> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<AccountSetupProvider>();
    _otpController = TextEditingController(text: provider.otp);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccountSetupProvider>();
    final isPhone = provider.authMode == AuthMode.phone;
    final bool otpDone = provider.isOtpComplete;

    final logoAsset = isPhone
        ? AssetsConstants.heartstyle
        : AssetsConstants.styleSvg;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // ── Center content ───────────────────────────────────────────
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top image — bigger
                Image.asset(logoAsset, height: 130.h),
                SizedBox(height: 20.h),

                // Slanted Step Badge
                const StepBadge(text: 'step 02'),
                SizedBox(height: 16.h),

                // Title
                Text(
                  isPhone
                      ? "We've sent a 5-digit code\nto your number"
                      : "We've sent a 5-digit code\nto your mail",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 36.h),

                // 5-digit Pinput — centered
                Pinput(
                  controller: _otpController,
                  length: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  onChanged: (val) {
                    provider.updateOtp(val);
                  },
                  defaultPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.w,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.w,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.lemon, // lemon yellow border
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lemon.withValues(alpha: 0.45),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 56.w,
                    height: 56.w,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Pinned bottom buttons ────────────────────────────────────
          Column(
            children: [
              // Resend code — light grey
              CustomButton(
                text: 'Resend code',
                onPressed: () {
                  // Resend action
                },
                buttonColor: Colors.grey.shade100,
                textColor: Colors.black,
                buttonBorderRadius: 16.r,
              ),
              SizedBox(height: 12.h),

              // Continue (empty) → Confirm Code (filled)
              CustomButton(
                text: otpDone ? 'Confirm Code' : 'Continue',
                onPressed: otpDone
                    ? () {
                        provider.nextStep();
                      }
                    : () {},
                isDisabled: !otpDone,
                buttonColor: otpDone
                    ? AppColors.shade900
                    : AppColors.buttonDisabledBg,
                textColor: AppColors.shade100, // always white
                buttonBorderRadius: 16.r,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ],
      ),
    );
  }
}
