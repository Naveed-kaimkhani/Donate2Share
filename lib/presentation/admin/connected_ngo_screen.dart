import 'package:donation_app/presentation/widgets/appbar_back_button.dart';
import 'package:donation_app/presentation/widgets/auth_header.dart';
import 'package:donation_app/presentation/widgets/donars_details_widget.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/seller_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/ngos_list_provider.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/donar_details_widget.dart';
import '../widgets/ngo_details_widget.dart';

class ConnectedNGOScreen extends StatelessWidget {
//  final List<UserModel> donars;
const  ConnectedNGOScreen({ super.key});

  @override
  Widget build(BuildContext context) {

   List<UserModel>? donars = Provider.of<NgoListProvider>(context, listen: false).ngos;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AllDonarsScreenHeader(
              header: "Connected",
              subHeader: "NGOs",
            ),
           donars!.isEmpty
                ? const NoDataFoundScreen(text: "No NGOs Found")
                :  SizedBox(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: donars.length,
                    itemBuilder: (context, index) {
                      return NgoDetailsWidget(
                        // uid: donars[index].uid!,
                        // name: donars[index].name!,
                        // phone: donars[index].phone!,
                        // url: donars[index].profileImage!,
                        // address: donars[index].address!,
                        donar: donars[index],
                       
                      );
                    }))
          ],
        ),
      ),
    ));
  }
}
