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
  const AdminHomeCard({
    required this.donation,
    required this.name,
    required this.padding,
    required this.image,
    required this.unit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 152.w,
      decoration: BoxDecoration(
          color: Styling.primaryColor,
          borderRadius: BorderRadius.circular(30.r)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 27.w, top: 10.h),
            child: Text.rich(TextSpan(
                text: name,
                style: CustomTextStyle.font_20_white,
                children: <InlineSpan>[
                  TextSpan(
                    text: '\n$donation',
                    style: CustomTextStyle.font_32_white,
                  ),
                  TextSpan(
                    text: '\n$unit',
                    style: CustomTextStyle.font_20_white,
                  )
                ])),
          ),
          Padding(
            padding: EdgeInsets.only(left: padding, top: 68.h),
            child: Image.asset(image),
          )
        ],
      ),
    );
  }
}
