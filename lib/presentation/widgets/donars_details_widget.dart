// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:donation_app/presentation/widgets/call_widget.dart';
// import 'package:donation_app/presentation/widgets/profile_pic.dart';
// import 'package:donation_app/style/custom_text_style.dart';
// import 'package:donation_app/style/styling.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../data/firebase_user_repository.dart';
// import '../../../providers/seller_provider.dart';
// import '../../domain/models/donation_model.dart';
// import '../../domain/models/seller_model.dart';

// class DonarsDetailsWidget extends StatelessWidget {
//   final SellerModel donar;
//   DonarsDetailsWidget({
//     Key? key,
//     required this.donar,
//   }) : super(key: key);
//   SizedBox k = SizedBox(
//     height: 6.h,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: 8.w,
//         top: 8.h,
//       ),
//       margin: EdgeInsets.only(
//         left: 10.w,
//         right: 10.w,
//         top: 16.h,
//       ),
//       height: 70.h,
//       width: 325.w,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         // border: Border.all(width: 1, color: Colors.redAccent),
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ProfilePic(url: donar.profileImage, height: 49.h, width: 60.w),
//           Padding(
//             padding: EdgeInsets.only(left: 13.w),
//             child: Column(
//               // mainAxisAlignment: Main,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   donar.name!,
//                   style: CustomTextStyle.font_20_primaryColor,
//                 ),
//                 k,
//                 Text.rich(TextSpan(
//                     text: 'Address: ${donar.address!.length.toString()} ',
//                     style: CustomTextStyle.font_10_primaryColor,
//                     children: <InlineSpan>[
//                       TextSpan(
//                         text: trimAddressToHalf(donar.address!),
//                         style: CustomTextStyle.font_10_black,
//                       )
//                     ])),
//                 SizedBox(
//                   height: 4.h,
//                 ),
//                 Text.rich(TextSpan(
//                     text: 'phone: ',
//                     style: CustomTextStyle.font_10_primaryColor,
//                     children: <InlineSpan>[
//                       TextSpan(
//                         text: donar.phone.toString(),
//                         style: CustomTextStyle.font_10_black,
//                       )
//                     ])),
//               ],
//             ),
//           ),
//           // SizedBox(
//           //   width: 60.w,
//           // ),
//           Padding(
//             padding: donar.address!.length < 31
//                 ? EdgeInsets.only(left: 76.w, top: 10.h)
//                 : EdgeInsets.only(left: 50.w, top: 10.h),
//             child: CallWidget(
//                 iconSize: 20.h,
//                 radius: 20.r,
//                 num: donar.phone!,
//                 context: context),
//           ),
//         ],
//       ),
//     );
//   }
// }

// String trimAddressToHalf(String address) {
//   int halfLength = (address.length / 2).floor();
//   return address.substring(0, halfLength);
// }
