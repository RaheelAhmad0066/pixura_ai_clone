import 'package:flutter/material.dart';
import 'package:pixura_ai/core/utils/toast_utils.dart';

class ErrorDialog {
  static void show({required BuildContext context, required String message}) {
    ToastUtils.error(message);
  }
}
