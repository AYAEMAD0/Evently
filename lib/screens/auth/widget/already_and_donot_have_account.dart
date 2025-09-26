import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_style.dart';

class AlreadyAndDonotHaveAccount extends StatelessWidget {
  const AlreadyAndDonotHaveAccount({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
  });
  final String text;
  final String textButton;
  final  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textButton,
            style: AppStyle.bold16Primary.copyWith(
              decorationColor: AppColor.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
