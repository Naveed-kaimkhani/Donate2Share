import 'package:donation_app/presentation/widgets/donation_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonarHomePage extends StatelessWidget {
  const DonarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Succesful Donations",
                style: CustomTextStyle.font_24,
              ),
              DonationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
