import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../style/custom_text_style.dart';
import '../../../style/styling.dart';

class DonationDoneDialogue extends StatefulWidget {
  const DonationDoneDialogue({super.key});

  @override
  State<DonationDoneDialogue> createState() => _DonationDoneDialogueState();
}

class _DonationDoneDialogueState extends State<DonationDoneDialogue> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shadowColor: Color.fromARGB(255, 135, 130, 130),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const DoneIcon(),
            Lottie.asset(Images.done),
            Text(
              "Request Sent",
              style: CustomTextStyle.font_24_primaryColor,
            ),
            Text(
              "You will ge help soon",
              style: CustomTextStyle.font_15,
            ),
            SizedBox(height: 16.h),
            // InkWell(
            //   child: GeneralBttnForUserHmPg(
            //     text: "Ok",
            //   ),
            //   onTap: () async {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class DoneIcon extends StatelessWidget {
  const DoneIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Styling.primaryColor,
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
