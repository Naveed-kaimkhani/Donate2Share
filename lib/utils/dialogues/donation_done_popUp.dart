import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/widgets/button_for_dialogue.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../presentation/donar screens/donar_navigation.dart';
import '../../presentation/widgets/donation_icon.dart';
import '../../style/images.dart';

donationDonePopup(context,DonationModel donation) async {
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
                  onTap: () {
                  
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackDonation(donation: donation,)));
                  },
                ),
                SizedBox(
                  height: 14.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonarNavigation()));
                  },
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
