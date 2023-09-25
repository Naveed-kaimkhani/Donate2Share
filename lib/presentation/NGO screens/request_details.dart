import 'package:donation_app/presentation/widgets/donation_request_widget.dart';
import 'package:flutter/material.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/ngo_side_request_widget.dart';
import '../widgets/wave_circle.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({super.key});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // floatingActionButton: const AddNewDonarButton(),
      body: StreamBuilder<List<RequestModel>>(
          stream:
              FirebaseUserRepository.getDonationRequestForSpecificNgo(context),
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
                      header: "Your Donation",
                      subHeader: "Requests",
                      backButton: false,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return NgoSideRequestWidget(
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
