import 'dart:io';

import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/widgets/auth_button.dart';
import 'package:donation_app/style/images.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/seller_provider.dart';
import '../../style/custom_text_style.dart';
import '../widgets/circle_progress.dart';
import '../widgets/donationScreen_input_field.dart';
import '../widgets/donation_screen_header.dart';

class DonateFood extends StatefulWidget {
  const DonateFood({super.key});

  @override
  State<DonateFood> createState() => _DonateFoodState();
}

class _DonateFoodState extends State<DonateFood> {
  SellerModel? donar;
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
  String? riderChoise = "Yes";

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

  void _validateFields() async {
    if (_foodNameController.text.trim().isEmpty &&
        _foodDescriptionController.text.trim().isEmpty &&
        _quantityController.text.trim().isEmpty &&
        _expiryController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter Donation details', context);
    } else if (_foodNameController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter food Name', context);
    } else if (_foodDescriptionController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter Food Description', context);
    } else if (_expiryController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter expiry date', context);
    } else if (foodImageList!.isEmpty || foodImageList == null) {
      utils.flushBarErrorMessage('Enter food images', context);
    } else {
      // Regex for Pakistani number (+92 123 4567890)
      // if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_phoneController.text)) {
      isLoading(true);
      final donationId = utils.getRandomid();
      List<String> pictures = await FirebaseUserRepository.uploadDonationImage(
          imageFile: foodImageList!, donationId: donationId);
      DonationModel donationModel = DonationModel(
        donarUid: utils.currentUserUid,
        donarName: donar?.name ?? "No name",
        donarProfileImage: donar!.profileImage,
        donarPhone: donar!.phone,
        needRider: riderChoise,
        status: "pending",
        donarAddress: donar!.address,
        donarDeviceToken: donar!.deviceToken,
        donationDescription: _foodDescriptionController.text,
        donarLat: donar!.lat,
        donarLong: donar!.long,
        expiry: _expiryController.text,
        pictures: pictures,
        type: "food",
        month: utils.getMonthString(DateTime.now()),
        quantity: int.parse(_quantityController.text),
        sentDate: utils.getCurrentDate(),
        sentTime: utils.getCurrentTime(),
        donationId: donationId,
      );

      await FirebaseUserRepository.saveDonationModelToFirestore(
          donationModel, context);
      isLoading(false);
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
    donar = Provider.of<SellerProvider>(context, listen: false).seller;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DonationScreenHeader(
          title: "Donate",
          subTitle: "Life Saving Food To Famlies",
          image: Images.donation_screen_header,
          padding: 24.h,
        ),
        SizedBox(
          height: 3.h,
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
            child: Column(
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  color: Styling.primaryColor,
                  size: 40.h,
                ),
                Text("Upload Images")
              ],
            ),
            onTap: () => selectImages(),
          ),
        ),
        Padding(
          padding: k,
          child: Text(
            "Food Name",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        DonationScreenInputField(
          hint_text: "Food name",
          currentNode: foodNameFocusNode,
          focusNode: foodNameFocusNode,
          nextNode: foodDescriptionFocusNode,
          controller: _foodNameController,
          obsecureText: false,
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
          keyboardType: TextInputType.number,
          controller: _quantityController,
          obsecureText: false,
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
          currentNode: expiryFocusNode,
          focusNode: expiryFocusNode,
          nextNode: expiryFocusNode,
          controller: _expiryController,
          obsecureText: false,
        ),
        l,
        Padding(
          padding: k,
          child: Text(
            "Need Rider",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        riderSelection(),
        Center(
          child: isLoadingNow
              ? const CircleProgress()
              : AuthButton(
                  text: "Donate Now",
                  func: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    _validateFields();
                  },
                  color: Styling.primaryColor),
        ),
        SizedBox(
          height: 10.h,
        ),
      ]),
    )));
  }

  Widget riderSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Radio<String>(
              focusColor: Styling.primaryColor,
              activeColor: Styling.primaryColor,
              value: 'yes',
              groupValue: riderChoise,
              onChanged: (value) {
                setState(() {
                  riderChoise = value!;
                });
              },
            ),
            Text(
              'Yes',
              style: CustomTextStyle.font_18_black,
            ),
          ],
        ),
        // const SizedBox(width: 20),
        Row(
          children: [
            Radio<String>(
              focusColor: Styling.primaryColor,
              // fillColor: Styling.primaryColor,
              activeColor: Styling.primaryColor,
              value: 'no',
              groupValue: riderChoise,
              onChanged: (value) {
                setState(() {
                  riderChoise = value!;
                });
              },
            ),
            Text(
              'No',
              style: CustomTextStyle.font_18_black,
            ),
          ],
        ),
      ],
    );
  }
}
