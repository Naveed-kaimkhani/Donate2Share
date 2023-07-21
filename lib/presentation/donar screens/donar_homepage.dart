import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/donar%20screens/shimmer_screen.dart';
import 'package:donation_app/presentation/widgets/donation_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/firebase_user_repository.dart';
import 'no_data_found.dart';

class DonarHomePage extends StatelessWidget {
  const DonarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 18.w, top: 18.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text.rich(TextSpan(
                        text: 'wellcome',
                        style: CustomTextStyle.font_20,
                        children: <InlineSpan>[
                          TextSpan(
                            text: '\nNaveed',
                            style: CustomTextStyle.font_32,
                          )
                        ])),
                  ],
                )
                // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //   stream: FirebaseFirestore.instance
                //       .collection("donations")
                //       .snapshots(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const ShimmerScreen();
                //     } else if (snapshot.hasError) {
                //       return Text(snapshot.error.toString());
                //     } else if (!snapshot.hasData ||
                //         snapshot.data!.docs.isEmpty) {
                //       return const NoDataFoundScreen(
                //         text: "No pending request",
                //       );
                //     } else {
                //       return SizedBox(
                //         height: MediaQuery.of(context).size.height,
                //         child: ListView.builder(
                //           itemCount: snapshot.data!.docs.length,
                //           itemBuilder: (context, index) {
                //             return Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("fd"),
                //             );
                //           },
                //         ),
                //       );
                //     }
                //   },
                // ),
                // DonationWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
