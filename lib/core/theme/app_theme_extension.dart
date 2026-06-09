import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color greySolid;
  final Color grey200;
  final Color grey100;
  final Color grey;
  final Color lightGrey;
  final Color backgroundColor;
  final Color componentBackgroundColor;
  final Color secondaryBlack;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color blue300;
  final Color blue400;

  // Switch colors
  final Color switchActiveTrack;
  final Color switchInactiveTrack;
  final Color switchThumb;

  // Selection/Highlight colors
  final Color selectionHighlight;
  final Color selectionHighlightText;

  // Status colors
  final Color successBackground;
  final Color successForeground;
  final Color successBorder;
  final Color warningBackground;
  final Color warningForeground;
  final Color infoBackground;
  final Color infoBorder;
  final Color infoColor;

  // Icon backgrounds
  final Color iconBackgroundYellow;

  // Status specific
  final Color statusScheduledColor;
  final Color statusScheduledBg;
  final Color statusInProgressColor;
  final Color statusInProgressBg;
  final Color statusCompletedColor;
  final Color statusCompletedBg;
  final Color statusDelayedColor;
  final Color statusDelayedBg;
  final Color statusCancelledColor;
  final Color statusCancelledBg;

  // Gradients
  final Color gradientOrangeStart;
  final Color gradientOrangeEnd;

  // Field log
  final Color fieldLogBrown;

  // Job status
  final Color jobStatusOrange;

  const AppColorsExtension({
    required this.greySolid,
    required this.grey200,
    required this.grey100,
    required this.grey,
    required this.lightGrey,
    required this.backgroundColor,
    required this.componentBackgroundColor,
    required this.secondaryBlack,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.blue300,
    required this.blue400,
    required this.switchActiveTrack,
    required this.switchInactiveTrack,
    required this.switchThumb,
    required this.selectionHighlight,
    required this.selectionHighlightText,
    required this.successBackground,
    required this.successForeground,
    required this.successBorder,
    required this.warningBackground,
    required this.warningForeground,
    required this.infoBackground,
    required this.infoBorder,
    required this.infoColor,
    required this.iconBackgroundYellow,
    required this.statusScheduledColor,
    required this.statusScheduledBg,
    required this.statusInProgressColor,
    required this.statusInProgressBg,
    required this.statusCompletedColor,
    required this.statusCompletedBg,
    required this.statusDelayedColor,
    required this.statusDelayedBg,
    required this.statusCancelledColor,
    required this.statusCancelledBg,
    required this.gradientOrangeStart,
    required this.gradientOrangeEnd,
    required this.fieldLogBrown,
    required this.jobStatusOrange,
  });

  @override
  AppColorsExtension copyWith({
    Color? greySolid,
    Color? grey200,
    Color? grey100,
    Color? grey,
    Color? lightGrey,
    Color? backgroundColor,
    Color? componentBackgroundColor,
    Color? secondaryBlack,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? blue300,
    Color? blue400,
    Color? switchActiveTrack,
    Color? switchInactiveTrack,
    Color? switchThumb,
    Color? selectionHighlight,
    Color? selectionHighlightText,
    Color? successBackground,
    Color? successForeground,
    Color? successBorder,
    Color? warningBackground,
    Color? warningForeground,
    Color? infoBackground,
    Color? infoBorder,
    Color? infoColor,
    Color? iconBackgroundYellow,
    Color? statusScheduledColor,
    Color? statusScheduledBg,
    Color? statusInProgressColor,
    Color? statusInProgressBg,
    Color? statusCompletedColor,
    Color? statusCompletedBg,
    Color? statusDelayedColor,
    Color? statusDelayedBg,
    Color? statusCancelledColor,
    Color? statusCancelledBg,
    Color? gradientOrangeStart,
    Color? gradientOrangeEnd,
    Color? fieldLogBrown,
    Color? jobStatusOrange,
  }) {
    return AppColorsExtension(
      greySolid: greySolid ?? this.greySolid,
      grey200: grey200 ?? this.grey200,
      grey100: grey100 ?? this.grey100,
      grey: grey ?? this.grey,
      lightGrey: lightGrey ?? this.lightGrey,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      componentBackgroundColor: componentBackgroundColor ?? this.componentBackgroundColor,
      secondaryBlack: secondaryBlack ?? this.secondaryBlack,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      blue300: blue300 ?? this.blue300,
      blue400: blue400 ?? this.blue400,
      switchActiveTrack: switchActiveTrack ?? this.switchActiveTrack,
      switchInactiveTrack: switchInactiveTrack ?? this.switchInactiveTrack,
      switchThumb: switchThumb ?? this.switchThumb,
      selectionHighlight: selectionHighlight ?? this.selectionHighlight,
      selectionHighlightText:
          selectionHighlightText ?? this.selectionHighlightText,
      successBackground: successBackground ?? this.successBackground,
      successForeground: successForeground ?? this.successForeground,
      successBorder: successBorder ?? this.successBorder,
      warningBackground: warningBackground ?? this.warningBackground,
      warningForeground: warningForeground ?? this.warningForeground,
      infoBackground: infoBackground ?? this.infoBackground,
      infoBorder: infoBorder ?? this.infoBorder,
      infoColor: infoColor ?? this.infoColor,
      iconBackgroundYellow: iconBackgroundYellow ?? this.iconBackgroundYellow,
      statusScheduledColor: statusScheduledColor ?? this.statusScheduledColor,
      statusScheduledBg: statusScheduledBg ?? this.statusScheduledBg,
      statusInProgressColor:
          statusInProgressColor ?? this.statusInProgressColor,
      statusInProgressBg: statusInProgressBg ?? this.statusInProgressBg,
      statusCompletedColor: statusCompletedColor ?? this.statusCompletedColor,
      statusCompletedBg: statusCompletedBg ?? this.statusCompletedBg,
      statusDelayedColor: statusDelayedColor ?? this.statusDelayedColor,
      statusDelayedBg: statusDelayedBg ?? this.statusDelayedBg,
      statusCancelledColor: statusCancelledColor ?? this.statusCancelledColor,
      statusCancelledBg: statusCancelledBg ?? this.statusCancelledBg,
      gradientOrangeStart: gradientOrangeStart ?? this.gradientOrangeStart,
      gradientOrangeEnd: gradientOrangeEnd ?? this.gradientOrangeEnd,
      fieldLogBrown: fieldLogBrown ?? this.fieldLogBrown,
      jobStatusOrange: jobStatusOrange ?? this.jobStatusOrange,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      greySolid: Color.lerp(greySolid, other.greySolid, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      componentBackgroundColor: Color.lerp(componentBackgroundColor, other.componentBackgroundColor, t)!,
      secondaryBlack: Color.lerp(secondaryBlack, other.secondaryBlack, t)!,
      primaryTextColor:
          Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
      secondaryTextColor:
          Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      blue300: Color.lerp(blue300, other.blue300, t)!,
      blue400: Color.lerp(blue400, other.blue400, t)!,
      switchActiveTrack:
          Color.lerp(switchActiveTrack, other.switchActiveTrack, t)!,
      switchInactiveTrack:
          Color.lerp(switchInactiveTrack, other.switchInactiveTrack, t)!,
      switchThumb: Color.lerp(switchThumb, other.switchThumb, t)!,
      selectionHighlight:
          Color.lerp(selectionHighlight, other.selectionHighlight, t)!,
      selectionHighlightText:
          Color.lerp(selectionHighlightText, other.selectionHighlightText, t)!,
      successBackground:
          Color.lerp(successBackground, other.successBackground, t)!,
      successForeground:
          Color.lerp(successForeground, other.successForeground, t)!,
      successBorder: Color.lerp(successBorder, other.successBorder, t)!,
      warningBackground:
          Color.lerp(warningBackground, other.warningBackground, t)!,
      warningForeground:
          Color.lerp(warningForeground, other.warningForeground, t)!,
      infoBackground: Color.lerp(infoBackground, other.infoBackground, t)!,
      infoBorder: Color.lerp(infoBorder, other.infoBorder, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      iconBackgroundYellow:
          Color.lerp(iconBackgroundYellow, other.iconBackgroundYellow, t)!,
      statusScheduledColor:
          Color.lerp(statusScheduledColor, other.statusScheduledColor, t)!,
      statusScheduledBg:
          Color.lerp(statusScheduledBg, other.statusScheduledBg, t)!,
      statusInProgressColor:
          Color.lerp(statusInProgressColor, other.statusInProgressColor, t)!,
      statusInProgressBg:
          Color.lerp(statusInProgressBg, other.statusInProgressBg, t)!,
      statusCompletedColor:
          Color.lerp(statusCompletedColor, other.statusCompletedColor, t)!,
      statusCompletedBg:
          Color.lerp(statusCompletedBg, other.statusCompletedBg, t)!,
      statusDelayedColor:
          Color.lerp(statusDelayedColor, other.statusDelayedColor, t)!,
      statusDelayedBg: Color.lerp(statusDelayedBg, other.statusDelayedBg, t)!,
      statusCancelledColor:
          Color.lerp(statusCancelledColor, other.statusCancelledColor, t)!,
      statusCancelledBg:
          Color.lerp(statusCancelledBg, other.statusCancelledBg, t)!,
      gradientOrangeStart:
          Color.lerp(gradientOrangeStart, other.gradientOrangeStart, t)!,
      gradientOrangeEnd:
          Color.lerp(gradientOrangeEnd, other.gradientOrangeEnd, t)!,
      fieldLogBrown: Color.lerp(fieldLogBrown, other.fieldLogBrown, t)!,
      jobStatusOrange: Color.lerp(jobStatusOrange, other.jobStatusOrange, t)!,
    );
  }
}

extension AppThemeExtension on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>() ??
      const AppColorsExtension(
        greySolid: Color(0XFF4A5565),
        grey200: Color(0xFF18181F),
        grey100: Color(0xFFF6F8FA),
        grey: Color(0xFF4B5563),
        lightGrey: Color(0xFFF3F4F6),
        backgroundColor: Color(0xFFf6f8fa),
        componentBackgroundColor: Colors.white,
        secondaryBlack: Color(0XFF121212),
        primaryTextColor: Color(0XFF484F69),
        secondaryTextColor: Color(0XFF808080),
        blue300: Color(0XFF314158),
        blue400: Color(0XFF45556C),
        switchActiveTrack: Color(0xFFFFC107),
        switchInactiveTrack: Color(0xFFE5E5EA),
        switchThumb: Colors.white,
        selectionHighlight: Color(0xFFF9A825),
        selectionHighlightText: Colors.white,
        successBackground: Color(0xFFF0FDF4),
        successForeground: Color(0xFF00C950),
        successBorder: Color(0xFFB9F8CF),
        warningBackground: Color(0xFFFFFBED),
        warningForeground: Color(0xFFFEF3C7),
        infoBackground: Color(0xFFEFF6FF),
        infoBorder: Color(0xFFBEDBFF),
        infoColor: Color(0xFF1565C0),
        iconBackgroundYellow: Color(0xFFFFF9E6),
        statusScheduledColor: Color(0xFFF9A825),
        statusScheduledBg: Color(0xFFFFF8E1),
        statusInProgressColor: Color(0xFF1565C0),
        statusInProgressBg: Color(0xFFE3F2FD),
        statusCompletedColor: Color(0xFF00C950),
        statusCompletedBg: Color(0xFFF0FDF4),
        statusDelayedColor: Color(0xFFD32F2F),
        statusDelayedBg: Color(0xFFFFEBEE),
        statusCancelledColor: Color(0xFF757575),
        statusCancelledBg: Color(0xFFF5F5F5),
        gradientOrangeStart: Color(0xFFFE9A00),
        gradientOrangeEnd: Color(0xFFFF6900),
        fieldLogBrown: Color(0xFF5D4037),
        jobStatusOrange: Color(0xFFE65100),
      );
}
