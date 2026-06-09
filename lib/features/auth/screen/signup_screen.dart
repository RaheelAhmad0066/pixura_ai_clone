import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:pixura_ai/features/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/utils/spacing.dart';
import 'package:pixura_ai/core/utils/validator.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/custom_textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:clerk_auth/clerk_auth.dart';
import 'package:pixura_ai/features/auth/screen/verify_otp_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin, Validators {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    if (_formKey.currentState?.validate() ?? false) {
      final client = await context.read<AuthProvider>().clerkSignUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (client != null && mounted) {
        if (client.signUp?.status == Status.missingRequirements &&
            client.signUp?.unverified(Field.emailAddress) == true) {
          toast('Code sent to your email!');
          VerifyOtpScreen(
            email: _emailController.text.trim(),
            isReset: false,
          ).launch(context);
        } else {
          toast('Signup successful! Please login.');
          const LoginScreen().launch(context, isNewTask: true);
        }
      }
    }
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          AssetsConstants.appLogo,
                          width: 80.w,
                        ),
                      ),
                      AppSizedBoxes.normalSizedBox,
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Account',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,
                              Text(
                                'Sign up to get started.',
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
                                'Full Name',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,
                              CustomTextField(
                                isFilled: true,
                                controller: _nameController,
                                hintText: 'Enter Full Name',
                                borderColor: Colors.transparent,
                                textInputAction: TextInputAction.next,
                              ),
                              AppSizedBoxes.normalSizedBox,
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
                              Text(
                                'Password',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              AppSizedBoxes.smallSizedBox,
                              CustomTextField(
                                isFilled: true,
                                controller: _passwordController,
                                hintText: 'Enter Password',
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
                              AppSizedBoxes.largeSizedBox,
                              CustomButton(
                                text: 'Sign Up',
                                onPressed: _handleSignup,
                                isLoading: context
                                    .watch<AuthProvider>()
                                    .isLoading,
                                buttonColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: context.appColors.grey.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: Text(
                                      'OR',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: context
                                                .appColors
                                                .primaryTextColor
                                                .withValues(alpha: 0.6),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: context.appColors.grey.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              CustomButton(
                                text: '',
                                onPressed: () {
                                  // TODO: Implement Google Sign In
                                },
                                buttonColor: Colors.white,
                                borderColor: context.appColors.grey.withValues(
                                  alpha: 0.3,
                                ),
                                isOutlineButton: true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/google_icon.svg',
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Continue with Google',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
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
                                  TextButton(
                                    onPressed: () {
                                      const LoginScreen().launch(
                                        context,
                                        isNewTask: true,
                                      );
                                    },
                                    child: Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
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
