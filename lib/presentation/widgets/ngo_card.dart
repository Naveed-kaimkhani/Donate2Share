import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';

class NGOCard extends StatelessWidget {
  final String url;
  final String name;
  const NGOCard({
    required this.url,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfilePic(url: url, height: 48.h, width: 58.w),
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 4.h),
          child: Text(
            name,
            style: CustomTextStyle.font_14_black,
          ),
        )
      ],
    );
  }
}
