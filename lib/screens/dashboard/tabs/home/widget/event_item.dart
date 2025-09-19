import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.selected,
    required this.eventName,
    required this.icon,
  });
  final bool selected;
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
            ? Theme.of(context).colorScheme.secondary
            : AppColor.transparentColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 1.5),
      ),
      child: Row(
        spacing: width * 0.03,
        children: [
          Icon(icon,color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).cardColor,),
          Text(
            eventName,
            style: selected
                ? Theme.of(context).textTheme.labelSmall
                : Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
