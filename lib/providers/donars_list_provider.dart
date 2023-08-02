import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../data/firebase_user_repository.dart';
import '../domain/models/seller_model.dart';
import '../utils/storage_services.dart';

class DonarsListProvider with ChangeNotifier {
  List<SellerModel>? _donars;
  List<SellerModel>? _individualDonars;

  List<SellerModel>? _restaurantDonars;

  List<SellerModel>? _organizationDonars;

  List<SellerModel>? get donars => _donars;

  List<SellerModel>? get getIndividualdonars => _individualDonars;

  List<SellerModel>? get getOrganizationdonars => _organizationDonars;

  List<SellerModel>? get getrestaurantdonars => _restaurantDonars;
  int? individualListLenght;
  int? restaurentListLenght;

  Future getDonarsList(context) async {
    // final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    _donars = await FirebaseUserRepository.getConnectedDonars(context);
    if (_donars == null) {
      utils.flushBarErrorMessage("No user found", context);
    }
    notifyListeners();
  }

  filterDonars(context) {
    // final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    _individualDonars = utils.filterDonars(_donars!, "Individual");
    _organizationDonars = utils.filterDonars(_donars!, "Organization");
    _restaurantDonars = utils.filterDonars(_donars!, "Restaurant");
    // if (_individualDonars.isEmpty && _organizationDonars && _restaurantDonars == null) {
    //   utils.flushBarErrorMessage("No user found", context);
    // }
    individualListLenght = _individualDonars!.length;
    restaurentListLenght = _restaurantDonars!.length;
    notifyListeners();
  }

  Future deleteDonar(String uid, String type, context) async {
    // final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    await FirebaseUserRepository.deleteSellerDataFromFirestore(uid);
    if (type == "Individual") {
      _individualDonars?.removeWhere((seller) => seller.uid == uid);
      individualListLenght = individualListLenght! - 1;
      // individualListLenght!--;
    } else if (type == "Organization") {
      _organizationDonars?.removeWhere((seller) => seller.uid == uid);
    } else if (type == "Restaurant") {
      _restaurantDonars?.removeWhere((seller) => seller.uid == uid);
      restaurentListLenght = restaurentListLenght! - 1;
    }
    notifyListeners();
  }
}
