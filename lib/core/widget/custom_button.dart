import 'package:evently/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
     this.text,
     this.styleText,
    this.isIcon = false,
    this.borderColor,
    this.paddingHeight,
    this.foregroundColor,
    this.iconWidget,
  });
  final void Function() onPressed;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isIcon;
  final String? text;
  final TextStyle? styleText;
  final double? paddingHeight;
  final Widget? iconWidget;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor:foregroundColor ,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical:paddingHeight?? height*0.015,horizontal: width * 0.03 ),
        side:BorderSide(color: borderColor??AppColor.transparentColor,width: 1.5) ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: isIcon
          ? iconWidget
          : Text(text!, style: styleText),
    );
  }
}
