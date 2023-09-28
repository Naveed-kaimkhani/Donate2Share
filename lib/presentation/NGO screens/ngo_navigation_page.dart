import 'package:donation_app/presentation/NGO%20screens/ngo_homepage.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_setting.dart';
import 'package:donation_app/presentation/NGO%20screens/request_details.dart';
import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';
import '../chatting_screen.dart';

class NgoNavigation extends StatefulWidget {
  const NgoNavigation({Key? key}) : super(key: key);
  @override
  State<NgoNavigation> createState() => _NgoNavigationState();
}

class _NgoNavigationState extends State<NgoNavigation> {
  List pages = [
    const NGOHomePage(),
    const RequestDetails(),
    const ChattingScreen(),
    const NGOSetting()
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
  Widget currentScreen = const NGOHomePage();
  SizedBox k = SizedBox(
    width: 20.w,
  );
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const NGOHomePage();
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
                        k,
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const RequestDetails();
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
                        k,
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const ChattingScreen();
                              currentindex = 2;
                            });
                          },
                          child: Icon(
                            size: 26.h,
                            Icons.message,
                            color:
                                currentindex == 2 ? Colors.white : Colors.grey,
                          ),
                        ),
                        k,
                        MaterialButton(
                          minWidth: 40.w,
                          onPressed: () {
                            setState(() {
                              currentScreen = const NGOSetting();
                              currentindex = 3;
                            });
                          },
                          child: Icon(
                            size: 26.h,
                            Icons.settings,
                            color:
                                currentindex == 3 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ])),
        ));
  }
}
