import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/domain/models/donation_ngo_model.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/presentation/widgets/track_donation_button.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/dialogues/custom_loader.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/firebase_user_repository.dart';
import '../../../providers/seller_provider.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';

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
                      width: 58.w,
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
                        url: widget.donationModel.donarProfileImage,
                        height: 32.h,
                        width: 39.w),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        widget.donationModel.donarName!,
                        style: CustomTextStyle.font_20_appColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text.rich(TextSpan(
                            text: 'Quantity: ',
                            style: CustomTextStyle.font_10_primaryColor,
                            children: <InlineSpan>[
                              TextSpan(
                                text: widget.donationModel.type == 'food'
                                    ? '${widget.donationModel.quantity} Kg'
                                    : '${widget.donationModel.quantity} Dress',
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
                                text: utils.trimAddressToHalf(
                                    '${widget.donationModel.donarAddress}'),
                                style: CustomTextStyle.font_8_black,
                              )
                            ])),
                      ],
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    InkWell(
                      child: const TrackDonationButton(text: "send rider"),
                      onTap: () async {
                        LoaderOverlay.show(context);
                        utils.toastMessage("Assigning rider");

                        List<RequestModel> requests =
                            await FirebaseUserRepository
                                .getDonationRequestToAssignRider(
                                    widget.donationModel.type!, context);
                        if (requests.isEmpty) {
                          LoaderOverlay.hide();
                          utils.flushBarErrorMessage(
                              "No Pending Request", context);
                        } else {
                          DonationNgoModel rideDetails = DonationNgoModel(
                            donationType: widget.donationModel.type,
                            ngoUid: requests[0].senderUid,
                            quantity: widget.donationModel.quantity,
                            ngoAddress: requests[0].senderAddress,
                            donarLat: widget.donationModel.donarLat,
                            donarLong: widget.donationModel.donarLong,
                            ngoLat: requests[0].senderLat,
                            ngoLong: requests[0].senderLong,
                            donarPhone: widget.donationModel.donarPhone,
                            donarAddress: widget.donationModel.donarAddress,
                            pictures: widget.donationModel.pictures,
                            donarProfileImage:
                                widget.donationModel.donarProfileImage,
                            sentDate: widget.donationModel.sentDate,
                            sentTime: widget.donationModel.sentTime,
                          );
                          await FirebaseUserRepository.assignRider(
                              rideDetails, context);

                          LoaderOverlay.hide();
                        }
                      },
                    )
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
