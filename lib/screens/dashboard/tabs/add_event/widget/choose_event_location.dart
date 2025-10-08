import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widget/custom_button.dart';

class ChooseEventLocation extends StatelessWidget {
  const ChooseEventLocation({super.key, required this.icon,this.isIconEnd=true, required this.value});
  final IconData icon;
  final bool isIconEnd;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomButton(
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
            margin: EdgeInsetsDirectional.only(end: width * 0.035),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.primaryColor,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
         value,
          Spacer(),
          isIconEnd?
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColor.primaryColor,
          ):
              SizedBox.shrink(),
          SizedBox(width: width * 0.01),
        ],
      ),
    );
  }
  void addLocation() {

  }
}
