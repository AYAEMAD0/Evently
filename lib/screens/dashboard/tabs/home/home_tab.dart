import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/screens/dashboard/tabs/home/widget/event_item.dart';
import 'package:evently/screens/dashboard/tabs/home/widget/welcome_and_name_theme_lang.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  List eventNameList = [
    "all".tr(),
    "sport".tr(),
    "birthday".tr(),
    "meeting".tr(),
    "gaming".tr(),
    "workshop".tr(),
    "exhibition".tr(),
    "book_club".tr(),
    "eating".tr(),
    "holiday".tr(),
  ];

  List eventIconList = [
    FontAwesome.compass,
    FontAwesome.basketball_solid,
    FontAwesome.cake_candles_solid,
    FontAwesome.handshake,
    FontAwesome.gamepad_solid,
    FontAwesome.screwdriver_wrench_solid,
    FontAwesome.image,
    FontAwesome.book_atlas_solid,
    FontAwesome.utensils_solid,
    FontAwesome.umbrella_beach_solid,
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: height * 0.27,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.025,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
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
                  length: eventNameList.length,
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
                      eventNameList.length,
                      (index) => EventItem(
                        selected: index == selectedIndex,
                        eventName: eventNameList[index],
                        icon: eventIconList[index]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
