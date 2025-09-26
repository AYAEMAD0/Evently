import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/widget/custom_button.dart';

class ChooseEventLocation extends StatelessWidget {
  const ChooseEventLocation({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        "location".tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      SizedBox(height: height * 0.015),
      CustomButton(
        onPressed: addLocation,
        backgroundColor: AppColor.transparentColor,
        borderColor: AppColor.primaryColor,
        isIcon: true,
        iconWidget: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.016,
              ),
              margin: EdgeInsetsDirectional.only(end: width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.primaryColor,
              ),
              child: Icon(
                Icons.my_location_sharp,
                size: 30,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            Text(
              "choose_event_location".tr(),
              style: AppStyle.bold16Primary,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.primaryColor,
            ),
            SizedBox(width: width * 0.01),
          ],
        ),
      ),
    ],);
  }
  void addLocation() {

  }
}
