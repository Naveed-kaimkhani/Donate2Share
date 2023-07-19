import 'dart:io';

import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../domain/models/seller_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/seller_provider.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../widgets/donationScreen_input_field.dart';
import '../widgets/donation_screen_header.dart';

class DonateFood extends StatefulWidget {
  const DonateFood({super.key});

  @override
  State<DonateFood> createState() => _DonateFoodState();
}

class _DonateFoodState extends State<DonateFood> {
   SellerModel? donator;
  FocusNode foodNameFocusNode = FocusNode();

  FocusNode foodDescriptionFocusNode = FocusNode();

  FocusNode quantityFocusNode = FocusNode();

  // FocusNode confirmFocusNode = FocusNode();
  FocusNode expiryFocusNode = FocusNode();

  final TextEditingController _foodNameController = TextEditingController();

  final TextEditingController _foodDescriptionController =
      TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _expiryController = TextEditingController();
  EdgeInsetsGeometry k = EdgeInsets.only(left: 18.w);
  SizedBox l = SizedBox(
    height: 12.h,
  );
  bool isLoadingNow = false;
  
 void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  List<XFile>? foodImageList = [];
  void selectImages() async {
    final selectedImaged = await ImagePicker().pickMultiImage();
    if (selectedImaged.isNotEmpty) {
      foodImageList!.addAll(selectedImaged);
    }
    setState(() {});
  }

  void _validateFields() {
    if (_foodNameController.text.trim().isEmpty &&
        _foodDescriptionController.text.trim().isEmpty &&
        _quantityController.text.trim().isEmpty &&
        _expiryController.text.trim().isEmpty 
        ) {
        
      utils.flushBarErrorMessage('Enter Donation details', context);
    } else if (_foodNameController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter food Name', context);
    } else if (_foodDescriptionController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter Food Description', context);
    } else if (_expiryController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter expiry date', context);
    } else if (foodImageList!.isEmpty || foodImageList==null) {
      utils.flushBarErrorMessage('Enter food images', context);
    }  else {
      // Regex for Pakistani number (+92 123 4567890)
      // if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_phoneController.text)) {
      isLoading(true);
    DonationModel donationModel=DonationModel(
        donatorUid: utils.currentUserUid,
          donatorName:donator?.name??"No name" ,
        donatorProfileImage: donator!.profileImage,
        donatorPhone: donator!.phone,
        donatorAddress: donator!.address,
        donatorDeviceToken: donator!.deviceToken,
        donatorLat: donator!.lat,
        donatorLong: donator!.long,
          sentDate:utils.getCurrentDate(),
          sentTime: utils.getCurrentTime(),
          donationId: utils.getRandomid(),

    );
      
      _saveModelToFireStore(donationModel);
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodDescriptionController.dispose();
    _quantityController.dispose();
    _expiryController.dispose();
    foodDescriptionFocusNode.dispose();
    foodNameFocusNode.dispose();
    quantityFocusNode.dispose();
    expiryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    donator = Provider.of<SellerProvider>(context, listen: false).seller;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const DonationScreenHeader(),
        SizedBox(
          height: 30.h,
        ),
        foodImageList!.isNotEmpty
            ? SizedBox(
                height: 100.h,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodImageList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(foodImageList![index].path),
                          fit: BoxFit.cover,
                          height: 100.h,
                          width: 50.w,
                        ),
                      );
                    },
                  ),
                ),
              )
            : const SizedBox(),
        Center(
          child: InkWell(
            child: Icon(
              Icons.file_upload_outlined,
              color: Styling.primaryColor,
              size: 40.h,
            ),
            onTap: () => selectImages(),
          ),
        ),
        Padding(
          padding: k,
          child: Text(
            "Food Type",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        DonationScreenInputField(
          hint_text: "Food Type",
          currentNode: foodNameFocusNode,
          focusNode: foodNameFocusNode,
          nextNode: foodDescriptionFocusNode,
          controller: _foodNameController,
          obsecureText: false,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Enter food name";
          //   } else {
          //     return null;
          //   }
          // },
        ),
        l,
        Padding(
          padding: k,
          child: Text(
            "Description",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 6.h),
          width: 385.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Styling.primaryColor,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 250,
              maxLines: 8,
              controller: _foodDescriptionController,
              decoration: const InputDecoration.collapsed(
                  hintText: "Write a description"),
            ),
          ),
        ),
        l,
        Padding(
          padding: k,
          child: Text(
            "Quantity",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        DonationScreenInputField(
          hint_text: "eg . 40 Kilograms",
          currentNode: quantityFocusNode,
          focusNode: quantityFocusNode,
          nextNode: expiryFocusNode,
          controller: _foodNameController,
          obsecureText: false,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Enter quantity";
          //   } else {
          //     return null;
          //   }
          // },
        ),
        l,
        Padding(
          padding: k,
          child: Text(
            "Best Before",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        DonationScreenInputField(
          hint_text: "Expiry date",
          currentNode: foodNameFocusNode,
          focusNode: foodNameFocusNode,
          nextNode: foodDescriptionFocusNode,
          controller: _foodNameController,
          obsecureText: false,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Enter quantity";
          //   } else {
          //     return null;
          //   }
          // },
        ),
        Padding(
          padding: EdgeInsets.only(left: 40.w, top: 36.h),
          child: AuthButton(
              text: "Donate Now", func: () {}, color: Styling.primaryColor),
        )
      ]),
    )));
  }
}
