import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../style/styling.dart';

class WaveCircle extends StatelessWidget {
  const WaveCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 277.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: const Center(
        child: SpinKitWaveSpinner(
          color: Styling.primaryColor,
          size: 40.0,
        ),
      ),
    );
  }
}
