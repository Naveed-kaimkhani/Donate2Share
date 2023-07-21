import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/firebase_user_repository.dart';
import '../../../providers/seller_provider.dart';
import '../../domain/models/donation_model.dart';

class DonationWidget extends StatefulWidget {
  final DonationModel donationModel;
  const DonationWidget({
    Key? key,
    required this.donationModel,
  }) : super(key: key);

  @override
  State<DonationWidget> createState() => _DonationWidgetState();
}

class _DonationWidgetState extends State<DonationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        top: 8.h,
      ),
      margin: EdgeInsets.only(
        // left: 8.w,
        top: 10.h,
      ),
      height: 100.h,
      width: 325.w,
      decoration: BoxDecoration(
        color: Colors.white,
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
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              height: 86.h,
              width: 130.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
            imageUrl: widget.donationModel.pictures![0],
          ),
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
                      "Donated by",
                      style: CustomTextStyle.font_12_black,
                    ),
                    SizedBox(
                      width: 38.w,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.donationModel.sentTime!,
                          style: CustomTextStyle.font_10_black,
                        ),
                        Text(
                          widget.donationModel.sentDate!,
                          style: CustomTextStyle.font_10_black,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ProfilePic(
                        url: widget.donationModel.donatorProfileImage,
                        height: 32.h,
                        width: 39.w),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        "Naveed kk",
                        style: CustomTextStyle.font_20_appColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text.rich(TextSpan(
                    text: 'Quantity: ',
                    style: CustomTextStyle.font_10_primaryColor,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${widget.donationModel.quantity} kg',
                        style: CustomTextStyle.font_10_black,
                      )
                    ])),
                SizedBox(
                  height: 4.h,
                ),
                Text.rich(TextSpan(
                    text: 'Add: ',
                    style: CustomTextStyle.font_10_primaryColor,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${widget.donationModel.donatorAddress}',
                        style: CustomTextStyle.font_8_black,
                      )
                    ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
