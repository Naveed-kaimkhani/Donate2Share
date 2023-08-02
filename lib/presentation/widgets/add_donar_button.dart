import 'package:donation_app/utils/dialogues/donar_added_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/styling.dart';
import '../donar screens/donar_signup.dart';

class AddNewDonarButton extends StatelessWidget {
  const AddNewDonarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonarSignup(
              addedByAdmin: true,
            ),
          ),
        );
      },
      icon: CircleAvatar(
          radius: 40.r,
          backgroundColor: Styling.primaryColor,
          child: Icon(Icons.add)),
      color: Colors.white,
      iconSize: 50.h,
    );
  }
}
