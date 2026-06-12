import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/widgets/custom_button.dart';
import 'package:pixura_ai/widgets/custom_textfield.dart';
import 'package:pixura_ai/widgets/step_badge.dart';

class SetupInputWidget extends StatefulWidget {
  const SetupInputWidget({super.key});

  @override
  State<SetupInputWidget> createState() => _SetupInputWidgetState();
}

class _SetupInputWidgetState extends State<SetupInputWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  // Country picker state
  Country _selectedCountry = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'United States',
    example: '2015550123',
    displayName: 'United States (US) [+1]',
    displayNameNoCountryCode: 'United States (US)',
    e164Key: '1-US-0',
  );

  @override
  void initState() {
    super.initState();
    final provider = context.read<AccountSetupProvider>();
    _controller = TextEditingController(
      text: provider.authMode == AuthMode.phone
          ? provider.phone
          : provider.email,
    );

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        inputDecoration: InputDecoration(
          hintText: 'Search country...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        ),
        searchTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
        textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
        flagSize: 22,
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccountSetupProvider>();
    final isPhone = provider.authMode == AuthMode.phone;
    final bool isValid = provider.isInputValid;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          // Reusable Slanted Step Badge
          const StepBadge(text: 'step 01'),
          SizedBox(height: 18.h),
          // Centered Title
          Text(
            isPhone ? "What's your number?" : "What's your email?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 24.h),
          // CustomTextField with focus logic
          if (isPhone)
            CustomTextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputType: TextInputType.phone,
              hintText: '201-555-0123',
              fillColor: const Color(0xFFF2F2F2),
              textfieldBorderRadius: 16.r,
              prefixIcon: GestureDetector(
                onTap: _openCountryPicker,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 8.w,
                        right: 12.w,
                        top: 6.h,
                        bottom: 6.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedCountry.flagEmoji,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '+${_selectedCountry.phoneCode}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16.sp,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20.h,
                      width: 1.w,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(width: 12.w),
                  ],
                ),
              ),
              onChanged: (val) {
                provider.updatePhone(val ?? '');
                return null;
              },
            )
          else
            CustomTextField(
              title: 'Email',
              controller: _controller,
              focusNode: _focusNode,
              textInputType: TextInputType.emailAddress,
              hintText: 'hello@example.gmail.com',
              textfieldBorderRadius: 16.r,
              fillColor: const Color(0xFFF2F2F2),
              prefixIcon: Container(
                margin: EdgeInsets.only(
                  left: 8.w,
                  right: 12.w,
                  top: 6.h,
                  bottom: 6.h,
                ),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.mail_outline,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.only(
                  right: 8.w,
                  top: 6.h,
                  bottom: 6.h,
                ),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.transparent,
                  size: 20.sp,
                ),
              ),
              onChanged: (val) {
                provider.updateEmail(val ?? '');
                return null;
              },
            ),
          SizedBox(height: 12.h),
          // Centered Sub-description matching design wording
          Text(
            'No spam. Just a quick verification',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 180.h),
          // Centered Action Button
          CustomButton(
            text: 'Continue',
            onPressed: isValid
                ? () {
                    provider.updateOtp('');
                    provider.nextStep();
                  }
                : () {}, // keep empty to use isDisabled styling
            isDisabled: !isValid,
            buttonColor: isValid
                ? Colors.black
                : const Color(0xFFD1D5DB), // Light grey disabled
            textColor: isValid
                ? Colors.white
                : const Color(0xFF9CA3AF),
            buttonBorderRadius: 16.r,
          ),
          SizedBox(height: 24.h),
          // Centered Disclaimer text
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 11.sp,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(
                        text: 'By tapping Continue, you are agreeing to\nour '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
