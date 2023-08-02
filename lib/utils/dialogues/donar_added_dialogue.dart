import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/widgets/button_for_dialogue.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../presentation/donar screens/donar_navigation.dart';
import '../../presentation/widgets/donation_icon.dart';
import '../../providers/donars_list_provider.dart';
import '../../style/images.dart';

donarAddedPopup(
  context,
) async {
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
              height: 140.h,
              width: 180.w,
            ),
            Text(
              'Donar Added Successfully',
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xff326060),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'You have successfully\nadded new donar !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              child: ButtonForDialogue(
                text: "Ok",
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
