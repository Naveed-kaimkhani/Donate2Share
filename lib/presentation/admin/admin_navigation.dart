import 'package:donation_app/presentation/admin/admin_setting.dart';
import 'package:donation_app/presentation/admin/donation_request.dart';
import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';
import 'admin_homepage.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({Key? key}) : super(key: key);
  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  List pages = [
    AdminHomePage(),

    const DonationRequestScreen(),
    const AdminSetting(),
    const AdminSetting(),
    // const DonarSetting(),
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = AdminHomePage();
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
                              currentScreen = AdminHomePage();
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
                        SizedBox(
                          width: 25.w,
                        ),
                        MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              setState(() {
                                currentScreen = const DonationRequestScreen();
                                currentindex = 1;
                              });
                            },
                            child: Icon(
                              Icons.notifications_outlined,
                              color: currentindex == 1
                                  ? Colors.white
                                  : Colors.grey,
                              size: 28.h,
                            )),
                        SizedBox(
                          width: 25.w,
                        ),
                        MaterialButton(
                            minWidth: 40.w,
                            onPressed: () {
                              setState(() {
                                currentScreen = const AdminSetting();
                                currentindex = 2;
                              });
                            },
                            child: Icon(
                              Icons.chat,
                              color: currentindex == 2
                                  ? Colors.white
                                  : Colors.grey,
                              size: 28.h,
                            )),
                        SizedBox(
                          width: 25.w,
                        ),
                        MaterialButton(
                            minWidth: 40.w,
                            onPressed: () {
                              setState(() {
                                currentScreen = const AdminSetting();
                                currentindex = 3;
                              });
                            },
                            child: Icon(
                              Icons.settings_outlined,
                              color: currentindex == 3
                                  ? Colors.white
                                  : Colors.grey,
                              size: 28.h,
                            )),
                      ],
                    ),
                  ])),
        ));
  }
}
