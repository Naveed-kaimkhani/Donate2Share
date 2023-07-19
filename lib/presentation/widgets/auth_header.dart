import 'package:donation_app/style/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import 'appbar_back_button.dart';

class AuthHeader extends StatelessWidget {
  final String? text;
  final double? height;

  AuthHeader({
    Key? key,
    required this.text,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: mq.width,
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 12.w),
            child: const AppBarBackButton(),
          ),
          if (text != null)
            Padding(
              padding: EdgeInsets.only(left: 67.w, top: 120.h),
              child: Text(
                "WellCome Back",
                style: CustomTextStyle.font_32,
                // style: TextStyle(color: Colors.white),
              ),
            ),
          if (text == null)
            Padding(
              padding: EdgeInsets.only(
                left: 100.w,
              ),
              child: Image.asset(
                Images.logo,
                color: Colors.white,
                height: 135.h,
                width: 135.w,
              ),
            ),
        ],
      ),
    );
  }
}
