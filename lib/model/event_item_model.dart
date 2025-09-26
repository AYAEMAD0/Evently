import 'package:evently/core/utils/app_asset.dart';

class EventItemModel {
  final String date;
  final String desc;
  final String imageLight;
  final String imageDark;

  const EventItemModel({required this.imageLight, required this.imageDark, required this.date, required this.desc});

  static List<EventItemModel> eventItem = [
    EventItemModel(
      date: '21\nNov',
      imageLight:AppAsset.birthdayImage,
      imageDark:AppAsset.birthdayImageDark ,
      desc: 'This is a Birthday Party',
    ),
    EventItemModel(
      date: '22\nNov',
      imageLight:AppAsset.meetingImage,
      imageDark:AppAsset.meetingImageDark ,
      desc: 'Meeting for Updating The Development Method ',
    ),
    EventItemModel(
      date: '23\nNov',
      imageLight:AppAsset.sportImage,
      imageDark:AppAsset.sportImageDark ,
      desc: 'This is a Sport',
    ),
  ];
}