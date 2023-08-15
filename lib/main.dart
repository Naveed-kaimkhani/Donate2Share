import 'package:donation_app/presentation/NGO%20screens/ngo_homepage.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_login.dart';
import 'package:donation_app/presentation/NGO%20screens/test.dart';
import 'package:donation_app/presentation/admin/admin_login.dart';
import 'package:donation_app/presentation/admin/admin_signup.dart';
import 'package:donation_app/presentation/donar%20screens/donar_homepage.dart';
import 'package:donation_app/presentation/donar%20screens/donar_login.dart';
import 'package:donation_app/presentation/donar%20screens/donar_navigation.dart';
import 'package:donation_app/presentation/donar%20screens/donar_signup.dart';
import 'package:donation_app/presentation/donar%20screens/donate_clothes.dart';
import 'package:donation_app/presentation/rider/rider_homepage.dart';
import 'package:donation_app/presentation/rider/rider_login.dart';
import 'package:donation_app/presentation/rider/rider_signup.dart';
import 'package:donation_app/presentation/widgets/ngo_home_header.dart';
import 'package:donation_app/providers/admin_provider.dart';
import 'package:donation_app/providers/donars_list_provider.dart';
import 'package:donation_app/providers/ngos_list_provider.dart';
import 'package:donation_app/providers/rider_provider.dart';
import 'package:donation_app/providers/seller_provider.dart';
import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// GetIt getIt = GetIt.instance;
late Size mq;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print(message.notification!.title);
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // getIt.registerLazySingleton<UsersRepository>(() => FirebaseUserRepository());
  runApp(
      // // MultiProvider(
      // //   providers: [
      // //     ChangeNotifierProvider(
      // //       create: (_) =>
      // //           UserProvider(usersRepository: getIt())..getUser(),
      // //     ),
      // //   ],
      //   child: const MyApp(),
      // ),
      const MyApp());
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
            // home:DonarHomePage(),

            home: AdminLogin(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      },
      // child:
    );
  }
}
