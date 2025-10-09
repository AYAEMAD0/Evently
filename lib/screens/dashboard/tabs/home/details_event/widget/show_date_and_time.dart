import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_style.dart';
import '../../../../../../provider/language_provider/language_provider.dart';

class ShowDateAndTime extends StatelessWidget {
  const ShowDateAndTime({
    super.key,
    this.isIconEnd = true,
    required this.event,
  });
  final bool isIconEnd;
  final EventModelFire event;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var language = Provider.of<LanguageProvider>(context);


    DateTime parsedTime;
    try {
      parsedTime = DateFormat.jm('en').parse(event.timeEvent);

    } catch (e) {
      try {
        parsedTime = DateFormat.jm('ar').parse(event.timeEvent);
      } catch (e2) {
        parsedTime = DateTime.now();
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: height * 0.016,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
              vertical: height * 0.016,
            ),
            margin: EdgeInsetsDirectional.only(end: width * 0.035),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.primaryColor,
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              language.isEnglishLanguage()
                  ? Text(
                      DateFormat('d MMM yyyy', 'en').format(event.dateEvent),
                      style: AppStyle.bold16Primary,
                    )
                  : Text(
                      DateFormat('d MMM yyyy', 'ar').format(event.dateEvent),
                      style: AppStyle.bold16Primary,
                    ),

              language.isEnglishLanguage()
                  ? Text(
                DateFormat.jm('en').format(parsedTime),
                style: AppStyle.bold16Primary,
              )
                  : Text(
                DateFormat.jm('ar').format(parsedTime),
                style: AppStyle.bold16Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
