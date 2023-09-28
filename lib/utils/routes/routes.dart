import 'package:donation_app/presentation/NGO%20screens/ngo_change_password.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_login.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_singup.dart';
import 'package:donation_app/presentation/NGO%20screens/update_ngo_profile.dart';
import 'package:donation_app/presentation/about_us.dart';
import 'package:donation_app/presentation/contact_us.dart';
import 'package:donation_app/presentation/donar%20screens/donar_change_password.dart';
import 'package:donation_app/presentation/donar%20screens/donar_signup.dart';
import 'package:donation_app/presentation/donar%20screens/donate_clothes.dart';
import 'package:donation_app/presentation/donar%20screens/donate_food.dart';
import 'package:donation_app/presentation/privacy_policy_screen.dart';
import 'package:donation_app/presentation/rider/rider_signup.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../presentation/donar screens/donar_login.dart';
import '../../presentation/donar screens/update_donar_profile.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.ngoLogin:
        return _buildRoute(const NGOLogin(), settings);
      case RoutesName.donarLogin:
        return _buildRoute(const DonarLogin(), settings);
      case RoutesName.ngoSignup:
        return _buildRoute(const NGOSignUp(), settings);
      case RoutesName.riderSignUp:
        return _buildRoute(const RiderSignUp(), settings);
      case RoutesName.donateFood:
        return _buildRoute(const DonateFood(), settings);
      case RoutesName.updateNGOProfile:
        return _buildRoute(UpdateNGoProfile(), settings);
      case RoutesName.updateDonarProfile:
        return _buildRoute(UpdateDonarProfile(), settings);

      case RoutesName.donarSignup:
        return _buildRoute(
            const DonarSignup(
              addedByAdmin: false,
            ),
            settings);
      case RoutesName.donarChangePassword:
        return _buildRoute(const DonarChangePassword(), settings);

      case RoutesName.donateClothes:
        return _buildRoute(const Donateclotheses(), settings);
      case RoutesName.ngoChangePassword:
        return _buildRoute(const NgoChangePassword(), settings);
      case RoutesName.contactUs:
        return _buildRoute(ContactUs(), settings);
      case RoutesName.privacyPolicyScreen:
        return _buildRoute(const PrivacyPolicyScreen(), settings);
      case RoutesName.aboutUs:
        return _buildRoute(AboutUs(), settings);

      // case RoutesName.sellerSignup:
      //   return _buildRoute(const SellerSignUp(), settings);

      // case RoutesName.userLogin:
      //   return _buildRoute(const UserLogin(), settings);

      // case RoutesName.petrolProviders:
      //   return _buildRoute(const PetrolProviders(), settings);

      // case RoutesName.generalMechanic:
      //   return _buildRoute(const GeneralMechanic(), settings);

      // case RoutesName.punctureMaker:
      //   return _buildRoute(const PunctureMaker(), settings);
      default:
        return _buildRoute(
            const Scaffold(
              body: Center(
                child: Text("NO Route Found"),
              ),
            ),
            settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
