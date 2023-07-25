import 'package:donation_app/presentation/widgets/wave_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../style/styling.dart';
import '../../style/custom_text_style.dart';

class LoadingMap extends StatelessWidget {
  const LoadingMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: WaveCircleProgress()
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Loading Map...",
              style: CustomTextStyle.font_14_black,
            )
          ],
        ),
      ),
    );
  }
}
