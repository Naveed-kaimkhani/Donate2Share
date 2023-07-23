import 'package:donation_app/presentation/widgets/button_for_dialogue.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentation/widgets/donation_icon.dart';
import '../../style/images.dart';

selectDonationTypePopup(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        content: SizedBox(
          height: 120.h,
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DonationIcon(
                    image: Images.food,
                    route: RoutesName.donateFood,
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  const DonationIcon(
                    image: Images.clothe_icon,
                    route: RoutesName.donateClothes,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                child: ButtonForDialogue(
                  text: "Cancel",
                ),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
