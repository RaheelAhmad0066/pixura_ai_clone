import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:pixura_ai/features/auth/screen/verify_otp_screen.dart';
import 'package:pixura_ai/widgets/back_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/utils/spacing.dart';
import 'package:pixura_ai/core/utils/validator.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/custom_textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin, Validators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3), // slide from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleForgotPassword() async {
    // if (_formKey.currentState?.validate() ?? false) {
    final success = await context.read<AuthProvider>().clerkForgotPassword(
      _emailController.text.trim(),
    );
    if (success && mounted) {
      toast('Code sent to your email!');
      VerifyOtpScreen(
        isReset: true,
        email: _emailController.text.trim(),
      ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1.sh,
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BackButtonCustom(),
                          Text(
                            'Reset Password',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.124.sh),
                      // Logo stays fixed (Hero animation)
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          AssetsConstants.heartstyle,
                          width: 80.w,
                        ),
                      ),

                      AppSizedBoxes.normalSizedBox,

                      // Everything below will fade + slide from bottom
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Forgot Password',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,

                              Text(
                                'Enter your email account to reset password.',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary
                                          .withValues(alpha: 0.6),
                                    ),
                              ),
                              AppSizedBoxes.largeSizedBox,

                              Text(
                                'Email',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,

                              CustomTextField(
                                isFilled: true,
                                controller: _emailController,
                                hintText: 'Enter Email Address',
                                validator: validateEmail,
                                textInputType: TextInputType.emailAddress,
                                borderColor: Colors.transparent,
                                textInputAction: TextInputAction.next,
                              ),

                              AppSizedBoxes.normalSizedBox,

                              CustomButton(
                                text: 'Reset Password',
                                onPressed: _handleForgotPassword,
                                isLoading: context
                                    .watch<AuthProvider>()
                                    .isLoading,
                                buttonColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),

                              SizedBox(height: 24.h),

                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: context.appColors.grey,
                                        ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'By Continuing, you are agreeing to our ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary
                                                  .withValues(alpha: 0.6),
                                            ),
                                      ),
                                      TextSpan(
                                        text: '\nTerms of Service',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                      TextSpan(
                                        text: ' & ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary
                                                  .withValues(alpha: 0.6),
                                            ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
