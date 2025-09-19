import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/app_asset.dart';

class WelcomeAndNameThemeLang extends StatelessWidget {
  const WelcomeAndNameThemeLang({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Row(
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
              "Aya Emad",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        Spacer(),
        SvgPicture.asset(
          AppAsset.sunLightImage,
          color: Theme.of(context).cardColor,
          height: 28,
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
    );
  }
}
