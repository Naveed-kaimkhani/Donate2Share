import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/request_model.dart';

class NGOHomeRecentDonation extends StatefulWidget {
  final RequestModel donationModel;
  final bool showButton;
  const NGOHomeRecentDonation({
    Key? key,
    required this.showButton,
    required this.donationModel,
  }) : super(key: key);

  @override
  State<NGOHomeRecentDonation> createState() => _NGOHomeRecentDonationState();
}

class _NGOHomeRecentDonationState extends State<NGOHomeRecentDonation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        top: 8.h,
      ),
      margin: EdgeInsets.only(
        right: 12.w,
        top: 10.h,
      ),
      height: 90.h,
      width: 250.w,
      decoration: BoxDecoration(
        color: Styling.primaryColor,
        // border: Border.all(width: 1, color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              // mainAxisAlignment: Main,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //  crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sent by",
                      style: CustomTextStyle.font_12_white,
                    ),
                    SizedBox(
                      width: 128.w,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.donationModel.sentTime!,
                          style: CustomTextStyle.font_10_white,
                        ),
                        Text(
                          widget.donationModel.sentDate!,
                          style: CustomTextStyle.font_10_white,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfilePic(
                        url: widget.donationModel.senderProfileImage!,
                        height: 32.h,
                        width: 39.w),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        widget.donationModel.senderName!,
                        style: CustomTextStyle.font_20_white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 38.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: 'Quantity: ',
                              style: CustomTextStyle.font_10_white,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: widget.donationModel.donationType ==
                                          'food'
                                      ? '${widget.donationModel.quantity} Kg'
                                      : '${widget.donationModel.quantity} Dress',
                                  style: CustomTextStyle.font_10_white,
                                )
                              ])),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text.rich(TextSpan(
                              text: 'Type: ',
                              style: CustomTextStyle.font_10_white,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: widget.donationModel.donationType,
                                  style: TextStyle(color: Colors.white),
                                )
                              ])),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 24.w,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
