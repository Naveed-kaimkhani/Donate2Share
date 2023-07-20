
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundScreen extends StatelessWidget {
final String text;
 const NoDataFoundScreen({
 required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/no_data.json",
            height: 300.h, width: 300.w),
        Text(text)
      ],
    );
  }
}
