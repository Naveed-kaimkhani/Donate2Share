import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/utils/dialogues/donation_done_popUp.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../domain/models/donation_data.dart';
import '../domain/models/donation_model.dart';
import '../domain/models/donation_ngo_model.dart';
import '../domain/models/request_model.dart';
import '../domain/models/seller_model.dart';
import '../domain/models/user_model.dart';
import '../providers/admin_provider.dart';
import '../providers/donars_list_provider.dart';
import '../providers/seller_provider.dart';
import '../providers/user_provider.dart';
import '../utils/dialogues/custom_loader.dart';
import 'notification_services.dart';

class FirebaseUserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection('NGOs');
  static final CollectionReference _sellerCollection =
      firestore.collection('donars');

  static final CollectionReference _riderCollection =
      firestore.collection('riders');

  static final CollectionReference _adminCollection =
      firestore.collection('admin');
  static final Reference _storageReference = FirebaseStorage.instance.ref();
  NotificationServices _notificationServices = NotificationServices();

  static final CollectionReference _requestsCollection =
      FirebaseFirestore.instance.collection('requests');
  static final CollectionReference _donationCollection =
      firestore.collection("donations");
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

  static Future<void> assignRider(
    // List<SellerModel> sellers,
    DonationNgoModel rideDetails,
    context,
  ) async {
    try {
      final DocumentReference requestRef = await _riderCollection
          .doc('A9V29ab9F1f1zoHDMm4IebbfIzk1')
          .collection('rides')
          .add(rideDetails.toMap(rideDetails));

      //for testing purpose. just trying to store documents ids to fetch their data on rider side
      var data = Map<String, dynamic>();
      data['donationDocument'] = rideDetails.donationDocumentId;
      data['ngoUid'] = rideDetails.ngoUid;
      final DocumentReference Ref = await _riderCollection
          .doc('A9V29ab9F1f1zoHDMm4IebbfIzk1')
          .collection('rides')
          .add(data);

      final String documentId = requestRef.id;

      await requestRef.update({'documentId': documentId});

      utils.toastMessage("Request Sent");
    } catch (error) {
      // Handle the error appropriately
      utils.flushBarErrorMessage('Error sending request: $error', context);
      throw FirebaseException(
        plugin: 'FirebaseUserRepository',
        message: 'Failed to send request to sellers.',
      );
    }
  }

  Future<UserModel?> getAdmin() async {
    QuerySnapshot querySnapshot = await _adminCollection.limit(1).get();
    if (querySnapshot.docs.isNotEmpty) {
      UserModel? userModel = UserModel.fromMap(
          querySnapshot.docs[0].data() as Map<String, dynamic>);
      return userModel;
    } else {
      return null;
    }
  }

  Future<Position?> getUserCurrentLocation(context) async {
    try {
      print("inside getUser");
      await Geolocator.requestPermission();
      var permission = await Geolocator.checkPermission();
      print(permission);
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

  loadDonarDataOnAppInit(context) async {
    try {
      await Provider.of<SellerProvider>(context, listen: false)
          .getSellerFromServer(context);

      await Provider.of<AdminProvider>(context, listen: false)
          .getAdminFromServer(context);

      await Provider.of<UserProvider>(context, listen: false)
          .getAllNgoFromServer(context);

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

  // Future<SellerModel?> getSeller() async {
  //   DocumentSnapshot documentSnapshot =
  //       await _sellerCollection.doc(utils.currentUserUid).get();
  //   if (documentSnapshot.data() != null) {
  //     SellerModel? sellerModel =
  //         SellerModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  //     if (sellerModel != null) {
  //       return sellerModel;
  //     } else {
  //       return null;
  //     }
  //   }
  //   return null;
  // }
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
  }

  @override
  Future<SellerModel?> getRiderDetails() async {
    DocumentSnapshot documentSnapshot =
        await _riderCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      SellerModel seller =
          SellerModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return seller;
    }
    return null;
  }
static Stream<SellerModel?> getRiderStream() {
  return _riderCollection.doc('A9V29ab9F1f1zoHDMm4IebbfIzk1').snapshots().map((documentSnapshot) {
    if (documentSnapshot.exists) {
      return SellerModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  });
}

  static List<DonationData> getMonthlyDonation(List<DonationModel> donations) {
    // Create a map to store donations for each month
    Map<String, double> monthlyDonations = {};

    // Loop through each donation
    for (DonationModel donation in donations) {
      // Extract the month from the DonationModel object
      String month = donation.month!;

      // Check if the month is already a key in the map
      if (monthlyDonations.containsKey(month)) {
        // If the month is already a key, add the current donation amount to its value
        monthlyDonations[month] = (monthlyDonations[month] ?? 0) + 1;
      } else {
        // If the month is not a key, create a new entry with the current donation amount
        monthlyDonations[month] = 1;
      }
    }

    // Convert the map to a list of DonationData objects
    List<DonationData> monthlyDonationData =
        monthlyDonations.entries.map((entry) {
      return DonationData(month: entry.key, donation: entry.value);
    }).toList();

    return monthlyDonationData;
  }

  Future<UserModel?> getAdminDetails() async {
    DocumentSnapshot documentSnapshot =
        await _adminCollection.doc(utils.currentUserUid).get();
    if (documentSnapshot.data() != null) {
      UserModel seller =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
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

  static Future<List<UserModel>> getAllAdmin(context) async {
    List<UserModel> adminList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("admin").get();
      adminList = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching Ngos: $e', context);
      // print('Error fetching donations: $e');
    }
    return adminList;
  }

  static Future<UserModel?> getFirstAdmin(context) async {
    List<UserModel> adminList = await getAllAdmin(context);
    if (adminList.isNotEmpty) {
      return adminList[0];
    } else {
      return null;
    }
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

  static Future<void> sendRequestToAdminForDonation(
      RequestModel model, context) async {
    try {
      LoaderOverlay.show(context);
      // Access the Firestore collection reference where you want to save the request
      CollectionReference requestCollection =
          FirebaseFirestore.instance.collection('requests');
      final DocumentReference requestRef =
          await requestCollection.add(model.toMap(model));
      final String documentId = requestRef.id;

      await requestRef.update({'documentId': documentId});
      // Successfully saved the request to Firestore
      LoaderOverlay.hide();
    } catch (error) {
      LoaderOverlay.hide();
      // Handle any errors that may occur during the save process
      // print('Error saving request: $error');
      utils.flushBarErrorMessage('Error sending request: $error', context);
    }
  }

  Future<void> saveAdminDataToFirestore(UserModel userModel) async {
    await _adminCollection.doc(userModel.uid).set(userModel.toMap(userModel));
  }

  Future<void> saveSellerDataToFirestore(SellerModel sellerModel) async {
    await _sellerCollection
        .doc(sellerModel.uid)
        .set(sellerModel.toMap(sellerModel));
  }

  Future<void> saveRiderDataToFirestore(SellerModel sellerModel) async {
    await _riderCollection
        .doc(sellerModel.uid)
        .set(sellerModel.toMap(sellerModel));
  }

  static Future<void> deleteSellerDataFromFirestore(String uid) async {
    await _sellerCollection.doc(uid).delete();
  }

  Future<String> uploadProfileImage(
      {required Uint8List? imageFile, required String uid}) async {
    await _storageReference
        .child('profile_images')
        .child(uid)
        .putData(imageFile!);
    String downloadURL =
        await _storageReference.child('profile_images/$uid').getDownloadURL();
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

  // Future<void> loadDonarDataOnAppInit(context) async {
  //   try {
  //     String? refreshedToken = await _notificationServices.isTokenRefresh();

  //     await Provider.of<SellerProvider>(context, listen: false)
  //         .getSellerFromServer(context);

  //     // Navigate to the home screen after loading the data
  //   } catch (error) {
  //     utils.flushBarErrorMessage(error.toString(), context);
  //     // Handle error if any
  //   }
  // }

  static Future<void> saveDonationModelToFirestore(
      DonationModel donation, context) async {
    try {
      // Reference to the "donations" collection
      CollectionReference donationsCollection =
          FirebaseFirestore.instance.collection('donations');

      // Convert the donationModel to a Map
      Map<String, dynamic> donationData = donation.toMap(donation);

      // Add the donation data as a new document in the "donations" collection
      DocumentReference newDonationRef =
          await donationsCollection.add(donationData);

      // Get the ID of the newly added document and store it in the donationData map
      String documentId = newDonationRef.id;
      donationData['documentId'] = documentId;

      // Update the document with the added document ID
      await newDonationRef.update(donationData);
      // utils.toastMessage('Donation stored successfully!');
      donationDonePopup(context, donation);
      // print('Donation stored successfully!');
    } catch (e) {
      utils.toastMessage('Error storing donation: $e');
      // print('Error storing donation: $e');
    }
  }

  static Future<List<String>> uploadDonationImage(
      {required List<XFile> imageFile, required String donationId}) async {
    int id = 1;
    List<String> listOfDonationImages = [];
    for (XFile element in imageFile) {
      XFile compressedImage = await utils.compressImage(element);
      final imageRef = _storageReference
          .child('donation_images')
          .child(utils.currentUserUid)
          // .child(DateTime.now().millisecondsSinceEpoch.toString())
          .child(donationId)
          .child(id.toString());

      await imageRef.putFile(File(compressedImage.path));

      String downloadURL = await imageRef.getDownloadURL();
      listOfDonationImages.add(downloadURL);
      id++;
    }

    return listOfDonationImages;
  }

  void storeDonation(DonationModel donation, context) async {
    try {
      // Reference to the "donations" collection
      CollectionReference donationsCollection =
          FirebaseFirestore.instance.collection('donations');

      // Convert the donationModel to a Map
      Map<String, dynamic> donationData = donation.toMap(donation);

      // Add the donation data as a new document in the "donations" collection
      DocumentReference newDonationRef =
          await donationsCollection.add(donationData);

      // Get the ID of the newly added document and store it in the donationData map
      String documentId = newDonationRef.id;
      donationData['documentId'] = documentId;

      // Update the document with the added document ID
      await newDonationRef.update(donationData);

      print('Donation stored successfully!');
    } catch (e) {
      print('Error storing donation: $e');
    }
  }

  static Stream<List<DonationModel>> getDonationList(context) async* {
    List<DonationModel> donationList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("donations").get();
      donationList = querySnapshot.docs.map((doc) {
        return DonationModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
    }
    yield donationList;
  }

  static Stream<List<DonationNgoModel>> getAssignedRides(context) async* {
    try {
      final CollectionReference requestCollection = FirebaseFirestore.instance
          .collection("riders")
          .doc(utils.currentUserUid)
          .collection('rides');

      yield* requestCollection.snapshots().map((snapshot) {
        final List<DonationNgoModel> models = snapshot.docs
            .map((docsSnap) =>
                DonationNgoModel.fromMap(docsSnap.data() as dynamic))
            .toList();
        return models;
      });
    } catch (e) {
      // Handle any potential errors here
      utils.flushBarErrorMessage('Error fetching requests: $e', context);
      yield []; // Yield an empty list in case of an error
    }
  }

  static Stream<List<dynamic>> getDocumentDetails(
      String donationDocId, String reqDocId, context) async* {
    List<dynamic> documents = [];

    try {
      DocumentSnapshot donationSnapshot = await FirebaseFirestore.instance
          .collection("donations")
          .doc(donationDocId)
          .get();

      if (donationSnapshot.exists) {
        DonationModel donationModel = DonationModel.fromMap(
            donationSnapshot.data() as Map<String, dynamic>);
        documents.add(donationModel);
      }

      DocumentSnapshot requestSnapshot = await FirebaseFirestore.instance
          .collection("requests")
          .doc(reqDocId)
          .get();

      if (requestSnapshot.exists) {
        RequestModel requestModel = RequestModel.fromMap(
            requestSnapshot.data() as Map<String, dynamic>);
        documents.add(requestModel);
      }
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching documents: $e', context);
    }

    yield documents;
  }

  static Stream<List<RequestModel>> getDonationRequest(context) async* {
    List<RequestModel> donationList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("requests").get();
      donationList = querySnapshot.docs.map((doc) {
        return RequestModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching requests: $e', context);
    }
    yield donationList;
  }

  static Stream<List<RequestModel>> getDonationRequestForSpecificNgo(
      context) async* {
    List<RequestModel> donationList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("requests")
          .where('senderUid', isEqualTo: utils.currentUserUid)
          .get();
      donationList = querySnapshot.docs.map((doc) {
        return RequestModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching requests: $e', context);
    }
    yield donationList;
  }

  static Future<List<RequestModel>> getDonationRequestToAssignRider(
      String type, context) async {
    List<RequestModel> donationList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("requests")
          .where('status', isEqualTo: 'accepted')
          .where('donationType', isEqualTo: type)
          .get();
      donationList = querySnapshot.docs.map((doc) {
        return RequestModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching requests: $e', context);
    }

    return donationList;
  }

  static Future<List<DonationModel>> getDonations(context) async {
    List<DonationModel> donationList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("donations").get();
      donationList = querySnapshot.docs.map((doc) {
        return DonationModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
    }
    return donationList;
  }

  static Future<DonationModel?> getDonationByDocumentID(
      String documentID, context) async {
    DonationModel? donation;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("donations")
          .where('documentId', isEqualTo: documentID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        donation = DonationModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        utils.flushBarErrorMessage('Error fetching donation: $e', context);

        // Handle the case where the donation with the specified UID was not found.
        // You can display an error message or handle it according to your app's logic.
      }
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donation: $e', context);
    }

    return donation;
  }

  static Future<void> grantDonation(RequestModel request, context) async {
    try {
      LoaderOverlay.show(context);
      // Query the documents where 'quantity' is equal to the argument value
      QuerySnapshot querySnapshot = await _donationCollection
          .where('quantity', isGreaterThanOrEqualTo: request.quantity)
          .where('type', isEqualTo: request.donationType)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        int currentQuantity = documentSnapshot.get('quantity');
        if (currentQuantity == request.quantity!) {
          // If currentQuantity is equal to the argument value, set the quantity to zero
          await documentSnapshot.reference.update({'quantity': 0});
          break;
        } else if (currentQuantity > request.quantity!) {
          // Calculate the remaining quantity if currentQuantity is greater than the argument value
          int remainingQuantity = currentQuantity - request.quantity!;
          await documentSnapshot.reference.update({
            'quantity': remainingQuantity,
          });
          break;
        }
      }
      await updateRequestStatus(request.documentId!);
      LoaderOverlay.hide();
      utils.toastMessage("Request Accepted");
    } catch (error) {
      utils.flushBarErrorMessage(
          'Error updating donation quantity: $error', context);
      // print('Error updating donation quantity: $error');
    }
  }

  static Future<void> updateRequestStatus(String id) async {
    try {
      // Update the 'status' field of the document with the provided ID to "accepted"
      await _requestsCollection.doc(id).update({'status': 'accepted'});
    } catch (error) {
      print('Error updating request status: $error');
    }
  }

  static Future<List<SellerModel>> getConnectedDonars(context) async {
    List<SellerModel> donationList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("donars").get();
      donationList = querySnapshot.docs.map((doc) {
        return SellerModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
      // print('Error fetching donations: $e');
    }
    return donationList;
  }

  static Future<List<UserModel>> getConnectedNgo(context) async {
    List<UserModel> donationList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("NGOs").get();
      donationList = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching Ngos: $e', context);
      // print('Error fetching donations: $e');
    }
    return donationList;
  }

  static Stream<List<DonationModel>> getDonarDonations(context) async* {
    List<DonationModel> donationList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("donations")
          .where("donarUid", isEqualTo: utils.currentUserUid)
          .get();
      donationList = querySnapshot.docs.map((doc) {
        return DonationModel.fromMap(doc.data() as dynamic);
      }).toList();
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching donations: $e', context);
      // print('Error fetching donations: $e');
    }
    yield donationList;
  }

  static Future<DonationNgoModel?> fetchRidesByRiderId(
      String donationId, context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('riders') // Replace with your top-level collection name
          .doc('A9V29ab9F1f1zoHDMm4IebbfIzk1')
          .collection('rides') // Subcollection name
          .where('donationId',
              isEqualTo: donationId) // Filter documents by 'riderId'
          .get();
      // Now you can access the documents that match the riderId
      for (QueryDocumentSnapshot rideDoc in querySnapshot.docs) {
        // Access the ride document data
        Map<String, dynamic>? rideData = rideDoc.data() as Map<String, dynamic>;
        DonationNgoModel? model = DonationNgoModel.fromMap(rideData);
        if (model != null) {
          return model;
        }
        // Do something with the data (e.g., store it in a list)
        // ridesList.add(rideData);
      }
      return null;

      // You can return the list of rides or process the data as needed
    } catch (e) {
      utils.flushBarErrorMessage('Error fetching rides: $e', context);
      // print('Error fetching rides: $e');
      // Handle errors here
    }
  }

}
