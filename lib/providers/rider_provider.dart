
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import '../data/firebase_user_repository.dart';
import '../domain/models/seller_model.dart';
class RiderProvider with ChangeNotifier {
  SellerModel? _riderDetails;
  SellerModel? get rider => _riderDetails;
  Future getRiderFromServer(context) async {
    final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    _riderDetails = await firebaseRepository.getRiderDetails();
    if (_riderDetails == null) {
      utils.flushBarErrorMessage("No user found",context);
    }
    notifyListeners();
  }
}
