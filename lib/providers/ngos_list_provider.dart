import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../data/firebase_user_repository.dart';
import '../domain/models/seller_model.dart';
import '../domain/models/user_model.dart';
import '../utils/storage_services.dart';

class NgoListProvider with ChangeNotifier {
  List<UserModel>? _ngos;
  List<UserModel>? get ngos => _ngos;

  Future getNgoList(context) async {
    // final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    _ngos = await FirebaseUserRepository.getConnectedNgo(context);
    if (_ngos == null) {
      utils.flushBarErrorMessage("No ngo found", context);
    }
    notifyListeners();
  }

  Future deleteNgo(String uid, context) async {
    // final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    await FirebaseUserRepository.deleteSellerDataFromFirestore(uid);

    _ngos?.removeWhere((ngo) => ngo.uid == uid);
    notifyListeners();
  }
}
