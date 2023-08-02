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

class FoodDonations extends StatelessWidget {
  final List<DonationModel> foodList;
  const FoodDonations({required this.foodList, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DonarDonationHeader(text: "All Food Donations", height: 100.h),
              // FoodDonationsHeader()
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 27.w, right: 27.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: DonationWidget(donationModel: foodList[index]),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TrackDonation(
                          //               donation: snapshot.data![index],
                          //             )
                          //             )
                          //             );
                        },
                      );
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
