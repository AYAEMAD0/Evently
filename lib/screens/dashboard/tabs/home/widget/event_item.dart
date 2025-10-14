import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:evently/provider/event_provider/event_provider.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  const EventItem({super.key, required this.model});
  final EventModelFire model;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isDark = Provider.of<ThemeProvider>(context).isDark();
    var eventProvider = Provider.of<EventProvider>(context);
    return Container(
      height: height * 0.33,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(
            isDark ? widget.model.imageDarkEvent : widget.model.imageLightEvent,
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
                    "${widget.model.dateEvent.day}",
                    textAlign: TextAlign.center,
                    style: AppStyle.bold18PrimaryLight,
                  ),
                  Text(
                    DateFormat('MMM').format(widget.model.dateEvent),
                    textAlign: TextAlign.center,
                    style: AppStyle.bold18PrimaryLight,
                  ),
                ],
              ),
            ),
            //desc
            Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.003,
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
                      widget.model.descEvent,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //todo update fav
                      eventProvider.updateFavouriteEvent(widget.model, context);
                    },
                    icon: Icon(
                      widget.model.isFavourite == true
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
