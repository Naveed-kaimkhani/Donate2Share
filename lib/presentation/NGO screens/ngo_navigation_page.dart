import 'package:donation_app/presentation/NGO%20screens/ngo_homepage.dart';
import 'package:donation_app/presentation/NGO%20screens/request_details.dart';
import 'package:donation_app/presentation/donar%20screens/donar_homepage.dart';
import 'package:donation_app/presentation/donar%20screens/donar_setting.dart';
import 'package:donation_app/presentation/donar%20screens/donar_donation_screen.dart';
import 'package:donation_app/style/images.dart';
import 'package:donation_app/utils/dialogues/donation_done_popUp.dart';
import 'package:donation_app/utils/dialogues/select_donation_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

class NgoNavigation extends StatefulWidget {
  const NgoNavigation({Key? key}) : super(key: key);
  @override
  State<NgoNavigation> createState() => _NgoNavigationState();
}

class _NgoNavigationState extends State<NgoNavigation> {
  List pages = [
    NGOHomePage(),
    RequestDetails(),
    // const DonarDonationsScreen(),
    // const DonarSetting(),
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = NGOHomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Styling.primaryColor,
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: BottomAppBar(
          color: Styling.primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
              height: 60.h,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = NGOHomePage();
                              currentindex = 0;
                            });
                          },
                          child: Image.asset(
                            Images.home,
                            height: 26.h,
                            width: 26.w,
                            color:
                                currentindex == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = RequestDetails();
                              currentindex = 1;
                            });
                          },
                          child: Icon(
                            size: 26.h,
                            Icons.notifications_none,
                            color:
                                currentindex == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ])),
        ));
  }
}
