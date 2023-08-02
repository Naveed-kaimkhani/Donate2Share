import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:donation_app/presentation/widgets/track_donation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../style/custom_text_style.dart';
import '../widgets/auth_header.dart';
import '../widgets/donation_widget.dart';
import '../widgets/wave_circle.dart';
import 'no_data_found.dart';

class DonarDonationsScreen extends StatefulWidget {
  const DonarDonationsScreen({super.key});

  @override
  State<DonarDonationsScreen> createState() => _DonarDonationsScreenState();
}

class _DonarDonationsScreenState extends State<DonarDonationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DonarDonationHeader(text: "All Your Donations", height: 100.h),
              // DonarDonationsScreenHeader()
              StreamBuilder<List<DonationModel>>(
                stream: FirebaseUserRepository.getDonarDonations(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const WaveCircleProgress();
                    // return SizedBox();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const NoDataFoundScreen(
                      text: "No Donation",
                    );
                  } else {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 17.w, right: 17.w),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: TrackDonationWidget(
                                  donationModel: snapshot.data![index]),
                              onTap: () {
                                print("jfldjfldj");
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
