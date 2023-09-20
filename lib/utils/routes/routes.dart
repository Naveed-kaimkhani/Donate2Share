import 'package:donation_app/presentation/NGO%20screens/ngo_login.dart';
import 'package:donation_app/presentation/NGO%20screens/ngo_singup.dart';
import 'package:donation_app/presentation/donar%20screens/donar_signup.dart';
import 'package:donation_app/presentation/donar%20screens/donate_clothes.dart';
import 'package:donation_app/presentation/donar%20screens/donate_food.dart';
import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/rider/rider_signup.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.ngoLogin:
        return _buildRoute(const NGOLogin(), settings);
      case RoutesName.ngoSignup:
        return _buildRoute(const NGOSignUp(), settings);
      case RoutesName.riderSignUp:
        return _buildRoute(const RiderSignUp(), settings);

      case RoutesName.donateFood:
        return _buildRoute(const DonateFood(), settings);
      case RoutesName.donarSignup:
        return _buildRoute(
            const DonarSignup(
              addedByAdmin: false,
            ),
            settings);

      case RoutesName.donateClothes:
        return _buildRoute(const Donateclotheses(), settings);

      // case RoutesName.trackDonation:
      //   return _buildRoute( TrackDonation(), settings);

      // case RoutesName.userSingup:
      //   return _buildRoute(const UserSignup(), settings);

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
