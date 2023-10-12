import 'package:donation_app/presentation/rider/rider_splash.dart';
import 'package:donation_app/presentation/splash_screen.dart';
import 'package:donation_app/providers/admin_provider.dart';
import 'package:donation_app/providers/donars_list_provider.dart';
import 'package:donation_app/providers/ngos_list_provider.dart';
import 'package:donation_app/providers/rider_provider.dart';
import 'package:donation_app/providers/seller_provider.dart';
import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    // List<GraphDots> points = [GraphDots(x: 1, y: 2)];
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SellerProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => AdminProvider()),
            ChangeNotifierProvider(create: (_) => DonarsListProvider()),
            ChangeNotifierProvider(create: (_) => NgoListProvider()),
            ChangeNotifierProvider(create: (_) => RiderProvider()),
          ],
          child: MaterialApp(
            title: 'Donate2Share',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      },
      // child:
    );
  }
}
