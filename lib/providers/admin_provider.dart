
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../data/firebase_user_repository.dart';
import '../domain/models/seller_model.dart';
import '../domain/models/user_model.dart';
import '../utils/storage_services.dart';

class AdminProvider with ChangeNotifier {
  UserModel? _adminDetails;
  UserModel? get admin => _adminDetails;


  Future getAdminFromServer(context) async {
    final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
    _adminDetails = await firebaseRepository.getAdmin();
    if (_adminDetails == null) {
      utils.flushBarErrorMessage("No admin found",context);
    }
    notifyListeners();
  }
}
