import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.model});
  final EventModelFire model;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isDark = Provider.of<ThemeProvider>(context).isDark();
    return Container(
      height: height * 0.34,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(
            isDark ? model.imageDarkEvent : model.imageDarkEvent,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.016,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //date
            Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.0013,
                horizontal: width * 0.016,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                children: [
                  Text(
                    "${model.dateEvent.day}",
                    textAlign: TextAlign.center,
                    style: AppStyle.bold20PrimaryLight,
                  ),
                  Text(
                    DateFormat('MMM').format(model.dateEvent),
                    textAlign: TextAlign.center,
                    style: AppStyle.bold20PrimaryLight,
                  ),
                ],
              ),
            ),
            //desc
            Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.016,
                horizontal: width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.primaryColor, width: 1.3),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      model.descEvent,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Icon(Icons.favorite_outlined, color: AppColor.primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
