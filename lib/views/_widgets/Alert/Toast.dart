import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Toast {
  static void showToast({
    required BuildContext context,
    String? title,
    String? msg,
    String? pos = "bottom",
  }) {
    Flushbar(
      isDismissible: false,
      flushbarPosition: pos == "bottom"
          ? FlushbarPosition.BOTTOM
          : FlushbarPosition.TOP,
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.blue[300]),
      title: title,
      message: msg,
      duration: Duration(seconds: 2),
    ).show(context);
  }
}
