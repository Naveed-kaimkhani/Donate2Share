import 'package:donation_app/presentation/widgets/button_for_dialogue.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../presentation/widgets/donation_icon.dart';
import '../../style/images.dart';

donationDonePopup(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              Images.done,
              height: 120.h,
              width: 120.w,
            ),
            Text(
              'Donated Successfully',
              style: TextStyle(
                fontSize: 22.sp,
                color: const Color(0xff326060),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'You have Donated successfully\n you can track your donation.\n Thank you.\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: ButtonForDialogue(
                    text: "Track",
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 14.w,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff326060),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
