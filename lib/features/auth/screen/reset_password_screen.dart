import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:pixura_ai/features/auth/screen/reset_password_success.dart';
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
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.isChangePassword,
    this.otp,
  });
  final bool isChangePassword;
  final String? otp;

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin, Validators {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() async {
    // if (_formKey.currentState?.validate() ?? false) {
    if (widget.isChangePassword) {
      finish(context);
    } else {
      final success = await context.read<AuthProvider>().clerkResetPassword(
        widget.otp!,
        _passwordController.text,
      );
      if (success && mounted) {
        ResetPasswordSuccess().launch(
          context,
          pageRouteAnimation: PageRouteAnimation.Fade,
          isNewTask: true,
        );
      }
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
                            widget.isChangePassword
                                ? 'Change Password'
                                : 'Reset Password',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.124.sh),
                      // Logo stays fixed (Hero animation)
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          AssetsConstants.appLogo,
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
                                widget.isChangePassword
                                    ? 'Change Password'
                                    : 'Reset Your Password',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,

                              Text(
                                'The password must be different than before.',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary
                                          .withValues(alpha: 0.6),
                                    ),
                              ),
                              AppSizedBoxes.largeSizedBox,

                              CustomTextField(
                                isFilled: true,
                                controller: _passwordController,
                                hintText: 'New Password',
                                obscureText: _obscurePassword,
                                validator: validatePassword,
                                maxLines: 1,
                                borderColor: Colors.transparent,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye,
                                    color: context.appColors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),

                              AppSizedBoxes.normalSizedBox,

                              CustomTextField(
                                isFilled: true,
                                controller: _confirmPasswordController,
                                hintText: 'Confirm Password',
                                obscureText: _obscureConfirmPassword,
                                validator: (value) => validateConfirmPassword(
                                  value,
                                  _passwordController.text,
                                ),
                                maxLines: 1,
                                borderColor: Colors.transparent,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye,
                                    color: context.appColors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),

                              AppSizedBoxes.normalSizedBox,

                              CustomButton(
                                text: 'Change Password',
                                onPressed: _handleChangePassword,
                                isLoading: context
                                    .watch<AuthProvider>()
                                    .isLoading,
                                buttonColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
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
