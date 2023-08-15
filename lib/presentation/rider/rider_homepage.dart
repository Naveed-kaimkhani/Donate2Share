import 'package:donation_app/domain/models/donation_ngo_model.dart';
import 'package:donation_app/presentation/donar%20screens/track_donation.dart';
import 'package:donation_app/presentation/widgets/donar_details_widget.dart';
import 'package:donation_app/presentation/widgets/tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/models/request_model.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/donars_list_provider.dart';
import '../../providers/rider_provider.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/donation_widget.dart';
import '../widgets/wave_circle.dart';

class RiderHomePage extends StatelessWidget {
  const RiderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SellerModel? rider =
        Provider.of<RiderProvider>(context, listen: false).rider;
    return SafeArea(
        child: Scaffold(
      body: Container()
    ));
  }
}
