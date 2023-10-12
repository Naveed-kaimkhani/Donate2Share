import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/domain/models/donation_ngo_model.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/dialogues/custom_loader.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../rider/donation_ngo_tracking.dart';

class TrackingWidget extends StatefulWidget {
  final DonationNgoModel model;
  const TrackingWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<TrackingWidget> createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends State<TrackingWidget> {
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
            imageUrl: widget.model.pictures![0],
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
                      width: 90.w,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.model.sentTime!,
                          style: CustomTextStyle.font_10_black,
                        ),
                        Text(
                          widget.model.sentDate!,
                          style: CustomTextStyle.font_10_black,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ProfilePic(
                        url: widget.model.donarProfileImage,
                        height: 32.h,
                        width: 39.w),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        widget.model.donarName!,
                        style: CustomTextStyle.font_20_appColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text.rich(TextSpan(
                            text: 'Quantity: ',
                            style: CustomTextStyle.font_10_primaryColor,
                            children: <InlineSpan>[
                              TextSpan(
                                text: widget.model.donationType == 'food'
                                    ? '${widget.model.quantity} Kg'
                                    : '${widget.model.quantity} Dress',
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
                                    '${widget.model.donarAddress}'),
                                style: CustomTextStyle.font_8_black,
                              )
                            ])),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    InkWell(
                        child: Container(
                          height: 30.h,
                          width: 34.w,
                          decoration: BoxDecoration(
                              color: Styling.primaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          LoaderOverlay.show(context);
                          await FirebaseUserRepository.updateRideStatus(
                              widget.model.documentId!);
                          LoaderOverlay.hide();
                          utils.toastMessage("Ride mark completed");
                        }),
                    SizedBox(
                      width: 8.w,
                    ),
                    InkWell(
                        child: Container(
                          height: 30.h,
                          width: 34.w,
                          decoration: BoxDecoration(
                              color: Styling.primaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: const Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Donatin_Ngo_Tracing(
                                        requestModel: widget.model,
                                      )));
                        })
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
