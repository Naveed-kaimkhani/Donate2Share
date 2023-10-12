import 'dart:async';
import 'package:donation_app/presentation/admin/admin_login.dart';
import 'package:donation_app/presentation/admin/admin_navigation.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../providers/admin_provider.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class AdminSplash  extends StatefulWidget {
  const AdminSplash({super.key});

  @override
  _AdminSplashState createState() => _AdminSplashState();
}

class _AdminSplashState extends State<AdminSplash> {
  // NotificationServices _notificationServices =NotificationServices();
  
  @override
  void initState() {
    // _notificationServices.requestNotificationPermission();
    // _notificationServices.firebaseInit(context);
    // _notificationServices.isTokenRefresh();
    // _notificationServices.setupInteractMessage(context);
    // _notificationServices.getDeviceToken().then((value)
    // {
    // });
    utils.checkConnectivity(context);
 
    Timer(const Duration(seconds: 2), () {
      loadData();
    });
    super.initState();
  }

  loadData() async {
    User? user = utils.getCurrentUser();

    try {
      
      if (user != null) {
                await Provider.of<AdminProvider>(context, listen: false)
              .getAdminFromServer(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminNavigation()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminLogin()),
        );
      }
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250.w,
            ),
            Image.asset(
              Images.logo,
              height: 180.h,
              width: 180.w,
            ),
            SizedBox(
              height: 230.w,
            ),
            const Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SpinKitSpinningLines(
                color: Styling.primaryColor,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
