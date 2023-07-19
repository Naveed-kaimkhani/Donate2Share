import 'package:donation_app/presentation/NGO%20screens/ngo_navigation_page.dart';
import 'package:donation_app/presentation/donarORngo_screen.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../data/firebase_user_repository.dart';
import '../style/images.dart';
import '../style/styling.dart';
import '../utils/storage_services.dart';
import 'donar screens/donar_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  // NotificationServices _notificationServices =NotificationServices();
  // @override
  // void initState() {
  //   _notificationServices.requestNotificationPermission();
  //   _notificationServices.firebaseInit(context);
  //   _notificationServices.isTokenRefresh();
  //   _notificationServices.setupInteractMessage(context);
  //   _notificationServices.getDeviceToken().then((value)
  //   {
  //   });
  //   utils.checkConnectivity(context);

  //   Timer(const Duration(seconds: 2), () {
  //   loadData();
  // });
  // super.initState();
  // }

  loadData() async {
    User? user = utils.getCurrentUser();
    int? isUser = await StorageService.checkUserInitialization();

    try {
      if (user != null) {
        if (isUser == 1 && isUser != null) {
          await _firebaseUserRepository.loadUserDataOnAppInit(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NGONavigationpage()),
          );
        } else {
          await _firebaseUserRepository.loadSellerDataOnAppInit(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DonarNavigation()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DonarOrSellerScreeen()),
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
