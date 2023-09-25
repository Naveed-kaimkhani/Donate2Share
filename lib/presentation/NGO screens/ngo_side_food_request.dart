import 'package:donation_app/presentation/widgets/donar_donations_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/request_model.dart';
import '../widgets/ngo_side_request_widget.dart';

class NGOSideFoodRequest extends StatelessWidget {
  final List<RequestModel> foodList;
  const NGOSideFoodRequest({required this.foodList, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DonarDonationHeader(
                text: "All Accepted Request",
                height: 100.h,
                backButton: true,
              ),
              // NGOSideFoodRequestHeader()
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 4.w, right: 4.w),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          return NgoSideRequestWidget(
                            donationModel: foodList[index],
                          );
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
