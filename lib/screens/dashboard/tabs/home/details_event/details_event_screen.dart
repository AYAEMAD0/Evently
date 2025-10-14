import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/firebase/local/firebase_utils.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:evently/provider/event_provider/event_provider.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:evently/provider/user_provider/user_provider.dart';
import 'package:evently/screens/dashboard/tabs/home/details_event/widget/show_date_and_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_style.dart';
import '../../add_event/widget/choose_event_location.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key});

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  late EventProvider eventProvider;
  late UserProvider userProvider;
  late EventModelFire event;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    event = ModalRoute.of(context)!.settings.arguments as EventModelFire;
    eventProvider = Provider.of<EventProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("event_details".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
        actions: [
          InkWell(
            onTap: () {
              //todo edit button
              Navigator.pushNamed(
                context,
                AppRoute.editEventRouteName,
                arguments: event,
              );
            },
            child: SvgPicture.asset(AppAsset.editImage),
          ),
          SizedBox(width: width * 0.026),
          InkWell(
            onTap: () {
              //todo delete button
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: theme.isDark()
                        ? AppColor.backgroundDarkColor
                        : AppColor.backgroundLightColor,
                    title: Text(
                      "delete_event".tr(),
                      style: AppStyle.bold20PrimaryLight,
                    ),
                    content: Text(
                      "delete_event_confirmation".tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    actions: [
                      TextButton(
                        child: Text("ok".tr(), style: AppStyle.medium16Primary),
                        onPressed: () {
                          //todo delete event
                          deleteEvent();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "cancel".tr(),
                          style: AppStyle.medium16Primary,
                        ),
                        onPressed: () {
                          //todo cancel
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: SvgPicture.asset(AppAsset.deleteImage),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  theme.isDark() ? event.imageDarkEvent : event.imageLightEvent,
                ),
              ),
              SizedBox(height: height * 0.03),
              Text(event.titleEvent, style: AppStyle.bold20PrimaryLight),
              SizedBox(height: height * 0.03),
              //date,time
              ShowDateAndTime(event: event),
              SizedBox(height: height * 0.03),
              //location
              ChooseEventLocation(
                onPressed: () {
                  //todo show location
                },
                value: Text(
                  "choose_event_location".tr(),
                  style: AppStyle.bold16Primary,
                ),
              ),
              //todo map
              SizedBox(height: height * 0.03),
              Container(
                height: height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColor.primaryColor),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text("description".tr(), style: AppStyle.bold20PrimaryLight),
              SizedBox(height: height * 0.01),
              Text(
                event.descEvent,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteEvent() {
    FireBaseUtils.deleteEventToFireStore(event,userProvider.currentUser!.id)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "event_deleted".tr(),
                  textAlign: TextAlign.center,
                  style: AppStyle.bold20PrimaryLight,
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            );
            Navigator.popUntil(context, (route) {
              return route.settings.name == AppRoute.dashBoardRouteName;
            });

        },);
    //     .timeout(
    //   Duration(seconds: 1),
    //   onTimeout: () {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           "event_deleted".tr(),
    //           textAlign: TextAlign.center,
    //           style: AppStyle.bold20PrimaryLight,
    //         ),
    //         behavior: SnackBarBehavior.floating,
    //         margin: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //       ),
    //     );
    //     Navigator.popUntil(context, (route) {
    //       return route.settings.name == AppRoute.dashBoardRouteName;
    //     });
    //   },
    // );
  }

  @override
  void dispose() {
    eventProvider.changeIndex(eventProvider.selectedIndex,userProvider.currentUser!.id);
    super.dispose();
  }
}
