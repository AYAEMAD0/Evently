import 'package:flutter/material.dart';

import '../../../../../core/utils/app_asset.dart';
import '../../../../../core/utils/app_style.dart';

class ImageAndNameAndEmail extends StatelessWidget {
  const ImageAndNameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Row(
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
              Text('John Safwat', style: AppStyle.bold24WhiteLight),
              Text(
                'johnsafwat.route@gmail.com',
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
