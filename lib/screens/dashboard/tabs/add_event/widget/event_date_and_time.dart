import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';

class EventDateAndTime extends StatelessWidget {
  const EventDateAndTime({
    super.key,
    required this.icon,
    required this.text,
    required this.textButton,
    required this.onPressed,
    required this.colorIcon,
    this.textCheckValue,
  });
  final IconData icon;
  final Color colorIcon;
  final String text;
  final String? textCheckValue;
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(icon,color: colorIcon,),
        SizedBox(width: width * 0.03),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textButton, style: AppStyle.bold16Primary),
              textCheckValue==null?SizedBox():
              Text(textCheckValue!,style: AppStyle.regular16Red,)
            ],
          ),
        ),
      ],
    );
  }
}
