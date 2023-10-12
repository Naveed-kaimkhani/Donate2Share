import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/presentation/widgets/track_donation_button.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';

class DonationRequestWidget extends StatefulWidget {
  final RequestModel donationModel;
//  final List<DonationModel> donationsList;
  const DonationRequestWidget({
    Key? key,
    // required this.donationsList,
    required this.donationModel,
  }) : super(key: key);

  @override
  State<DonationRequestWidget> createState() => _DonationRequestWidgetState();
}

class _DonationRequestWidgetState extends State<DonationRequestWidget> {
  Future<bool> checkAvailability() async {
    List<DonationModel> donations =
        await FirebaseUserRepository.getDonations(context);
    int available =
        utils.countQuantity(donations, widget.donationModel.donationType!);
    bool result = available > widget.donationModel.quantity! ? true : false;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        top: 8.h,
      ),
      margin: EdgeInsets.only(left: 12.w, top: 16.h, right: 12.w),
      height: 90.h,
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
          ProfilePic(
              url: widget.donationModel.senderProfileImage,
              height: 48.h,
              width: 58.w),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              // mainAxisAlignment: Main,
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.donationModel.senderName}" ?? "",
                      style: CustomTextStyle.font_20_appColor,
                    ),
                    SizedBox(
                      width: widget.donationModel.senderName!.length > 10
                          ? 40.w
                          : 120.w,
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
                SizedBox(
                  height: 4.h,
                ),
                Text.rich(TextSpan(
                    text: 'Required: ',
                    style: CustomTextStyle.font_10_primaryColor,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${widget.donationModel.donationType}',
                        style: CustomTextStyle.font_10_black,
                      )
                    ])),
                SizedBox(
                  height: 4.h,
                ),
                Text.rich(TextSpan(
                    text: 'Quantity: ',
                    style: CustomTextStyle.font_10_primaryColor,
                    children: <InlineSpan>[
                      TextSpan(
                        text: widget.donationModel.donationType
                                .toString()
                                .contains("food")
                            ? '${widget.donationModel.quantity} kg'
                            : '${widget.donationModel.quantity} Dress',
                        style: CustomTextStyle.font_10_black,
                      )
                    ])),
                SizedBox(
                  width: 110.w,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                        text: 'Add: ',
                        style: CustomTextStyle.font_10_primaryColor,
                        children: <InlineSpan>[
                          TextSpan(
                            text: utils.trimAddressToHalf(
                                '${widget.donationModel.senderAddress}'),
                            style: CustomTextStyle.font_8_black,
                          )
                        ])),
                    SizedBox(
                      width: 65.w,
                    ),
                    widget.donationModel.status == "accepted"
                        ? const TrackDonationButton(text: "Accepted")
                        : InkWell(
                            child: const TrackDonationButton(
                              text: "Accept",
                            ),
                            onTap: () async {
                              await checkAvailability()
                                  ? FirebaseUserRepository.grantDonation(
                                      widget.donationModel, context)
                                  : utils.flushBarErrorMessage(
                                      "Insufficient ${widget.donationModel.donationType}",
                                      context);
                            },
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
