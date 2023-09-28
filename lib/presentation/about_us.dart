import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/custom_text_style.dart';
import '../style/styling.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  SizedBox k = SizedBox(
    height: 20.h,
  );
  SizedBox l = SizedBox(
    height: 10.h,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        title: const Text('About Us'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BackButton(),
          SvgPicture.asset(
            Images.contactUs,
            // color: Colors.white,
            height: 186.h,
            width: 268.w,
          ),
          l,

          Text(
            "Our Mission",
            style: CustomTextStyle.font_20_primaryColor,
            textAlign: TextAlign.center,
          ),
          l,
          const Text(
            "Donate2Shsare aim to Linking donors and NGOs, reducing waste by facilitating surplus food and clothing donations, and supporting those in need.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
