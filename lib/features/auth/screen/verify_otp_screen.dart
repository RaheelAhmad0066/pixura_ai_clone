import 'dart:async';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/features/auth/screen/reset_password_screen.dart';
import 'package:pixura_ai/features/tab/screen/tab_screen.dart';
import 'package:pixura_ai/widgets/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/utils/spacing.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:clerk_auth/clerk_auth.dart';
import 'package:svg_flutter/svg.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  final bool isReset;

  const VerifyOtpScreen({
    super.key,
    required this.email,
    required this.isReset,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          focusNode.requestFocus();
        }
      });
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() async {
    final otp = pinController.text.trim();
    if (otp.length < 6) {
      toast('Please enter the full code');
      return;
    }

    try {
      if (widget.isReset) {
        // Handle reset password verification if needed
        ResetPasswordScreen(
          isChangePassword: false,
          otp: otp,
        ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
      } else {
        final client = await context.read<AuthProvider>().clerkVerifySignUpOtp(
          otp,
        );

        if (client != null && mounted) {
          if (client.user != null) {
            toast('Signup successful!');
            const TabScreen(initialIndex: 0).launch(
              context,
              pageRouteAnimation: PageRouteAnimation.Fade,
              isNewTask: true,
            );
          } else {
            toast('Signup incomplete. Please try again.');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        toast('Verification failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: context.watch<AuthProvider>().isLoading
              ? Center(child: CupertinoActivityIndicator(radius: 20.r))
              : Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom -
                            32.h, // Subtract vertical padding
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              BackButtonCustom(),
                              Text(
                                'Verify OTP',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: 0.124.sh),

                          SvgPicture.asset(
                            AssetsConstants.heartstyle,
                            width: 80.w,
                          ),
                          AppSizedBoxes.normalSizedBox,

                          // Title
                          Text(
                            'OTP Verification',
                            style: Theme.of(context).textTheme.displaySmall,
                            textAlign: TextAlign.center,
                          ),
                          AppSizedBoxes.normalSizedBox,

                          // Description
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary
                                        .withValues(alpha: 0.6),
                                  ),
                              children: [
                                TextSpan(
                                  text: 'Enter the OTP sent to ',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text: widget.email,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                const TextSpan(
                                  text: ' to complete verification.',
                                ),
                              ],
                            ),
                          ),

                          AppSizedBoxes.largeSizedBox,

                          // OTP Input Fields
                          Pinput(
                            controller: pinController,
                            focusNode: focusNode,
                            length: 6,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            defaultPinTheme: PinTheme(
                              width: 70.w,
                              height: 56.h,
                              textStyle: Theme.of(
                                context,
                              ).textTheme.displaySmall,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 70.w,
                              height: 56.h,
                              textStyle: Theme.of(
                                context,
                              ).textTheme.displaySmall,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onCompleted: (pin) {
                              // Auto-verify when all digits are entered
                              _verifyOtp();
                            },
                          ),
                          AppSizedBoxes.largeSizedBox,

                          // Verify OTP Button
                          CustomButton(
                            buttonColor: Theme.of(context).colorScheme.primary,
                            text: 'Verify OTP',
                            onPressed: _verifyOtp,
                            isLoading: context.watch<AuthProvider>().isLoading,
                          ),
                          AppSizedBoxes.normalSizedBox,

                          // Resend OTP Button
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return Column(
                                children: [
                                  CustomButton(
                                    text: 'Resend OTP',
                                    onPressed: authProvider.canResend
                                        ? () => authProvider.clerkResendCode(
                                            Strategy.emailCode,
                                          )
                                        : () {},
                                    isOutlineButton: true,
                                  ),
                                  if (!authProvider.canResend) ...[
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Retry again in ${authProvider.resendCountdown}s',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: context
                                                .appColors
                                                .secondaryTextColor,
                                          ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
