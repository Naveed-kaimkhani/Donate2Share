import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/domain/models/seller_model.dart';
import 'package:donation_app/presentation/donar%20screens/shimmer_screen.dart';
import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/presentation/widgets/ngo_home_header.dart';
import 'package:donation_app/providers/seller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/models/donation_model.dart';
import '../../domain/models/graph_dots.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../widgets/chart_widget.dart';
import '../widgets/donation_widget.dart';
import 'no_data_found.dart';

class DonarHomePage extends StatefulWidget {
  const DonarHomePage({Key? key}) : super(key: key);

  @override
  State<DonarHomePage> createState() => _DonarHomePageState();
}

class _DonarHomePageState extends State<DonarHomePage> {
  @override
  Widget build(BuildContext context) {
    SellerModel? donar =
        Provider.of<SellerProvider>(context, listen: false).seller;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 27.w, right: 27.w),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: CustomTextStyle.font_14_black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ehsaan Foundations',
                            style: CustomTextStyle.font_24_primaryColor),
                        CircleAvatar(
                          backgroundColor: Color(0xff326060),
                          radius: 22.r,
                        )
                      ],
                    ),
                    SizedBox(height: 11.h),
                    Divider(
                      height: 1,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'Monthly Donation Analysis',
                      style: CustomTextStyle.font_24,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: 325.w,
                      height: 158.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff326060),
                            width: 1,
                          )),
                      child: ChartWidget(),
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      height: 1,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Successful Donation',
                      style: CustomTextStyle.font_24,
                    ),
                    // StreamBuilder<List<DonationModel>>(
                    //   stream: FirebaseUserRepository.getDonationList(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       // return const ShimmerScreen();
                    //       return SizedBox();
                    //     } else if (snapshot.hasError) {
                    //       return Text(snapshot.error.toString());
                    //     } else if (!snapshot.hasData ||
                    //         snapshot.data!.isEmpty) {
                    //       return const NoDataFoundScreen(
                    //         text: "No Donation",
                    //       );
                    //     } else {
                    //       return SizedBox(
                    //         height: MediaQuery.of(context).size.height,
                    //         child: ListView.builder(
                    //           itemCount: snapshot.data!.length,
                    //           itemBuilder: (context, index) {
                    //             return DonationWidget(
                    //                 donationModel: snapshot.data![index]);
                    //           },
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
