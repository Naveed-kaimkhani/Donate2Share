import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  static final font_20 = TextStyle(
    color: Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );
  static final font_20_white = TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final font_24_white = TextStyle(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final font_24 = TextStyle(
    color: Colors.black,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );
  static final font_15 = TextStyle(
    color: Color.fromARGB(255, 129, 125, 125),
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
  );
  static final font_14_black = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static final font_24_primaryColor = TextStyle(
    color: Styling.primaryColor,
    fontSize: 24.sp,
    fontFamily: "Sansita",
    fontWeight: FontWeight.w700,
  );

  static final font_32 = TextStyle(
    color: Styling.primaryColor,
    fontSize: 32.sp,
    fontFamily: "Sansita",
    fontWeight: FontWeight.w700,
  );
  static final font_25_appColor = TextStyle(
    color: Styling.primaryColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static final font_10_black = TextStyle(
    color: Colors.black,
    fontSize: 10.sp,
    // fontWeight: FontWeight.w700,
  );

  static final font_18_black = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  
  static final font_18_white = TextStyle(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static final font_15_primaryColor = TextStyle(
    color: Styling.primaryColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
  );
}
