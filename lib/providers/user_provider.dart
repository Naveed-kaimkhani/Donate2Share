
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../domain/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userDetails;
  UserModel? get user => _userDetails;


  Future getUserLocally() async {

    // _userDetails = await StorageService.readUser();
    notifyListeners();
  }


  
  Future getUserFromServer(context) async {
    final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
   _userDetails = await firebaseRepository.getUser();

    if (_userDetails == null) {
      utils.flushBarErrorMessage("No user found",context);
    }
    notifyListeners();
  }
}
