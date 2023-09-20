import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_home_widget.dart';
import 'package:donation_app/presentation/donar%20screens/no_data_found.dart';
import 'package:donation_app/presentation/widgets/admin_home_card.dart';
import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_data.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import '../../utils/dialogues/send_request_dialogue.dart';
import '../admin/cloth_donation.dart';
import '../admin/food_donations.dart';
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
            child: StreamBuilder<List<RequestModel>>(
              stream: FirebaseUserRepository.getNGODonationList(context),
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
                      ?.where((donation) => donation.donationType == 'food')
                      .toList()
                      .length;
                  print("foood lenght${food}");
                  int? clothes = snapshot.data
                      ?.where((donation) => donation.donationType == 'clothes')
                      .toList()
                      .length;

                  print("foood lenght${clothes}");
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
                                  url: ngo.profileImage, height: 50, width: 50)
                            ],
                          ),
                          SizedBox(height: 11.h),
                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            height: 4.h,
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
                              chartData: FirebaseUserRepository
                                  .getNGOMonthlyDonationData(
                                snapshot.data!,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          // SizedBox(height: 6.h),
                          SizedBox(height: 9.h),

                          Text(
                            'Available Donation',
                            style: CustomTextStyle.font_20_black,
                          ),
                          SizedBox(height: 4.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AdminHomeCard(
                                donation: utils.countQuantityForNGO(
                                    snapshot.data!, "food"),
                                name: "Food",
                                unit: "kilogram",
                                image: Images.foodpic,
                                padding: 72.w,
                                func: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => FoodDonations(
                                  //               foodList: foodList ?? [],
                                  //             )));
                                },
                              ),
                              AdminHomeCard(
                                donation: utils.countQuantityForNGO(
                                    snapshot.data!, "clothes"),
                                name: "Clothes",
                                unit: "Dress",
                                image: Images.clothpic,
                                padding: 95.w,
                                func: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => clothDonations(
                                  //               clothList: clotheList ?? [],
                                  //             )));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          Divider(
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          // SizedBox(height: 6.h),
                          SizedBox(height: 4.h),

                          Text(
                            'Recent Accepted Request',
                            style: CustomTextStyle.font_20_black,
                          ),
                          // SizedBox(height: 4.h),

                          SizedBox(
                            height: 110.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: NGOHomeRecentDonation(
                                      showButton: false,
                                      donationModel: snapshot.data![index],
                                    ),
                                    onTap: () {},
                                  );
                                }),
                          ),

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
                          ),
                          SizedBox(height: 8.h),
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
