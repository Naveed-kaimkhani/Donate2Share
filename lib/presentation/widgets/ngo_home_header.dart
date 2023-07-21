
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';

class NGOHomeHeader extends StatelessWidget {
  String title;
  String value;
  String subTitle;
  NGOHomeHeader(
      {super.key,
      required this.subTitle,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      height: 82.h,
      decoration: BoxDecoration(
          color: const Color(0xff326060),
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 9, left: 15),
            child: Text(
              title,
              style: CustomTextStyle.font_18_white,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 8.w),
                child: Container(
                  width: 40.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff326060)),
                  )),
                ),
              ),
              Text(subTitle, style: CustomTextStyle.font_18_white)
            ],
          )
        ],
      ),
    );
  }
}
