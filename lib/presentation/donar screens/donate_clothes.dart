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

class Donateclotheses extends StatefulWidget {
  const Donateclotheses({super.key});

  @override
  State<Donateclotheses> createState() => _DonateclothesesState();
}

class _DonateclothesesState extends State<Donateclotheses> {
  SellerModel? donator;
  FocusNode clothesNameFocusNode = FocusNode();

  FocusNode clothesDescriptionFocusNode = FocusNode();

  FocusNode quantityFocusNode = FocusNode();

  final TextEditingController _clothesNameController = TextEditingController();

  final TextEditingController _clothesDescriptionController =
      TextEditingController();

  final TextEditingController _quantityController = TextEditingController();
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

  List<XFile>? clothesImageList = [];
  void selectImages() async {
    final selectedImaged = await ImagePicker().pickMultiImage();
    if (selectedImaged.isNotEmpty) {
      clothesImageList!.addAll(selectedImaged);
    }
    setState(() {});
  }

  void _validateFields() async {
    if (_clothesNameController.text.trim().isEmpty &&
        _clothesDescriptionController.text.trim().isEmpty &&
        _quantityController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter Donation details', context);
    } else if (_clothesNameController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter clothes Name', context);
    } else if (_clothesDescriptionController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Enter clothes Description', context);
    } else if (clothesImageList!.isEmpty || clothesImageList == null) {
      utils.flushBarErrorMessage('Enter clothes images', context);
    } else {
      // Regex for Pakistani number (+92 123 4567890)
      // if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_phoneController.text)) {
      isLoading(true);
      final donationId = utils.getRandomid();
      List<String> pictures = await FirebaseUserRepository.uploadDonationImage(
          imageFile: clothesImageList!, donationId: donationId);
      DonationModel donationModel = DonationModel(
        donatorUid: utils.currentUserUid,
        donatorName: donator?.name ?? "No name",
        donatorProfileImage: donator!.profileImage,
        donatorPhone: donator!.phone,
        needRider: riderChoise,
        donatorAddress: donator!.address,
        donatorDeviceToken: donator!.deviceToken,
        donatorLat: donator!.lat,
        donatorLong: donator!.long,
        pictures: pictures,
        quantity: _quantityController.text,
        type: "clothes",
        sentDate: utils.getCurrentDate(),
        sentTime: utils.getCurrentTime(),
        month: utils.getMonthString(DateTime.now()),
        donationId: donationId,
      );

      await FirebaseUserRepository.saveDonationModelToFirestore(
          donationModel, context);
      isLoading(false);
    }
  }

  @override
  void dispose() {
    _clothesNameController.dispose();
    _clothesDescriptionController.dispose();
    _quantityController.dispose();
    clothesDescriptionFocusNode.dispose();
    clothesNameFocusNode.dispose();
    quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    donator = Provider.of<SellerProvider>(context, listen: false).seller;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DonationScreenHeader(
          title: "Give Your ",
          subTitle: "CLothes A Second Life",
          image: Images.clothes,
          padding: 42.w,
        ),
        SizedBox(
          height: 3.h,
        ),
        clothesImageList!.isNotEmpty
            ? SizedBox(
                height: 100.h,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: clothesImageList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(clothesImageList![index].path),
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
            "clothes Name",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        DonationScreenInputField(
          hint_text: "clothes name",
          currentNode: clothesNameFocusNode,
          focusNode: clothesNameFocusNode,
          nextNode: clothesDescriptionFocusNode,
          controller: _clothesNameController,
          obsecureText: false,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Enter clothes name";
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
          height: 70.h,
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
              controller: _clothesDescriptionController,
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
          hint_text: "eg . 40 dresses",
          currentNode: quantityFocusNode,
          focusNode: quantityFocusNode,
          nextNode: quantityFocusNode,
          controller: _quantityController,
          obsecureText: false,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Enter quantity";
          //   } else {
          //     return null;
          //   }
          // },
        ),
        // l,
        // Padding(
        //   padding: k,
        //   child: Text(
        //     "Best Before",
        //     style: CustomTextStyle.font_18_black,
        //   ),
        // ),
        // DonationScreenInputField(
        //   hint_text: "Expiry date",
        //   currentNode: expiryFocusNode,
        //   focusNode: expiryFocusNode,
        //   nextNode: expiryFocusNode,
        //   controller: _expiryController,
        //   obsecureText: false,
        //   // validator: (value) {
        //   //   if (value.isEmpty) {
        //   //     return "Enter quantity";
        //   //   } else {
        //   //     return null;
        //   //   }
        //   // },
        // ),
        l,
        Padding(
          padding: k,
          child: Text(
            "Need Rider",
            style: CustomTextStyle.font_18_black,
          ),
        ),
        riderSelection(),
        Padding(
          padding: EdgeInsets.only(left: 42.w, top: 8.h),
          child: isLoadingNow
              ? const CircleProgress()
              : AuthButton(
                  text: "Donate Now",
                  func: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    _validateFields();
                  },
                  color: Styling.primaryColor),
        )
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
