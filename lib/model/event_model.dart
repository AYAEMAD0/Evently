import 'package:evently/core/utils/app_asset.dart';
import 'package:icons_plus/icons_plus.dart';

class EventModel {
  final String eventName;
  final FontAwesomeIconData icon;
  final String? imageLight;
  final String? imageDark;
  EventModel({
    required this.eventName,
    required this.icon,
     this.imageLight,
     this.imageDark,
  });

  static List<EventModel> events = [
    EventModel(
      eventName: "all",
      icon: FontAwesome.compass,
    ),
    EventModel(
      eventName: "sport",
      icon: FontAwesome.basketball_solid,
      imageLight: AppAsset.sportImage,
      imageDark: AppAsset.sportImageDark,
    ),
    EventModel(
      eventName: "birthday",
      icon: FontAwesome.cake_candles_solid,
      imageLight: AppAsset.birthdayImage,
      imageDark: AppAsset.birthdayImageDark,
    ),
    EventModel(
      eventName: "meeting",
      icon: FontAwesome.handshake,
      imageLight: AppAsset.meetingImage,
      imageDark: AppAsset.meetingImageDark,
    ),
    EventModel(
      eventName: "gaming",
      icon: FontAwesome.gamepad_solid,
      imageLight: AppAsset.gamingImage,
      imageDark: AppAsset.gamingImageDark,
    ),
    EventModel(
      eventName: "workshop",
      icon: FontAwesome.screwdriver_wrench_solid,
      imageLight: AppAsset.workShopImage,
      imageDark: AppAsset.workShopImageDark,
    ),
    EventModel(
      eventName: "exhibition",
      icon: FontAwesome.image,
      imageLight: AppAsset.exhibitionImage,
      imageDark: AppAsset.exhibitionImageDark,
    ),
    EventModel(
      eventName: "book_club",
      icon: FontAwesome.book_atlas_solid,
      imageLight: AppAsset.bookClubImage,
      imageDark: AppAsset.bookClubImageDark,
    ),
    EventModel(
      eventName: "eating",
      icon: FontAwesome.utensils_solid,
      imageLight: AppAsset.eatingImage,
      imageDark: AppAsset.eatingImageDark,
    ),
    EventModel(
      eventName: "holiday",
      icon: FontAwesome.umbrella_beach_solid,
      imageLight: AppAsset.holidayImage,
      imageDark: AppAsset.holidayImageDark,
    ),
  ];
}
