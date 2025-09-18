import 'dart:core';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_style.dart';

class CustomToggleSwitch extends StatelessWidget {
  const CustomToggleSwitch({
    super.key,
    required this.current,
    required this.text,
    required this.onChanged,
    required this.customIconBuilder,
  });
  final int current;
  final String text;
  final Future<void> Function(int) onChanged;
  final Widget Function(BuildContext,AnimatedToggleProperties<int>,DetailedGlobalToggleProperties<int>) customIconBuilder;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyle.bold20Primary),
        AnimatedToggleSwitch<int>.size(
          current: current,
          values: const [0, 1],
          iconOpacity: 1,
          height: 40,
          indicatorSize: Size(width * 0.102, height * 0.050),
          customIconBuilder: customIconBuilder,
          onChanged: onChanged,
          borderWidth: 1,
          style: ToggleStyle(
            borderColor: AppColor.primaryColor,
            indicatorColor: AppColor.primaryColor,
            backgroundColor: AppColor.transparentColor,
          ),
        ),
      ],
    );
  }
}
