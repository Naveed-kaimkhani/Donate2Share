import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';
import '../../style/styling.dart';

class AdminHomeCard extends StatelessWidget {
  final String name;
  final int donation;
  final String unit;
  final String image;
  final double padding;
  Function() func;
  AdminHomeCard({
    required this.donation,
    required this.name,
    required this.padding,
    required this.func,
    required this.image,
    required this.unit,
    super.key,
  });
  TextStyle getCustomTextStyle(int value) {
    if (value.toString().length == 4) {
      return CustomTextStyle.font_32_white; // Use the larger font size
    } else {
      return CustomTextStyle.font_24_white; // Use the smaller font size
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 110.h,
        width: 142.w,
        decoration: BoxDecoration(
            color: Styling.primaryColor,
            borderRadius: BorderRadius.circular(30.r)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: padding, top: 53.h),
              child: Image.asset(
                image,
                height: 120.h,
                width: 120.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, top: 10.h),
              child: Text.rich(TextSpan(
                  text: name,
                  style: CustomTextStyle.font_20_white,
                  children: <InlineSpan>[
                    TextSpan(
                      text: '\n$donation',
                      style: getCustomTextStyle(donation),
                    ),
                    TextSpan(
                      text: '\n$unit',
                      style: CustomTextStyle.font_20_white,
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
