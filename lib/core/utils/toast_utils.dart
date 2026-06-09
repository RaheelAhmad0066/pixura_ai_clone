import 'package:nb_utils/nb_utils.dart';
import 'package:pixura_ai/core/theme/app_colors.dart';

class ToastUtils {
  static void success(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    toast(
      message,
      bgColor: AppColors.shade800,
      textColor: AppColors.shade100,
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
      bgColor: AppColors.rose,
      textColor: AppColors.shade100,
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
      bgColor: AppColors.mustard,
      textColor: AppColors.shade100,
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
