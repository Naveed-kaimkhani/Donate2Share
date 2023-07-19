import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/firebase_user_repository.dart';
import '../../../providers/seller_provider.dart';

class DonationWidget extends StatefulWidget {
  // final FoodModel foodModel;
  const DonationWidget({
    Key? key,
    // required this.foodModel,
  }) : super(key: key);
  // bool? isAccepted = false;
  // String text = "Accepted";
  @override
  State<DonationWidget> createState() => _DonationWidgetState();
}

class _DonationWidgetState extends State<DonationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
      height: 100.h,
      width: 325.w,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.redAccent),
        borderRadius: BorderRadius.circular(30.r),
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
          Container(
              width: 130.h,
              height: 86.w,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Container(
                  // color: Styling.primaryColor,
                  )
              //  Image.asset(
              //   'assets/image.jpg', // Replace with your image path
              //   width: 130,
              //   height: 86,
              //   fit: BoxFit.cover,
              // ),
              ),
          Column(
            // mainAxisAlignment: Main,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Donated by",
                    style: CustomTextStyle.font_15,
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Column(
                    children: [
                      Text(
                        "04:39 PM",
                        style: CustomTextStyle.font_10_black,
                      ),
                      Text(
                        "29/07/2023",
                        style: CustomTextStyle.font_10_black,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  ProfilePic(
                      url:
                          "https://firebasestorage.googleapis.com/v0/b/donate2share-40014.appspot.com/o/profile_images%2Fbjveyg5A0SQGVFF7BcgbnSIpxPI2?alt=media&token=2c52f7cb-4f74-466f-b9d9-641f496d86ca",
                      height: 32.h,
                      width: 40.w),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(
                      "Naveed kk",
                      style: CustomTextStyle.font_25_appColor,
                    ),
                  ),
                ],
              ),
              Text.rich(TextSpan(
                  text: 'Quantity',
                  style: CustomTextStyle.font_10_black,
                  children: <InlineSpan>[
                    TextSpan(
                      text: '10 kg',
                      style: CustomTextStyle.
                      font_20,
                    )
                  ])),
            ],
          )
        ],
      ),
    );
  }
}
