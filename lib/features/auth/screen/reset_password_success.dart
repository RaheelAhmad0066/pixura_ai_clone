import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/utils/spacing.dart';
import 'package:pixura_ai/features/auth/screen/login_screen.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:svg_flutter/svg.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsConstants.heartstyle, width: 80.w),
                AppSizedBoxes.normalSizedBox,
                Text(
                  'Password Reset Successful',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                AppSizedBoxes.normalSizedBox,
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onTertiary.withValues(alpha: 0.6),
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Your password has been successfully reset. You can now ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: 'login',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const TextSpan(text: ' with your new password.'),
                    ],
                  ),
                ),
                AppSizedBoxes.largeSizedBox,
                CustomButton(
                  buttonColor: AppColors.purple,
                  text: 'Go to Login',
                  onPressed: () {
                    LoginScreen().launch(
                      context,
                      pageRouteAnimation: PageRouteAnimation.Fade,
                      isNewTask: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
