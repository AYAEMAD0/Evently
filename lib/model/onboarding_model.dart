import '../core/utils/app_asset.dart';

class OnboardingModel {
  String image;
  String title;
  String desc;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AppAsset.onboardingImage2,
        title: "title2",
        desc:"desc2"
    ),
    OnboardingModel(
      image: AppAsset.onboardingImage3,
      title: "title3",
      desc:"desc3"
    ),
    OnboardingModel(
      image: AppAsset.onboardingImage4,
        title: "title4",
        desc:"desc4"
    ),
  ];
}
