
import 'package:flutter/material.dart';

import '../widgets/shimmer_effect.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(
                // height: 10.h,
                color: Colors.white,
                thickness: 10,
                indent: 20,
                endIndent: 20,
              ),
          itemCount: 4, // Show the shimmer effect 5 times
          itemBuilder: (context, index) => ShimmerEffect()),
    );
  }
}
