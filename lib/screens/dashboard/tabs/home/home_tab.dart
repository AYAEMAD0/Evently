import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/provider/event_provider/event_provider.dart';
import 'package:evently/provider/user_provider/user_provider.dart';
import 'package:evently/screens/dashboard/tabs/home/widget/event_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_asset.dart';
import '../../../../model/event_model.dart';
import '../../../../provider/theme_provider/theme_provider.dart';
import 'widget/event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> eventsModel = EventModel.events;
  late EventProvider event;
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      event.getAllEvent(userProvider.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    event = Provider.of<EventProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.005,
                      children: [
                        Text(
                          'welcome'.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          userProvider.currentUser!.name  ,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (theme.themeApp == ThemeMode.light) {
                          theme.changeTheme(ThemeMode.dark);
                        } else {
                          theme.changeTheme(ThemeMode.light);
                        }
                      },
                      child: SvgPicture.asset(
                        theme.isDark()
                            ? AppAsset.sunLightImage
                            : AppAsset.moonImage,
                        color: Theme.of(context).cardColor,
                        height: 28,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: width * 0.03),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.007,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        context.locale.languageCode.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),

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
                      event.changeIndex(value,userProvider.currentUser!.id);
                    },
                    tabs: List.generate(
                      eventsModel.length,
                      (index) => EventCategory(
                        colorBorderIsSelected: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        colorIconSelected: Theme.of(
                          context,
                        ).colorScheme.primary,
                        colorIconNotSelected: Theme.of(context).cardColor,
                        styleTextSelected: Theme.of(
                          context,
                        ).textTheme.labelSmall!,
                        styleTextNotSelected: Theme.of(
                          context,
                        ).textTheme.bodyLarge!,
                        colorBackgroundIsSelected: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        selected: index == event.selectedIndex,
                        eventName: eventsModel[index].eventName.tr(),
                        icon: eventsModel[index].icon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: event.filterList.isEmpty
                ? Center(
                    child: Text(
                      "no_events_yet".tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: height * 0.019),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.019),
                    itemCount: event.filterList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: InkWell(
                            onTap: (){
                              //todo nav details
                              Navigator.pushNamed(context, AppRoute.detailsEventRouteName,arguments: event.filterList[index]);
                            },
                            child: EventItem(model: event.filterList[index])),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
