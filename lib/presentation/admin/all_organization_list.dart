import 'package:donation_app/presentation/widgets/appbar_back_button.dart';
import 'package:donation_app/presentation/widgets/auth_header.dart';
import 'package:donation_app/presentation/widgets/donars_details_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/seller_model.dart';
import '../../providers/donars_list_provider.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/donar_details_widget.dart';

class AllOrganizations extends StatelessWidget {
//  final List<SellerModel> donars;
  const AllOrganizations({super.key});

  @override
  Widget build(BuildContext context) {
    List<SellerModel>? donars =
        Provider.of<DonarsListProvider>(context, listen: false)
            .getOrganizationdonars;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: const AddNewDonarButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AllDonarsScreenHeader(
              header: "Organization",
              subHeader: "Donars",
            ),
            donars!.isEmpty
                ? const NoDataFoundScreen(text: "No Donars Found")
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: donars.length,
                        itemBuilder: (context, index) {
                          return DonarsDetailsWidget(
                            // name: donars[index].name!,
                            // address: donars[index].address!,
                            // phone: donars[index].phone!,
                            // url: donars[index].profileImage!,
                            // uid: donars[index].uid!,
                            donar: donars[index],
                          );
                        }))
          ],
        ),
      ),
    ));
  }
}
