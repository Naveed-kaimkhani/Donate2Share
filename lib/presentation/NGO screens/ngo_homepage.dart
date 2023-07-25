import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/presentation/widgets/ngo_home_header.dart';
import 'package:donation_app/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/models/donation_data.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../widgets/chart_widget.dart';

class NGOHomePage extends StatefulWidget {
  const NGOHomePage({Key? key}) : super(key: key);

  @override
  State<NGOHomePage> createState() => _NGOHomePageState();
}

class _NGOHomePageState extends State<NGOHomePage> {
  @override
  Widget build(BuildContext context) {
    UserModel? ngo = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 27.w, right: 27.w),
            child: Column(
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
                        ProfilePic(url: ngo.profileImage, height: 50, width: 48)
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
                      'Total Donation',
                      style: CustomTextStyle.font_24,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Container(
                      width: 325.w,
                      height: 158.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff326060),
                            width: 1,
                          )
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
                      value: "400",
                    ),
                    SizedBox(height: 20.h),
                    NGOHomeHeader(
                      title: "Total Dress available",
                      subTitle: "Dresses",
                      value: "400",
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      height: 1,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 5.h),
                    Center(
                      child: Text('Request for Donation',
                          style: CustomTextStyle.font_24),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: AuthButton(
                        text: "Donate Now",
                        func: () {},
                        color: Styling.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
