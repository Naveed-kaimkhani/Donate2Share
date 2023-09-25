import 'package:donation_app/main.dart';
import 'package:donation_app/presentation/widgets/appbar_back_button.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/images.dart';

class AllDonarsScreenHeader extends StatelessWidget {
  final String header;
  final String subHeader;
  final bool backButton;
  // final Function() func;
  const AllDonarsScreenHeader({
    required this.header,
    required this.backButton,
    required this.subHeader,
    // required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: EdgeInsets.only(left: 30.w),
        width: mq.width,
        decoration: BoxDecoration(
          color: Styling.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
        ),
        child: backButton
            ? Row(
                children: [
                  const AppBarBackButton(),
                  SizedBox(
                    width: 50.w,
                  ),
                  Text.rich(TextSpan(
                      text: '$header',
                      style: CustomTextStyle.font_24_white,
                      children: <InlineSpan>[
                        TextSpan(
                          text: '\n        $subHeader',
                          style: CustomTextStyle.font_20_white,
                        )
                      ])),
                ],
              )
            : Center(
                child: Text.rich(TextSpan(
                    text: '$header',
                    style: CustomTextStyle.font_24_white,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '\n        $subHeader',
                        style: CustomTextStyle.font_20_white,
                      )
                    ])),
              ));
  }
}
