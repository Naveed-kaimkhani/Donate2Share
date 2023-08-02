
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/firebase_user_repository.dart';

class ConnectedDonarsWidget extends StatelessWidget {
  final int num;
  final String head;
  final String subHead;
  final String image;


  const ConnectedDonarsWidget({
    required this.num,
    required this.head,
    required this.image,
    required this.subHead,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
    width: 287.w,
    height: 140.h,
    child: Stack(
      children: [
        Image.asset(image),
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 18.h),
          child: Text.rich(TextSpan(
            text: num.toString(),
            style: CustomTextStyle.font_32_white,
            children: <InlineSpan>[
              TextSpan(
                text: '\n$head',
                style: CustomTextStyle.font_20_white,
              ),
              TextSpan(
                text: '\n$subHead',
                style: CustomTextStyle.font_20_white,
              )
            ],
          )),
        ),
      ],
    ),
  );

  }
}
