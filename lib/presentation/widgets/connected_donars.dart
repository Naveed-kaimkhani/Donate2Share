
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectedDonars extends StatelessWidget {
  const ConnectedDonars({
    super.key,
    required this.donarCardList,
  });

  final List<Widget>? donarCardList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return donarCardList![index];
        },
      ),
    );
  }
}