import 'package:donation_app/presentation/widgets/donation_request_widget.dart';
import 'package:flutter/material.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/wave_circle.dart';

class DonationRequestScreen extends StatefulWidget {
  const DonationRequestScreen({super.key});

  @override
  State<DonationRequestScreen> createState() => _DonationRequestScreenState();
}

class _DonationRequestScreenState extends State<DonationRequestScreen> {
  fetchDonationData() async {}
  @override
  void initState() {
    super.initState();
    fetchDonationData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // floatingActionButton: const AddNewDonarButton(),
      body: StreamBuilder<List<RequestModel>>(
          stream: FirebaseUserRepository.getDonationRequest(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaveCircleProgress();
              // return SizedBox();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const NoDataFoundScreen(
                text: "No Request",
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const AllDonarsScreenHeader(
                      header: " Donation",
                      subHeader: "Requests",
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return DonationRequestWidget(
                                donationModel: snapshot.data![index],
                              );
                            }))
                  ],
                ),
              );
            }
          }),
    ));
  }
}
