import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class AppStyle {
  static final TextStyle bold20Primary = GoogleFonts.inter(
    fontSize: 20,
    color: AppColor.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bold16BlackLight = GoogleFonts.inter(
    fontSize: 16,
    color: AppColor.blackColor,
    fontWeight: FontWeight.w500,
  ) ;

  static final TextStyle bold16WhiteDark = GoogleFonts.inter(
    fontSize: 16,
    color: AppColor.whiteBeigeColor,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium20White= GoogleFonts.inter(
    fontSize: 24,
    color: AppColor.whiteColor,
    fontWeight: FontWeight.w500,
  ) ;


}
