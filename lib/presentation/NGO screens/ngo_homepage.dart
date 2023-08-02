import 'package:donation_app/presentation/donar%20screens/no_data_found.dart';
import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/presentation/widgets/ngo_home_header.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_data.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../utils/dialogues/send_request_dialogue.dart';
import '../widgets/chart_decoration.dart';
import '../widgets/chart_widget.dart';
import '../widgets/wave_circle.dart';

class NGOHomePage extends StatefulWidget {
  const NGOHomePage({Key? key}) : super(key: key);

  @override
  State<NGOHomePage> createState() => _NGOHomePageState();
}

class _NGOHomePageState extends State<NGOHomePage> {
  @override
  Widget build(BuildContext context) {
    UserModel? ngo = Provider.of<UserProvider>(context, listen: false).ngo;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 27.w, right: 27.w),
            child: StreamBuilder<List<DonationModel>>(
              stream: FirebaseUserRepository.getDonationList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const WaveCircleProgress();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataFoundScreen(
                    text: "No Donation",
                  );
                } else {
                  int? food = snapshot.data
                      ?.where((donation) => donation.type == 'food')
                      .toList()
                      .length;

                  int? clothes = snapshot.data
                      ?.where((donation) => donation.type == 'clothes')
                      .toList()
                      .length;
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: CustomTextStyle.font_14_black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ngo!.name ?? "No Name",
                                  style: CustomTextStyle.font_24_primaryColor),
                              ProfilePic(
                                  url: ngo.profileImage, height: 50, width: 48)
                            ],
                          ),
                          SizedBox(height: 11.h),
                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Text(
                            'Monthly Donation Analysis',
                            style: CustomTextStyle.font_24,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Container(
                            width: 325.w,
                            height: 158.h,
                            decoration: chardecoration(),
                            child: ChartWidget(
                              chartData:
                                  FirebaseUserRepository.getMonthlyDonation(
                                snapshot.data!,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Available Donation',
                            style: CustomTextStyle.font_24,
                          ),
                          SizedBox(height: 9.h),
                          NGOHomeHeader(
                            title: "Total Food available",
                            subTitle: "Kilograms",
                            value: food.toString(),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            child: NGOHomeHeader(
                              title: "Total Dress available",
                              subTitle: "Dresses",
                              value: clothes.toString(),
                            ),
                            onTap: () {},
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          // SizedBox(height: 5.h),
                          // Center(
                          //   child: Text('Request for Donation',
                          //       style: CustomTextStyle.font_24),
                          // ),
                          SizedBox(height: 8.h),
                          Center(
                            child: AuthButton(
                              text: "Request Now",
                              func: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SendRequestDialogue();
                                  },
                                );
                              },
                              color: Styling.primaryColor,
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
