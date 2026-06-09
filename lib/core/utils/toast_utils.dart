import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';

class ToastUtils {
  static void success(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    toast(
      message,
      bgColor: AppColors.success,
      textColor: Colors.white,
      length: Toast.LENGTH_LONG,
      gravity: gravity,
    );
  }

  static void error(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    toast(
      message,
      bgColor: AppColors.requiredRedColor,
      textColor: Colors.white,
      length: Toast.LENGTH_LONG,
      gravity: gravity,
    );
  }

  static void warning(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    toast(
      message,
      bgColor: AppColors.orangeAccent,
      textColor: Colors.white,
      length: Toast.LENGTH_LONG,
      gravity: gravity,
    );
  }

  static void show(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    toast(message, length: Toast.LENGTH_LONG, gravity: gravity);
  }
}
