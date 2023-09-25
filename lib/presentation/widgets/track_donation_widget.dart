import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/domain/models/donation_ngo_model.dart';
import 'package:donation_app/presentation/donar%20screens/food_tracking_by_donar.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/presentation/widgets/track_donation_button.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/utils/dialogues/custom_loader.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../NGO screens/test.dart';

class TrackDonationWidget extends StatelessWidget {
  final DonationModel donationModel;
  const TrackDonationWidget({
    Key? key,
    required this.donationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        top: 8.h,
      ),
      margin: EdgeInsets.only(
        // left: 8.w,
        top: 12.h,
      ),
      height: 100.h,
      width: 335.w,
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
            imageUrl: donationModel.pictures![0],
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
                          donationModel.sentTime!,
                          style: CustomTextStyle.font_10_black,
                        ),
                        Text(
                          donationModel.sentDate!,
                          style: CustomTextStyle.font_10_black,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ProfilePic(
                        url: donationModel.donarProfileImage,
                        height: 32.h,
                        width: 39.w),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        donationModel.donarName!,
                        style: CustomTextStyle.font_20_appColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                        text: 'Quantity: ',
                        style: CustomTextStyle.font_10_primaryColor,
                        children: <InlineSpan>[
                          TextSpan(
                            text: donationModel.type == 'food'
                                ? '${donationModel.quantity} Kg'
                                : '${donationModel.quantity} Dress',
                            style: CustomTextStyle.font_10_black,
                          )
                        ])),
                    SizedBox(
                      width: 8.w,
                    ),
                    InkWell(
                      child: const TrackDonationButton(
                        text: "Track",
                      ),
                      onTap: () async {
                        // print("calllllll");
                        LoaderOverlay.show(context);
                        DonationNgoModel? model =
                            await FirebaseUserRepository.fetchRidesByRiderId(
                                donationModel.donationId!, context);
                        LoaderOverlay.hide();
                        if (model == null) {
                          utils.toastMessage("Rider is not assigned Yet");
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodTrackingByDonar(
                                        requestModel: model,
                                      )));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
