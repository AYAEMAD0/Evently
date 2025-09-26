import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_style.dart';

class BuiltOrWayLogin extends StatelessWidget {
  const BuiltOrWayLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColor.primaryColor,
            endIndent: width * 0.03,
            indent: width * 0.05,
          ),
        ),
        Text("or".tr(), style: AppStyle.medium16Primary),
        Expanded(
          child: Divider(
            color: AppColor.primaryColor,
            endIndent: width * 0.02,
            indent: width * 0.05,
          ),
        ),
      ],
    );
  }
}
