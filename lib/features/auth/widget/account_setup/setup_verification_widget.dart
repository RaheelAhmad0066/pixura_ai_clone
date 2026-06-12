import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/step_badge.dart';

class SetupVerificationWidget extends StatefulWidget {
  const SetupVerificationWidget({super.key});

  @override
  State<SetupVerificationWidget> createState() => _SetupVerificationWidgetState();
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
    final logoAsset = isPhone ? AssetsConstants.heartstyle : AssetsConstants.styleSvg;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          // Top Logo Shape (Heart or S)
          SvgPicture.asset(
            logoAsset,
            height: 90.h,
          ),
          SizedBox(height: 24.h),
          // Slanted Step Badge
          const StepBadge(text: 'step 02'),
          SizedBox(height: 18.h),
          // Text description
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
          SizedBox(height: 30.h),
          // 5-digit OTP inputs
          Pinput(
            controller: _otpController,
            length: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            onChanged: (val) {
              provider.updateOtp(val);
            },
            defaultPinTheme: PinTheme(
              width: 52.w,
              height: 52.w,
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
              width: 52.w,
              height: 52.w,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // Resend Code Button
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
          // Confirm Code Button
          CustomButton(
            text: 'Confirm Code',
            onPressed: provider.isOtpComplete
                ? () {
                    provider.nextStep();
                  }
                : null,
            buttonColor: provider.isOtpComplete ? Colors.black : Colors.grey.shade300,
            textColor: provider.isOtpComplete ? Colors.white : Colors.grey.shade600,
            buttonBorderRadius: 16.r,
          ),
        ],
      ),
    );
  }
}
