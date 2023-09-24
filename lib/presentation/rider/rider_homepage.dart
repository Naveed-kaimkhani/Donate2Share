import 'package:donation_app/domain/models/donation_ngo_model.dart';
import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:donation_app/presentation/widgets/tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/rider_provider.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/wave_circle.dart';

class RiderHomePage extends StatelessWidget {
  const RiderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SellerModel? rider =
        Provider.of<RiderProvider>(context, listen: false).rider;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DonarDonationHeader(text: "Your Pending Rides", height: 100.h,backButton: false,),
            StreamBuilder<List<DonationNgoModel>>(
              stream: FirebaseUserRepository.getAssignedRides(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const WaveCircleProgress();
                  // return SizedBox();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataFoundScreen(
                    text: "No pending rides",
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return TrackingWidget(model: snapshot.data![index]);
                      }));
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
