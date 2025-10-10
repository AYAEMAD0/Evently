import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/app_style.dart';

class CustomSnackbar {
  static SnackBar show(String message) {
    return SnackBar(
      content: Text(
        message.tr(),
        textAlign: TextAlign.center,
        style: AppStyle.bold20PrimaryLight,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );
  }
}
