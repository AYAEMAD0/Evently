import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/model/event_item_model.dart';
import 'package:evently/screens/dashboard/tabs/home/widget/event_category.dart';
import 'package:evently/screens/dashboard/tabs/home/widget/welcome_and_name_theme_lang.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../model/event_model.dart';
import 'widget/event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  List<EventItemModel> valueModel = EventItemModel.eventItem;
  List<EventModel> eventsModel = EventModel.events;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: height * 0.26,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.025,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border(
                bottom: BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),

            child: Column(
              spacing: height * 0.024,
              children: [
                WelcomeAndNameThemeLang(),
                Row(
                  spacing: width * 0.014,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                DefaultTabController(
                  length: eventsModel.length,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.008,
                    ),
                    indicatorColor: AppColor.transparentColor,
                    dividerColor: AppColor.transparentColor,
                    onTap: (value) {
                      selectedIndex = value;
                      setState(() {});
                    },
                    tabs: List.generate(
                      eventsModel.length,
                      (index) => EventCategory(
                        colorBorderIsSelected: Theme.of(context).colorScheme.secondary,
                        colorIconSelected: Theme.of(context).colorScheme.primary,
                        colorIconNotSelected: Theme.of(context).cardColor,
                        styleTextSelected: Theme.of(context).textTheme.labelSmall!,
                        styleTextNotSelected:Theme.of(context).textTheme.bodyLarge!,
                        colorBackgroundIsSelected: Theme.of(context).colorScheme.secondary,
                        selected: index == selectedIndex,
                        eventName:eventsModel[index].eventName.tr(),
                        icon:eventsModel[index].icon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: height*0.019),
              separatorBuilder: (context, index) =>
                  SizedBox(height: height * 0.019),
              itemCount: valueModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.025),
                  child: EventItem(model: valueModel[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
