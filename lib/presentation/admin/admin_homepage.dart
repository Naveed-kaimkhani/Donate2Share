import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/presentation/admin/all_individual_donars.dart';
import 'package:donation_app/presentation/admin/all_organization_list.dart';
import 'package:donation_app/presentation/admin/all_restuarant_list.dart';
import 'package:donation_app/presentation/admin/cloth_donation.dart';
import 'package:donation_app/presentation/admin/food_donations.dart';
import 'package:donation_app/presentation/widgets/connected_donars.dart';
import 'package:donation_app/presentation/widgets/connected_ngo_card.dart';
import 'package:donation_app/providers/ngos_list_provider.dart';
import 'package:donation_app/style/images.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/models/donation_model.dart';
import '../../domain/models/seller_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/donars_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../donar screens/no_data_found.dart';
import '../widgets/admin_home_card.dart';
import '../widgets/chart_widget.dart';
import '../widgets/connected_donars_card.dart';
import '../widgets/custom_divider.dart';
import '../widgets/ngo_card.dart';
import '../widgets/profile_pic.dart';
import '../widgets/wave_circle.dart';
import 'connected_ngo_screen.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<DonationModel> filterFoodDonations(List<DonationModel> donationList) {
    return donationList.where((donation) => donation.type == "food").toList();
  }

  List<DonationModel> filterCLothesDonations(List<DonationModel> donationList) {
    return donationList
        .where((donation) => donation.type == "clothes")
        .toList();
  }

  // List<Widget> connectedDonars=[]
  // List<SellerModel>? allDonars;
  List<SellerModel>? individualDonarsList;
  List<SellerModel>? restaurantList;
  List<SellerModel>? organizationList;
  List<DonationModel>? clotheList;
  List<DonationModel>? foodList;
  List<SellerModel>? allDonars;
  List<Widget>? donarCardList;
  List<UserModel>? NgoList;

  int? individualLenght;

  int? restaurentLenght;

  SizedBox k = SizedBox(
    height: 6.h,
  );
  getDonarCardList() {
    return [
      InkWell(
        child: ConnectedDonarsWidget(
          num: Provider.of<DonarsListProvider>(context, listen: false)
              .restaurentListLenght!,
          head: "Restaurants",
          subHead: "Donated",
          image: Images.rest,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllRestaurants(
                      // donars: restaurantList!,
                      )));
        },
      ),
      InkWell(
          child: ConnectedDonarsWidget(
            num: individualLenght!,
            head: "Individuals",
            subHead: "Donated",
            image: Images.individual,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllIndividuals(
                        // donars: individualDonarsList!,
                        )));
          }),
      InkWell(
        child: ConnectedDonarsWidget(
          num: organizationList!.length,
          head: "Organization",
          subHead: "Donated",
          image: Images.rest,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllOrganizations(
                      // donars: organizationList!,
                      )));
        },
      ),
    ];
  }

  // List<SellerModel> filterDonars(List<SellerModel> model, String type) {
  //   return model.where((seller) => seller.type == type).toList();
  // }

  getDonars() async {
    await Provider.of<DonarsListProvider>(context, listen: false)
        .getDonarsList(context);
    // allDonars = Provider.of<DonarsListProvider>(context, listen: false).donars;
    Provider.of<DonarsListProvider>(context, listen: false)
        .filterDonars(context);
    //  = filterDonars(allDonars!, "Restaurant");
    //  = filterDonars(allDonars!, "Organization");

    individualDonarsList =
        Provider.of<DonarsListProvider>(context, listen: false)
            .getIndividualdonars;
    organizationList = Provider.of<DonarsListProvider>(context, listen: false)
        .getOrganizationdonars;
    restaurantList = Provider.of<DonarsListProvider>(context, listen: false)
        .getrestaurantdonars;
    individualLenght = Provider.of<DonarsListProvider>(context, listen: false)
        .individualListLenght;

    restaurentLenght = Provider.of<DonarsListProvider>(context, listen: false)
        .restaurentListLenght;
    donarCardList = getDonarCardList();
  }

  getNgos() async {
    await Provider.of<NgoListProvider>(context, listen: false)
        .getNgoList(context);
    NgoList = Provider.of<NgoListProvider>(context, listen: false).ngos;
  }

  @override
  void initState() {
    super.initState();
    getDonars();
    getNgos();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? admin = Provider.of<AdminProvider>(context, listen: false).admin;
    // List<SellerModel>? individuals = Provider.of<DonarsListProvider>(context, listen: false).getIndividualdonars;
    // List<SellerModel>? organizations= Provider.of<DonarsListProvider>(context, listen: false).getOrganizationdonars;
    // List<SellerModel>? restaurants = Provider.of<DonarsListProvider>(context, listen: false).getrestaurantdonars;

    // List<SellerModel>? donars = Provider.of<DonarsListProvider>(context, listen: false).donars;
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<List<DonationModel>>(
        stream: FirebaseUserRepository.getDonationList(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaveCircleProgress();
            // return SizedBox();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const NoDataFoundScreen(
              text: "No Donation",
            );
          } else {
            foodList = filterFoodDonations(snapshot.data!);
            clotheList = filterCLothesDonations(snapshot.data!);
            return Padding(
              padding: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome To Admin Panel',
                        style: CustomTextStyle.font_14_black,
                      ),
                      Text(admin!.name ?? "No Name",
                          style: CustomTextStyle.font_24_primaryColor),

                      k,
                      k,
                      Container(
                        width: 290.w,
                        height: 135.h,
                        decoration: chardecoration(),
                        child: ChartWidget(
                          chartData: FirebaseUserRepository.getMonthlyDonation(
                              snapshot.data!,),
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        'Available Donation',
                        style: CustomTextStyle.font_24,
                      ),
                      k,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdminHomeCard(
                            donation: foodList!.length,
                            name: "Food",
                            unit: "kilogram",
                            image: Images.foodpic,
                            padding: 72.w,
                            func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodDonations(
                                            foodList: foodList ?? [],
                                          )));
                            },
                          ),
                          AdminHomeCard(
                            donation: clotheList!.length,
                            name: "Clothes",
                            unit: "Dress",
                            image: Images.clothpic,
                            padding: 95.w,
                            func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => clothDonations(
                                            clothList: clotheList ?? [],
                                          )));
                            },
                          ),
                        ],
                      ),
                      k,

                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: const CustomDivider(),
                      ),
                      k,
                      Text(
                        'Connected Donars',
                        style: CustomTextStyle.font_24,
                      ),

                      ConnectedDonars(donarCardList: donarCardList),
                      const CustomDivider(),
                      k,

                      k,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Connected NGOs',
                            style: CustomTextStyle.font_24,
                          ),
                          InkWell(
                              child: Text(
                                'see all',
                                style: CustomTextStyle.font_14_black,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConnectedNGOScreen()));
                              }),
                        ],
                      ),
                      k,
                      // connectedNGOs(context),
                      const ConnectedNGOCard()
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    ));
  }

  BoxDecoration chardecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff326060),
          width: 1,
        ));
  }
}
