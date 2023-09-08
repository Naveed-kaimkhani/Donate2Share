import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:donation_app/presentation/widgets/track_donation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../style/custom_text_style.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/auth_header.dart';
import '../widgets/donation_widget.dart';
import '../widgets/wave_circle.dart';

class clothDonations extends StatelessWidget {
  final List<DonationModel> clothList;
  const clothDonations({required this.clothList, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DonarDonationHeader(text: "All Clothes Donations", height: 100.h),
              // clothDonationsHeader()
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: clothList.length,
                    itemBuilder: (context, index) {
                      return DonationWidget(
                        showButton: true,
                        donationModel: clothList[index]);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
