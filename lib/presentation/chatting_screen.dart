import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/coming_soon.svg",
              height: 300.h, width: 350.w),
          const Text("Coming Soon")
        ],
      ),
    );
  }
}
