import 'package:evently/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void showLoading({
    required BuildContext context,
    required Color background,
    required String text,
    required TextStyle? style,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: background,
          title: Row(
            spacing: 15,
            children: [
              CircularProgressIndicator(color: AppColor.primaryColor),
              Text(text, style: style),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required Color background,
    required TextStyle? styleMessage,
    required String message,
    String? title,
    TextStyle? styleTitle,
    String? posActionName,
    TextStyle? stylePosActionName,
    Function? posActionClick,
    String? nagActionName,
    TextStyle? styleNagActionName,
    Function? nagActionClick,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posActionClick?.call();
          },
          child: Text(posActionName, style: stylePosActionName),
        ),
      );
    }
    if (nagActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            nagActionClick?.call();
          },
          child: Text(nagActionName, style: styleNagActionName),
        ),
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: background,
          title: Text(title ?? "", style: styleTitle),
          content: Text(message, style: styleMessage),
          actions: actions,
        );
      },
    );
  }
}
