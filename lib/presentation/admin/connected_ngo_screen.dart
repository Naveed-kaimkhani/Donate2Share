import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/user_model.dart';
import '../../providers/ngos_list_provider.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/all_donars_screen_header.dart';
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
                backButton: true,
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
                        donar: donars[index],
                       
                      );
                    }))
          ],
        ),
      ),
    ));
  }
}
