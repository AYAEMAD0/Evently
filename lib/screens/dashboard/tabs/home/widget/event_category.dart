import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';

class EventCategory extends StatelessWidget {
  const EventCategory({
    super.key,
    required this.selected,
    required this.eventName,
    required this.icon,
    required this.colorBorderIsSelected,
    required this.styleTextSelected,
    required this.styleTextNotSelected,
    required this.colorIconSelected,
    required this.colorIconNotSelected,
    required this.colorBackgroundIsSelected,
  });
  final bool selected;
  final Color colorBorderIsSelected;
  final Color colorBackgroundIsSelected;
  final Color colorIconSelected;
  final Color colorIconNotSelected;
  final TextStyle styleTextSelected;
  final TextStyle styleTextNotSelected;
  final String eventName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.033,
      ),
      decoration: BoxDecoration(
        color: selected
            ? colorBackgroundIsSelected
            : AppColor.transparentColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorBorderIsSelected ,width: 1.5),
      ),
      child: Row(
        spacing: width * 0.03,
        children: [
          Icon(icon,color: selected
              ? colorIconSelected
              :colorIconNotSelected
          ),
          Text(
            eventName,
            style: selected
                ? styleTextSelected
                : styleTextNotSelected,
          ),
        ],
      ),
    );
  }
}
