import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../model/event_model.dart';
import '../../../../../provider/theme_provider/theme_provider.dart';
import '../../home/widget/event_category.dart';

class EventCategoryWithImage extends StatefulWidget {
  const EventCategoryWithImage({super.key, required this.onCategorySelected});
  final Function(
    String imageLightEvent,
    String imageDarkEvent,
    String nameEvent,
  )
  onCategorySelected;

  @override
  State<EventCategoryWithImage> createState() => _EventCategoryWithImageState();
}

class _EventCategoryWithImageState extends State<EventCategoryWithImage> {
  int selectedIndex = 1;
  List<EventModel> eventsModel = EventModel.events;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCategorySelected(
        eventsModel[selectedIndex].imageLight!,
        eventsModel[selectedIndex].imageDark!,
        eventsModel[selectedIndex].eventName.tr(),
      );
    });
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            theme.isDark()
                ? eventsModel[selectedIndex].imageDark!
                : eventsModel[selectedIndex].imageLight!,
          ),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(
          height: height * 0.055,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: eventsModel.length - 1,
            separatorBuilder: (context, index) => SizedBox(width: width * 0.02),
            itemBuilder: (context, item) {
              int index = item + 1;
              return InkWell(
                onTap: () {
                  selectedIndex = index;
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(28),
                child: EventCategory(
                  colorBackgroundIsSelected: AppColor.primaryColor,
                  colorIconSelected: Theme.of(context).colorScheme.surface,
                  colorIconNotSelected: AppColor.primaryColor,
                  styleTextSelected: Theme.of(context).textTheme.displayLarge!,
                  styleTextNotSelected: AppStyle.bold16Primary,
                  colorBorderIsSelected: AppColor.primaryColor,
                  selected: index == selectedIndex,
                  eventName: eventsModel[index].eventName.tr(),
                  icon: eventsModel[index].icon,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
