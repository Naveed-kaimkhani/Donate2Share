import 'package:donation_app/presentation/widgets/call_widget.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/styling.dart';

class TracingScreenBottomNavigation extends StatelessWidget {
  const TracingScreenBottomNavigation({
    super.key,
    required this.distance,
    required this.halfLength,
    required this.adminAddress,
    required this.firstLine,
    required this.phone,
    // required this.widget,
  });

  final double? distance;
  final double halfLength;
  // final SellerUserTracing widget;
  final String adminAddress;
  final double firstLine;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 26.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: Styling.primaryColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                "${(distance! / 1000).toString().substring(0, halfLength.toInt())} km",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Styling.primaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(adminAddress
                  .substring(0, firstLine.toInt())),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            child: Container(
              height: 40.h,
              width: 230.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Styling.primaryColor,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  Text(
                    "Call Donar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            onTap: () {
              utils.launchphone(phone, context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
