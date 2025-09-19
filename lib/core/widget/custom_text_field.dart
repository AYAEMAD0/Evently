import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;

  const CustomTextField({
    required this.hint,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    this.keyboard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return
        TextFormField(
          style: Theme.of(context).textTheme.headlineSmall,

          controller: controller,
          validator: validator,
          autofocus: false,
          maxLines: maxLines,
          cursorColor: AppColor.primaryColor,
          cursorHeight: height*0.025,
          cursorWidth: width*0.006,
          keyboardType: keyboard ?? TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:AppStyle.bold16PrimaryLight,
            contentPadding:
             EdgeInsets.symmetric(horizontal: width*0.05, vertical:height*0.025),
            enabledBorder: builtBorder(false),
            focusedBorder: builtBorder(false),
            errorBorder:  builtBorder(true),
            prefixIcon: Icon(Icons.search),
            prefixIconColor: AppColor.primaryColor,
            focusedErrorBorder: builtBorder(true),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
          ),
        );
  }
  OutlineInputBorder builtBorder(isError){
    return  OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide:
      BorderSide(color: isError?AppColor.redColor: AppColor.primaryColor, width: 1.5),
    );
  }
}
