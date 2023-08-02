
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../domain/models/user_model.dart';

class DonarProvider with ChangeNotifier {
  UserModel? _userDetails;
 List<UserModel>? _allNgoDetails;
   
  UserModel? get ngo => _userDetails;

  List<UserModel>? get allNgoDetails => _allNgoDetails;

    final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();


  Future getUserFromServer(context) async {
   _userDetails = await firebaseRepository.getUser();

    if (_userDetails == null) {
      utils.flushBarErrorMessage("No user found",context);
    }
    notifyListeners();
  }
  

  
  Future getAllNgoFromServer(context) async {
   _allNgoDetails = await FirebaseUserRepository.getConnectedNgo(context);

    if (_allNgoDetails == null) {
      utils.flushBarErrorMessage("No user found",context);
    }
    notifyListeners();
  }
}
