import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_asset.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../provider/user_provider/user_provider.dart';

class ImageAndNameAndEmail extends StatelessWidget {
  const ImageAndNameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          AppAsset.routeImage,
          height: height * 0.25,
          width: width * 0.35,
        ),
        SizedBox(width: width * 0.07),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userProvider.currentUser!.name, style: AppStyle.bold24WhiteLight),
              Text(
                userProvider.currentUser!.email,
                style: AppStyle.medium16White,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
