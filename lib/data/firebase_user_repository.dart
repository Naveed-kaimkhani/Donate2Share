import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../domain/models/donation_model.dart';
import '../domain/models/seller_model.dart';
import '../domain/models/user_model.dart';
import '../providers/seller_provider.dart';
import '../providers/user_provider.dart';
import 'notification_services.dart';


class FirebaseUserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection('NGOs');
  static final CollectionReference _sellerCollection =
      firestore.collection('donars');
  final Reference _storageReference = FirebaseStorage.instance.ref();
  NotificationServices _notificationServices = NotificationServices();
 
  Future<User?> login(String email, String password, context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      utils.flushBarErrorMessage("Invalid email or password", context);
    }
  }

  Future<Position?> getUserCurrentLocation(context) async {
    try {
      await Geolocator.requestPermission();
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Location Permission Required"),
              content: const Text(
                "Please enable location permission from the app settings to access your current location.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
      return await Geolocator.getCurrentPosition();
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      return null; // or throw the error
    }
  }

  loadSellerDataOnAppInit(context) async {
    try {
      

      await Provider.of<SellerProvider>(context, listen: false)
          .getSellerFromServer(context);


      // Navigate to the home screen after loading the data
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }

  loadUserDataOnAppInit(context) async {
    try {
      

      await Provider.of<UserProvider>(context, listen: false)
          .getUserFromServer(context);


      // Navigate to the home screen after loading the data
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }
  
  @override
  Future<SellerModel?> getSellerDetails() async {
    DocumentSnapshot documentSnapshot =
        await _sellerCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      SellerModel seller =
          SellerModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return seller;
    }
    return null;

    // else {
    //   // utils.flushBarErrorMessage("User not found", context)
    //   utils.toastMessage("No user found");
    //   Navigator.push
    // }
  }

  Future<UserModel?> getUser() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    // var response = await http.get(url);
    // var list = jsonDecode(response.body) as List;
    // return list.map((e) => UserJson.fromJson(e).toDomain()).toList();
    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      UserModel? userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      if (userModel != null) {
        return userModel;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<SellerModel?> getSeller() async {
    DocumentSnapshot documentSnapshot =
        await _sellerCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      SellerModel? sellerModel =
          SellerModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      if (sellerModel != null) {
        return sellerModel;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<User?> signUpUser(String email, String password, context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      utils.flushBarErrorMessage(error.message.toString(), context);
    }
    return null;
  }

  Future<void> saveUserDataToFirestore(UserModel userModel) async {
    await _userCollection.doc(userModel.uid).set(userModel.toMap(userModel));
  }

  Future<void> saveSellerDataToFirestore(SellerModel sellerModel) async {
    await _sellerCollection
        .doc(sellerModel.uid)
        .set(sellerModel.toMap(sellerModel));
  }

  Future<String> uploadProfileImage(
      {required Uint8List? imageFile, required String uid}) async {
    await _storageReference
        .child('profile_images')
        .child(uid)
        .putData(imageFile!);
    String downloadURL =
        await _storageReference.child('profile_images/$uid').getDownloadURL();
  print("uploaded");
    return downloadURL;
 
  }

  Future<void> addlatLongToFirebaseDocument(
    double lat,
    double long,
    String address,
    String? refreshedToken,
    String documentName,
  ) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection(documentName)
          .doc(utils.currentUserUid);

      if (refreshedToken == null) {
        await userRef.update({
          'lat': lat,
          'long': long,
          'address': address,
        });
      } else {
        await userRef.update({
          'lat': lat,
          'long': long,
          'address': address,
          'deviceToken': refreshedToken,
        });
      }
    } catch (e) {
      utils.toastMessage(e.toString());
    }
  }

  Future<void> loadDonarDataOnAppInit(context) async {
    try {
      String? refreshedToken = await _notificationServices.isTokenRefresh();
     
      await Provider.of<SellerProvider>(context, listen: false)
          .getSellerFromServer(context);

      // Navigate to the home screen after loading the data
    } catch (error) {
      utils.flushBarErrorMessage(error.toString(), context);
      // Handle error if any
    }
  }

  static Future<void> _saveDonatinoModelToFirestore(
    DonationModel donationModel,
    context,
  ) async {
    try {
      for (SellerModel seller in sellers) {
        final DocumentReference requestRef = await _sellerCollection
            .doc(seller.uid)
            .collection('Request')
            .add(DonationModel.toMap(DonationModel));

        final String documentId = requestRef.id;

        await requestRef.update({'documentId': documentId});
      }

      // utils.toastMessage("Request Sent");
    } catch (error) {
      // Handle the error appropriately
      utils.flushBarErrorMessage('Error sending request: $error', context);
      throw FirebaseException(
        plugin: 'FirebaseUserRepository',
        message: 'Failed to send request to sellers.',
      );
    }
  }


}