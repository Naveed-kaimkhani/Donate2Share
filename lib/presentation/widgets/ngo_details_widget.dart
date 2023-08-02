import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/presentation/widgets/call_widget.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/firebase_user_repository.dart';
import '../../domain/models/seller_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/donars_list_provider.dart';
import '../../providers/ngos_list_provider.dart';

class NgoDetailsWidget extends StatelessWidget {
  // final String name;
  // final String url;
  // final String address;
  // final String phone;
  // final String uid;
  final UserModel donar;
  NgoDetailsWidget({
    Key? key,
    required this.donar,
    // required this.name,
    // required this.url,
    // required this.address,
    // required this.phone,
    // required this.uid,
  }) : super(key: key);
  SizedBox k = SizedBox(
    height: 6.h,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), // Provide a unique key for each Dismissible item
      onDismissed: (direction) async {
        // Add your code to handle the dismissal action here, e.g., delete the item from the list
        // You can use the `direction` parameter to determine the dismiss direction (left or right)
        // For example:
        if (direction == DismissDirection.startToEnd) {
          // Handle left swipe dismissal
        } else if (direction == DismissDirection.endToStart) {
          // await FirebaseUserRepository.deleteSellerDataFromFirestore(uid);

          await Provider.of<NgoListProvider>(context, listen: false)
              .deleteNgo(donar.uid!, context);
          utils.toastMessage("${donar.name} deleted");
          // Handle right swipe dismissal
        }
      },
      background: Container(
        padding: EdgeInsets.only(
          left: 8.w,
          top: 8.h,
        ),
        margin: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 16.h,
        ),
        height: 70.h,
        width: 325.w,
        alignment: Alignment.centerRight,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors
              .red, // border: Border.all(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      child: Container(
        padding: EdgeInsets.only(
          left: 8.w,
          top: 8.h,
        ),
        margin: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 16.h,
        ),
        height: 70.h,
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
            ProfilePic(url: donar.profileImage, height: 49.h, width: 56.w),
            Padding(
              padding: EdgeInsets.only(left: 13.w),
              child: Column(
                // mainAxisAlignment: Main,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donar.name!,
                    style: CustomTextStyle.font_20_primaryColor,
                  ),
                  k,
                  Text.rich(TextSpan(
                      text: 'Address: ',
                      style: CustomTextStyle.font_10_primaryColor,
                      children: <InlineSpan>[
                        TextSpan(
                          text: trimAddressToHalf(donar.address!),
                          style: CustomTextStyle.font_10_black,
                        )
                      ])),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text.rich(TextSpan(
                      text: 'phone: ',
                      style: CustomTextStyle.font_10_primaryColor,
                      children: <InlineSpan>[
                        TextSpan(
                          text: donar.phone,
                          style: CustomTextStyle.font_10_black,
                        )
                      ])),
                ],
              ),
            ),
            // SizedBox(
            //   width: 60.w,
            // ),
            Padding(
              padding: donar.address!.length < 31
                  ? EdgeInsets.only(left: 66.w, top: 10.h)
                  : EdgeInsets.only(left: 60.w, top: 10.h),
              child: CallWidget(
                  iconSize: 20.h,
                  radius: 20.r,
                  num: donar.phone!,
                  context: context),
            ),
          ],
        ),
      ),
    );
  }
}

String trimAddressToHalf(String address) {
  int halfLength = (address.length / 3).floor();
  return address.substring(0, halfLength);
}
