import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/style/images.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/models/user_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../widgets/admin_home_card.dart';
import '../widgets/chart_widget.dart';
import '../widgets/custom_divider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? admin = Provider.of<AdminProvider>(context, listen: false).admin;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: CustomTextStyle.font_14_black,
              ),
              Text(admin!.name ?? "No Name",
                  style: CustomTextStyle.font_24_primaryColor),
              SizedBox(height: 11.h),
              const CustomDivider(),

               Container(
                          width: 325.w,
                          height: 158.h,
                          decoration: chardecoration(),
                          child: ChartWidget(
                            chartData:FirebaseUserRepository.getMonthlyDonation(snapshot.data!),
                          ),
                        ),
              SizedBox(
                height: 9.h,
              ),

              Text(
                'Available Donation',
                style: CustomTextStyle.font_24,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminHomeCard(
                    donation: 4666,
                    name: "Food",
                    unit: "kilogram",
                    image: Images.foodpic,
                    padding: 72.w,
                  ),
                  AdminHomeCard(
                    donation: 4666,
                    name: "Clothes",
                    unit: "Dress",
                    image: Images.clothpic,
                    padding: 85.w,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomDivider(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Available Donation',
                style: CustomTextStyle.font_24,
              ),
            ],
          ),
        ),
      ),
    ));
  }
  BoxDecoration chardecoration() {
    return BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff326060),
                              width: 1,
                            ));
  }

}



