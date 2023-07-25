import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/models/donation_model.dart';

class TrackDonationButton extends StatelessWidget {
  const TrackDonationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Styling.primaryColor),
      child: Center(
        child: Text(
          "Track",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
