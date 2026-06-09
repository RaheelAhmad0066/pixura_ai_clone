import 'package:pixura_ai/core/constants/assets_constants.dart';
import 'package:pixura_ai/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key, this.onTap, this.leftPadding});

  final VoidCallback? onTap;

  /// Left padding from the screen edge.
  /// Defaults to 16.w on all screens.
  /// Pass 0 to suppress the padding (e.g. image preview screen).
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 12.w),
      child: GestureDetector(
        onTap:
            onTap ??
            () {
              Navigator.pop(context);
            },
        child: Container(
          width: 35.sp,
          height: 35.sp,
          padding: EdgeInsets.all(6.sp),
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            border: Border.all(color: context.appColors.secondaryBlack),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset(
            AssetsConstants.arrowBack,
            colorFilter: ColorFilter.mode(
              context.appColors.secondaryBlack,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
