import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import 'appbar_back_button.dart';

class DonationScreenHeader extends StatelessWidget {
  String title;
  String subTitle;
  String image;
  double padding;

  DonationScreenHeader({
    super.key,
    required this.padding,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(image),
        // BackButton()
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 12.w),
              child: InkWell(
                child: const AppBarBackButton(),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: padding),
              child: Text.rich(TextSpan(
                  text: '             $title',
                  style: CustomTextStyle.font_32_white,
                  children: <InlineSpan>[
                    TextSpan(
                      text: '\n         $subTitle',
                      style: CustomTextStyle.font_20_white,
                    )
                  ])),
            ),
          ],
        ),
      ],
    );
  }
}
