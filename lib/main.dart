
import 'package:donation_app/presentation/donar%20screens/donar_signup.dart';
import 'package:donation_app/presentation/donar%20screens/donate_food.dart';
import 'package:donation_app/presentation/splash_screen.dart';
import 'package:donation_app/providers/seller_provider.dart';
import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/utils/dialogues/donation_done_dialogue.dart';
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

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SellerProvider()),
          ],
          child: MaterialApp(
            title: 'Donate2Share',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:DonateFood(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
          
        );
      },
      // child:

    );
  }
}
