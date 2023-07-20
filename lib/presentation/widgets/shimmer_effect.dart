import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  ShimmerEffect({Key? key}) : super(key: key);
  final Decoration k = BoxDecoration(
    borderRadius: BorderRadius.circular(6.r),
    color: Colors.grey.withOpacity(0.5),
  );
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 119.h,
            width: 355.w,
            padding: const EdgeInsets.only(left: 1.0, top: 8.0),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 33.h,
                          width: 132.w,
                          decoration: k,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 23.h,
                          width: 103.w,
                          decoration: k,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    CircleAvatar(
                      radius: 24.r,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 18.h,
                      width: 88.w,
                      decoration: k,
                    ),
                    SizedBox(
                      width: 48.w,
                    ),
                    Container(
                      height: 28.h,
                      width: 88.w,
                      decoration: k,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Container(
                      height: 28.h,
                      width: 88.w,
                      decoration: k,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
