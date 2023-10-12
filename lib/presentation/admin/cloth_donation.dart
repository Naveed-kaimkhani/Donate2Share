import 'package:donation_app/presentation/donation_details.dart';
import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/donation_model.dart';
import '../widgets/donation_widget.dart';


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
              DonarDonationHeader(
                text: "All Clothes Donations",
                height: 100.h,
                backButton: true,
              ),
              // clothDonationsHeader()
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: clothList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: DonationWidget(
                            showButton: true, donationModel: clothList[index]),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DonationDetails(
                                donationModel: clothList[index]);
                          }));
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
