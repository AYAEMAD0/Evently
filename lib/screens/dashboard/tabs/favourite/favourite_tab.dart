import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/provider/event_provider/event_provider.dart';
import 'package:evently/provider/user_provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_style.dart';
import '../home/widget/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventProvider.getAllFavouriteEvent(userProvider.currentUser!.id);
    });
    super.initState();
  }

  late EventProvider eventProvider;
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    eventProvider = Provider.of<EventProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.025,
          vertical: height * 0.03,
        ),
        child: Column(
          children: [
            CustomTextField(
              hint: "search_for_event".tr(),
              controller: searchController,
              textStyle: Theme.of(context).textTheme.headlineSmall!,
              hintStyle: AppStyle.bold18PrimaryLight,
              borderColor: AppColor.primaryColor,
              prefixIconColor: AppColor.primaryColor,
              prefixIcon: Icon(Icons.search),
              onChanged: (favSearch) {
                //todo search event fav
              },
              fillColor: AppColor.transparentColor,
            ),
            Expanded(
              child: eventProvider.filterFavouriteList.isEmpty
                  ? Center(
                      child: Text(
                        'no_favourite_event'.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.only(top: height * 0.019),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.019),
                      itemCount: eventProvider.filterFavouriteList.length,
                      itemBuilder: (context, index) {
                        return EventItem(
                          model: eventProvider.filterFavouriteList[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
