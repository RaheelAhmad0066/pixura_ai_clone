import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? loaderColor;
  final Color? buttonColor;
  final double? buttonBorderRadius;
  final bool isDisabled;
  final bool isOutlineButton;
  final double height;
  final double? width;
  final double? textFontSize;
  final String? prefixIcon;
  final IconData? prefixIconData;
  final bool isLoading;
  final Color? preffixIconColor;
  final Widget? child;
  final Color? borderColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 52,
    this.textColor,
    this.loaderColor,
    this.buttonColor,
    this.buttonBorderRadius,
    this.isDisabled = false,
    this.isOutlineButton = false,
    this.prefixIcon,
    this.prefixIconData,
    this.child,
    this.width,
    this.borderColor,
    this.textFontSize,
    this.isLoading = false,
    this.preffixIconColor,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 45,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              borderColor ??
              (isOutlineButton
                  ? buttonColor ?? Theme.of(context).textTheme.bodyLarge!.color!
                  : Colors.transparent),
        ),
        borderRadius: BorderRadius.circular(buttonBorderRadius ?? 14.r),
      ),
      height: height,

      color: isOutlineButton
          ? null
          : (isDisabled)
          ? (buttonColor ?? AppColors.buttonDisabledBg)
          : buttonColor ?? AppColors.shade900,
      elevation: 0.0,
      onPressed: (isDisabled)
          // (isDisabled || isLoading)
          ? () {}
          : onPressed, // Disable when loading or disabled
      child: Center(
        child:
            child ??
            (isLoading
                ? SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        loaderColor ?? AppColors.shade100,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null) ...[
                        SvgPicture.asset(
                          prefixIcon!,
                          colorFilter: ColorFilter.mode(
                            preffixIconColor ??
                                textColor ??
                                Theme.of(context).textTheme.bodyLarge!.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ] else if (prefixIconData != null) ...[
                        Icon(
                          prefixIconData,
                          color:
                              preffixIconColor ??
                              textColor ??
                              Theme.of(context).textTheme.bodyLarge!.color!,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              color: isDisabled && !isOutlineButton
                                  ? (textColor ?? AppColors.buttonDisabledText)
                                  : textColor ?? AppColors.shade100,
                              fontSize: textFontSize ?? 14.sp,
                            ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
