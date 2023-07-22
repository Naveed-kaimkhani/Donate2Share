import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../style/styling.dart';

class WaveCircleProgress extends StatelessWidget {
  const WaveCircleProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWaveSpinner(
        color: Colors.white,
        trackColor: Styling.primaryColor,
        size: 50.h,
        waveColor: Styling.primaryColor,
      ),
    );
  }
}
