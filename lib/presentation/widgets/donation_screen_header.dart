
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import 'appbar_back_button.dart';

class DonationScreenHeader extends StatelessWidget {
  const DonationScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.donation_screen_header),
        // BackButton()
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 12.w),
              child: const AppBarBackButton(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 46.w),
              child: Text.rich(TextSpan(
                  text: '         Donate',
                  style: CustomTextStyle.font_32,
                  children: <InlineSpan>[
                    TextSpan(
                      text: '\nLife Saving Food To Faimlies',
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
