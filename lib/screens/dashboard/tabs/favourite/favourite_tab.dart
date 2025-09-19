import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../../../model/event_item_model.dart';
import '../home/widget/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  final List<EventItemModel> model = EventItemModel.eventItem;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.025,
          vertical: height * 0.01,
        ),
        child: Column(
          children: [
            CustomTextField(
              hint: "search_for_event".tr(),
              controller: searchController,
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: height * 0.019),
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.019),
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return EventItem(model: model[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
