import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../provider/language_provider/language_provider.dart';
import '../../add_event/widget/choose_event_location.dart';

class DetailsEventScreen extends StatelessWidget {
  const DetailsEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var language = Provider.of<LanguageProvider>(context);
    var theme = Provider.of<ThemeProvider>(context);
    EventModelFire event =
        ModalRoute.of(context)!.settings.arguments as EventModelFire;

    final inputFormat = DateFormat.jm();
    final dateTime = inputFormat.parse(event.timeEvent);

    return Scaffold(
      appBar: AppBar(
        title: Text("event_details".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
        actions: [
          GestureDetector(
            onTap: () {
              //todo edit
            },
            child: SvgPicture.asset(AppAsset.editImage),
          ),
          SizedBox(width: width * 0.02),
          GestureDetector(
            onTap: () {
              //todo delete
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
              // Directionality(
              //   textDirection: language.isEnglishLanguage()
              //       ? TextDirection.ltr
              //       : TextDirection.rtl,
              //   child:
                Text(
                  event.titleEvent,
                  style: AppStyle.bold20PrimaryLight,
                ),
              //),
              SizedBox(height: height * 0.03),

              //data ,time
              ChooseEventLocation(
                icon: Icons.calendar_month_outlined,
                value: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    language.isEnglishLanguage()?
                Text(
                  DateFormat('d MMM yyyy', 'en').format(event.dateEvent),
                  style: AppStyle.bold16Primary,
                )
                        :
                    Text(
                      DateFormat('d MMM yyyy', 'ar').format(event.dateEvent),
                      style: AppStyle.bold16Primary,
                    ),

                    language.isEnglishLanguage()
                        ? Text(event.timeEvent, style: AppStyle.bold16Primary)
                        : Text(
                            DateFormat.jm('ar').format(dateTime),
                            style: AppStyle.bold16Primary,
                          ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              //location
              ChooseEventLocation(
                icon: Icons.my_location_sharp,
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
              // Directionality(
              //   textDirection: ,
                //child:
                Text(
                  event.descEvent,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
