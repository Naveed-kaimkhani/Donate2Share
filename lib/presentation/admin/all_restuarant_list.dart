import 'package:donation_app/presentation/widgets/appbar_back_button.dart';
import 'package:donation_app/presentation/widgets/auth_header.dart';
import 'package:donation_app/presentation/widgets/donar_details_widget.dart';
import 'package:donation_app/presentation/widgets/donars_details_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/models/seller_model.dart';
import '../../providers/donars_list_provider.dart';
import '../../style/styling.dart';
import '../donar screens/donar_signup.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';

class AllRestaurants extends StatelessWidget {
  // List<SellerModel> donars;
  const AllRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    List<SellerModel>? allDonars =
        Provider.of<DonarsListProvider>(context, listen: false)
            .getrestaurantdonars;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: const AddNewDonarButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AllDonarsScreenHeader(
              header: "Restaurant",
              subHeader: "Donars",
            ),
            allDonars!.isEmpty
                ? const NoDataFoundScreen(text: "No Donars Found")
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: allDonars.length,
                        itemBuilder: (context, index) {
                          return DonarsDetailsWidget(
                            // name: allDonars[index].name!,
                            // phone: allDonars[index].phone!,
                            // url: allDonars[index].profileImage!,
                            // address: allDonars[index].address!,
                            // uid: allDonars[index].uid!,
                            donar: allDonars[index],
                          );
                        }))
          ],
        ),
      ),
    ));
  }
}
