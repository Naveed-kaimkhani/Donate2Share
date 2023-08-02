import 'package:donation_app/presentation/donar%20screens/no_data_found.dart';
import 'package:donation_app/presentation/widgets/appbar_back_button.dart';
import 'package:donation_app/presentation/widgets/auth_header.dart';
import 'package:donation_app/presentation/widgets/donar_details_widget.dart';
import 'package:donation_app/presentation/widgets/donars_details_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/firebase_user_repository.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/donars_list_provider.dart';
import '../widgets/add_donar_button.dart';
import '../widgets/all_donars_screen_header.dart';

class AllIndividuals extends StatefulWidget {
  // final List<SellerModel> donars;
  const AllIndividuals({super.key});

  @override
  State<AllIndividuals> createState() => _AllIndividualsState();
}

class _AllIndividualsState extends State<AllIndividuals> {
  @override
  Widget build(BuildContext context) {
    List<SellerModel>? donars =
        Provider.of<DonarsListProvider>(context, listen: false)
            .getIndividualdonars;
    return SafeArea(
        child: Scaffold(
          
      floatingActionButton: const AddNewDonarButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AllDonarsScreenHeader(
              header: "Individual",
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
                            // name: widget.donars[index].name!,
                            // phone: widget.donars[index].phone!,
                            // uid: widget.donars[index].uid!,
                            // url: widget.donars[index].profileImage!,
                            // address: widget.donars[index].address!,
                            donar: donars[index],
                          );
                        }))
          ],
        ),
      ),
    ));
  }
}
