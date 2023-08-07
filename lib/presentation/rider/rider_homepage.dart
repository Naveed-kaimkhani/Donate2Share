// import 'package:donation_app/presentation/widgets/donar_details_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../domain/models/seller_model.dart';
// import '../../providers/donars_list_provider.dart';
// import '../../providers/rider_provider.dart';
// import '../donar screens/no_data_found.dart';
// import '../widgets/add_donar_button.dart';
// import '../widgets/all_donars_screen_header.dart';

// class RiderHomePage extends StatelessWidget {
//   const RiderHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//    SellerModel? rider =
//         Provider.of<RiderProvider>(context, listen: false)
//             .rider;
//     return SafeArea(
//         child: Scaffold(
//       floatingActionButton: const AddNewDonarButton(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AllDonarsScreenHeader(
//               header: "Deliveries",
//               subHeader: "Donars",
//             ),
//     SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     // width: MediaQuery.of(context).size.width,
//                     child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: allDonars.length,
//                         itemBuilder: (context, index) {
//                           return DonarsDetailsWidget(
//                             // name: allDonars[index].name!,
//                             // phone: allDonars[index].phone!,
//                             // url: allDonars[index].profileImage!,
//                             // address: allDonars[index].address!,
//                             // uid: allDonars[index].uid!,
//                             donar: allDonars[index],
//                           );
//                         }))
//           ],
//         ),
//       ),
//     ));
//   }
// }
