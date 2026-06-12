import 'package:pixura_ai/core/constants/app_constants.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';
import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Use provided focusNode or create an internal one
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_onFocusChange);
    // Only dispose if internally created
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    /// Fill color: white when focused, default when idle
    final Color defaultFillColor = isDark
        ? AppColors.textFieldFillDark
        : AppColors.textFieldFillLight;

    final bool filled = widget.isFilled ?? true;

    final Color resolvedFillColor = _isFocused
        ? Colors.white // active → white background
        : (widget.fillColor ?? (filled ? defaultFillColor : Colors.transparent));

    /// Text color: always black when focused so typing is visible
    final Color textColor = _isFocused
        ? Colors.black
        : (widget.isEnabled ?? true
            ? Theme.of(context).textTheme.titleMedium?.color ?? Colors.black
            : context.appColors.grey);

    /// Border radius - rounded rectangle
    final double radius =
        widget.textfieldBorderRadius ?? AppConstants.mediumRadius;

    /// Border definition
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.borderColor ?? Colors.transparent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(radius),
    );

    final OutlineInputBorder activeBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.appColors.selectionHighlight, // Lemon focus border
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(radius),
    );

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
      borderRadius: BorderRadius.circular(radius),
    );

    final TextStyle errorStyle = Theme.of(context).textTheme.titleSmall!
        .copyWith(color: context.appColors.statusDelayedColor, height: 1.35);

    final TextStyle style = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: textColor,
        );

    final TextStyle hintStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: context.appColors.grey);

    final EdgeInsets contentPadding = EdgeInsets.symmetric(
      horizontal: 20.w,
      vertical: 14.h,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              text: widget.title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
              children: widget.isRequired
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
          initialValue: widget.initialValue,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          enabled: widget.isEnabled,
          maxLines: widget.maxLines,
          focusNode: _internalFocusNode,
          readOnly: widget.isReadOnly,
          validator: widget.validator,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          textInputAction: widget.textInputAction,
          autovalidateMode:
              widget.autoValidateMode ?? AutovalidateMode.disabled,
          obscureText: widget.obscureText ?? false,
          style: style,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            counterText: widget.counterText,
            errorMaxLines: 2,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            fillColor: resolvedFillColor,
            filled: filled,
            hintText: widget.hintText ?? '',
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
