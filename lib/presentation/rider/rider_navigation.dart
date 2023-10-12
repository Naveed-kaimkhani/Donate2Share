import 'package:donation_app/presentation/chatting_screen.dart';
import 'package:donation_app/presentation/donar%20screens/donar_setting.dart';
import 'package:donation_app/presentation/rider/completed_rides.dart';
import 'package:donation_app/presentation/rider/rider_homepage.dart';
import 'package:donation_app/presentation/rider/rider_setting.dart';
import 'package:donation_app/style/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

class RiderNavigation extends StatefulWidget {
  const RiderNavigation({Key? key}) : super(key: key);
  @override
  State<RiderNavigation> createState() => _RiderNavigationState();
}

class _RiderNavigationState extends State<RiderNavigation> {
  List pages = [
    const RiderHomePage(),
    const CompletedRides(),
    const ChattingScreen(),
    const RiderSetting(),
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const RiderHomePage();
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
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const RiderHomePage();
                    currentindex = 0;
                  });
                },
                child: Image.asset(
                  Images.home,
                  height: 26.h,
                  width: 26.w,
                  color: currentindex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              MaterialButton(
                minWidth: 40.w,
                onPressed: () {
                  setState(() {
                    currentScreen = const CompletedRides();
                    currentindex = 1;
                  });
                },
                child: Icon(
                  size: 26.h,
                  Icons.done_all,
                  color: currentindex == 1 ? Colors.white : Colors.grey,
                ),
              ),
              MaterialButton(
                minWidth: 40.w,
                onPressed: () {
                  setState(() {
                    currentScreen = const ChattingScreen();
                    currentindex = 2;
                  });
                },
                child: Icon(
                  size: 26.h,
                  Icons.chat,
                  color: currentindex == 2 ? Colors.white : Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        setState(() {
                          currentScreen = const RiderSetting();
                          currentindex = 3;
                        });
                      },
                      child: Icon(
                        size: 26.h,
                        Icons.settings_outlined,
                        color: currentindex == 3 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
