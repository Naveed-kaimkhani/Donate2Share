import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/custom_text_style.dart';
import '../../../style/styling.dart';
class SelectFoodClothDialogue extends StatefulWidget {
  const SelectFoodClothDialogue({super.key});

  @override
  State<SelectFoodClothDialogue> createState() => _SelectFoodClothDialogueState();
}

class _SelectFoodClothDialogueState extends State<SelectFoodClothDialogue> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shadowColor: Color.fromARGB(255, 135, 130, 130),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DoneIcon(),
            Text(
              "Request Sent",
              style: CustomTextStyle.font_25,
            ),
            Text(
              "You will ge help soon",
              style: CustomTextStyle.font_15_black,
            ),
            SizedBox(height: 16.h),
            InkWell(
              child: GeneralBttnForUserHmPg(
                text: "Ok",
              ),
              onTap: () async {
                Navigator.pop(context);
              },
            ),
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
