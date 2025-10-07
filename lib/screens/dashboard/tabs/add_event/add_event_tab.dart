import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/firebase/local/firebase_utils.dart';
import 'package:evently/firebase/model/event_model_fire.dart';
import 'package:evently/provider/language_provider/language_provider.dart';
import 'package:evently/screens/dashboard/tabs/add_event/widget/choose_event_location.dart';
import 'package:evently/screens/dashboard/tabs/add_event/widget/event_category_with_image.dart';
import 'package:evently/screens/dashboard/tabs/add_event/widget/event_date_and_time.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper/validator_helper.dart';
import '../../../../model/event_model.dart';

class AddEventTab extends StatefulWidget {
  const AddEventTab({super.key});

  @override
  State<AddEventTab> createState() => _AddEventTabState();
}

class _AddEventTabState extends State<AddEventTab> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? messageRequiredDate;
  String? messageRequiredTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  int selectedIndex = 1;
  List<EventModel> eventsModel = EventModel.events;
  String? imageEvent, nameEvent;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("create_event".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ////todo
                EventCategoryWithImage(
                  onCategorySelected: (image, name) {
                    imageEvent = image;
                    nameEvent = name;
                  },
                ),

                SizedBox(height: height * 0.03),
                //title
                Text(
                  "title".tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: height * 0.015),
                CustomTextField(
                  textStyle: Theme.of(context).textTheme.labelLarge!,
                  hint: "event_title".tr(),
                  controller: titleController,
                  validator: (text) => ValidatorHelper.validateTitle(text),
                  hintStyle: Theme.of(context).textTheme.labelLarge!,
                  borderColor: Theme.of(context).colorScheme.outline,
                  fillColor: AppColor.transparentColor,
                  prefixIcon: Icon(FontAwesome.pen_to_square),
                  prefixIconColor: Theme.of(context).colorScheme.outlineVariant,
                ),
                SizedBox(height: height * 0.03),
                //desc
                Text(
                  "description".tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: height * 0.015),
                CustomTextField(
                  textStyle: Theme.of(context).textTheme.labelLarge!,
                  hint: "event_description".tr(),
                  controller: descController,
                  validator: (text) =>
                      ValidatorHelper.validateDescription(text),
                  hintStyle: Theme.of(context).textTheme.labelLarge!,
                  borderColor: Theme.of(context).colorScheme.outline,
                  fillColor: AppColor.transparentColor,
                  maxLines: 5,
                ),
                SizedBox(height: height * 0.015),

                //date
                EventDateAndTime(
                  icon: Icons.calendar_month_outlined,
                  colorIcon: Theme.of(context).colorScheme.onTertiary,
                  text: "event_date".tr(),
                  textCheckValue: messageRequiredDate,
                  textButton: selectedDate == null
                      ? 'choose_date'.tr()
                      : language.isEnglishLanguage()
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : DateFormat.yMd('ar').format(selectedDate!),
                  onPressed: chooseDate,
                ),

                //time
                EventDateAndTime(
                  icon: Icons.access_time_rounded,
                  colorIcon: Theme.of(context).colorScheme.onTertiary,
                  text: "event_time".tr(),
                  textCheckValue: messageRequiredTime,
                  textButton: selectedTime == null
                      ? 'choose_time'.tr()
                      : language.isEnglishLanguage()
                      ? selectedTime!.format(context)
                      : DateFormat.jm('ar').format(
                          DateTime(
                            0,
                            1,
                            1,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          ),
                        ),
                  onPressed: chooseTime,
                ),
                SizedBox(height: height * 0.01),

                //location
                ChooseEventLocation(),

                SizedBox(height: height * 0.02),
                //add event
                CustomButton(
                  onPressed: addEvent,
                  backgroundColor: AppColor.primaryColor,
                  paddingHeight: height * 0.02,
                  text: "add_event".tr(),
                  styleText: Theme.of(context).textTheme.displayMedium!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }

  void chooseTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      selectedTime = time;
      setState(() {});
    }
  }

  void addEvent() {
    bool hasError = false;
    if (selectedDate == null) {
      messageRequiredDate = "date_required".tr();
      hasError = true;
    } else {
      messageRequiredDate = null;
    }

    if (selectedTime == null) {
      messageRequiredTime = "time_required".tr();
      hasError = true;
    } else {
      messageRequiredTime = null;
    }

    setState(() {});
    if (!formKey.currentState!.validate() || hasError) return;

    FireBaseUtils.addEventTOFireStore(
      EventModelFire(
        imageEvent: imageEvent!,
        nameCategoryEvent: nameEvent!,
        titleEvent: titleController.text,
        descEvent: descController.text,
        dateEvent: selectedDate!,
        timeEvent: selectedTime!.format(context),
      ),
    ).timeout(Duration(seconds: 1),onTimeout:() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "event_added".tr(),
            textAlign: TextAlign.center,
            style: AppStyle.bold20PrimaryLight,
          ),
          behavior: SnackBarBehavior.floating,
          margin:  EdgeInsets.symmetric(horizontal: 90, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      );
      Navigator.pop(context);
    }, );


  }
}
