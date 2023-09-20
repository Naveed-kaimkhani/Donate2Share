import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/request_model.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class NgoRecentAcceptedRequest extends StatelessWidget {
  final RequestModel request;
  const NgoRecentAcceptedRequest({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 227.w,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Styling.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.senderName!,
                  style: CustomTextStyle.font_18_white,
                ),
                Text(
                  "${request.quantity} ",
                  style: CustomTextStyle.font_18_white,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              request.description!,
              style: CustomTextStyle.font_18_white,
            ),
            SizedBox(
              height: 8.h,
            ),
            // Row(
            //   children: [
            //     SvgPicture.asset(Images.spot),
            //     Text(
            //       " Spots ${request.availableSlots}",
            //       style: CustomTextStyle.font_12_grey,
            //     ),
            //     SizedBox(
            //       width: 82.w,
            //       // height: 8.h,
            //     ),
            //     const Icon(
            //       Icons.hourglass_bottom,
            //       color: Styling.primaryColor,
            //     ),
            //     Text(
            //       "1 hr",
            //       style: CustomTextStyle.font_12_grey,
            //     ),
            //   ],
            // )
          ],
        ));
  }
}
