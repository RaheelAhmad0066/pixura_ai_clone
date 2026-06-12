import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/step_badge.dart';

class SetupWelcomeWidget extends StatelessWidget {
  const SetupWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccountSetupProvider>();
    final isPhone = provider.authMode == AuthMode.phone;
    final logoAsset = isPhone ? AssetsConstants.heartstyle : AssetsConstants.styleSvg;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Logo Shape (Heart or S)
            SvgPicture.asset(
              logoAsset,
              height: 100.h,
            ),
            SizedBox(height: 32.h),
            // Slanted Step Badge
            const StepBadge(text: 'hurray!'),
            SizedBox(height: 18.h),
            // Welcome text
            Text(
              'Welcome to Pixura.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 48.h),
            // Get Cracking button
            CustomButton(
              text: 'Get Cracking   >',
              onPressed: () => provider.completeSetup(context),
              buttonColor: Colors.black,
              textColor: Colors.white,
              buttonBorderRadius: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
