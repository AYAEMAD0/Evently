import 'package:evently/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.text,
    required this.styleText,
    this.iconName,
    this.isIcon = false,
    this.mainAxisAlignment,
    this.borderColor,
    this.paddingHeight,
  });
  final void Function() onPressed;
  final Color backgroundColor;
  final Color? borderColor;
  final bool isIcon;
  final MainAxisAlignment? mainAxisAlignment;
  final String text;
  final TextStyle styleText;
  final Widget? iconName;
  final double? paddingHeight;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical:paddingHeight?? height*0.015),
        side:BorderSide(color: borderColor??AppColor.transparentColor,width: 1.5) ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: isIcon
          ? Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.01),
                iconName ?? SizedBox(),
                SizedBox(width: width * 0.02),
                Text(text, style: styleText),
              ],
            )
          : Text(text, style: styleText),
    );
  }
}
