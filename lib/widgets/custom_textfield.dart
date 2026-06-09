import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final bool isRequired;
  final String? errorText;
  final String? initialValue;
  final bool isReadOnly;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final double? textfieldBorderRadius;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? isFilled;
  final bool isEditProfile;
  final Color? fillColor;
  final AutovalidateMode? autoValidateMode;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final String? counterText;

  const CustomTextField({
    super.key,
    this.title,
    this.isRequired = false,
    this.isEditProfile = false,
    this.hintText,
    this.borderColor,
    this.isEnabled,
    this.errorText,
    this.onTap,
    this.autoValidateMode,
    this.onChanged,
    this.textfieldBorderRadius,
    this.isReadOnly = false,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.obscureText,
    this.initialValue,
    this.textInputType,
    this.prefixIcon,
    this.validator,
    this.maxLength,
    this.isFilled,
    this.fillColor,
    this.inputFormatters,
    this.controller,
    this.suffixIcon,
    this.textInputAction,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    /// Determine fill colors based on theme
    final Color defaultFillColor = isDark
        ? const Color(0xFF1E1E1E) // Dark grey fill for dark mode
        : const Color(0xFFF3F4F6); // Light grey fill for light mode

    /// Border radius - pill shaped
    final double radius = textfieldBorderRadius ?? 30.r;

    /// Border definition
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.transparent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(radius),
    );

    final OutlineInputBorder activeBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.appColors.selectionHighlight, // Amber/yellow focus color
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(radius),
    );

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.appColors.statusDelayedColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(radius),
    );

    final TextStyle errorStyle = Theme.of(context).textTheme.titleSmall!
        .copyWith(color: context.appColors.statusDelayedColor, height: 1.35);

    final TextStyle style = Theme.of(context).textTheme.titleMedium!.copyWith(
      color: isEnabled ?? true
          ? Theme.of(context).textTheme.titleMedium?.color
          : context.appColors.grey,
    );

    final TextStyle hintStyle = Theme.of(
      context,
    ).textTheme.titleMedium!.copyWith(color: context.appColors.grey);

    final EdgeInsets contentPadding = EdgeInsets.symmetric(
      horizontal: 20.w,
      vertical: 14.h,
    );

    /// Determine if filled mode is active
    final bool filled = isFilled ?? true;

    /// Responsive fill color - defaults to grey when not focused
    final Color resolvedFillColor =
        fillColor ?? (filled ? defaultFillColor : Colors.transparent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          RichText(
            text: TextSpan(
              text: title,
              style: !isEditProfile
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 13.sp),
              children: isRequired
                  ? [
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: context.appColors.statusDelayedColor,
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        TextFormField(
          initialValue: initialValue,
          onTap: onTap,
          onChanged: onChanged,
          keyboardType: textInputType,
          controller: controller,
          enabled: isEnabled,
          maxLines: maxLines,
          focusNode: focusNode,
          readOnly: isReadOnly,
          validator: validator,
          maxLength: maxLength,
          minLines: minLines,
          textInputAction: textInputAction,
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          obscureText: obscureText ?? false,
          style: style,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            counterText: counterText,
            errorMaxLines: 2,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: resolvedFillColor,
            filled: filled,
            hintText: hintText ?? '',
            errorStyle: errorStyle,
            hintStyle: hintStyle,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            disabledBorder: border,
            border: border,
            focusedBorder: activeBorder,
            enabledBorder: border,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
          ),
        ),
      ],
    );
  }
}
