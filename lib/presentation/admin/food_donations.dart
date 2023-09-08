import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/donation_model.dart';
import '../widgets/donation_widget.dart';

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
                padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      return DonationWidget(
                          showButton: true, donationModel: foodList[index]);
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
