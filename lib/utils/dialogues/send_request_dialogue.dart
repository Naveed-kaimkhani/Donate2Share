import 'dart:convert';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../domain/models/request_model.dart';
import '../../domain/models/user_model.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../presentation/widgets/button_for_dialogue.dart';
import '../../presentation/widgets/circle_progress.dart';

class SendRequestDialogue extends StatefulWidget {
  @override
  _SendRequestDialogueState createState() => _SendRequestDialogueState();
}

class _SendRequestDialogueState extends State<SendRequestDialogue> {
  String _selectedService = "food";
  // String _selectedVehicleType = "Car";
  UserModel? ngo;
  TextEditingController controller = TextEditingController();

  TextEditingController quantityController = TextEditingController();
  bool isLoadingNow = false;
  // Updated _services list with unique items
  final List<String> _services = ['food', 'clothes'];
  // final List<String> _vehicleTypes = ['Car', 'Motorcycle', 'Truck'];

  @override
  Widget build(BuildContext context) {
    ngo = Provider.of<UserProvider>(context, listen: false).ngo;
    return Dialog(
      // shadowColor: Color.fromARGB(255, 135, 130, 130),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Request For Donation",
              style: CustomTextStyle.font_20_appColor,
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedService,
                items: _services.map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(
                      service,
                      // style: TextStyle(color: Color.fromARGB(255, 101, 99, 99)),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedService = value!;
                  });
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide:
                        BorderSide(color: Styling.primaryColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide:
                        BorderSide(color: Styling.primaryColor, width: 1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            // SizedBox(height: 12.h),
            SizedBox(height: 12.h),
            Container(
              width: 287.w,
              height: 45.h,
              decoration: field_decoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // maxLength: 150,
                  // maxLines: 8,
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                  decoration:
                      const InputDecoration.collapsed(hintText: "Enter Amount"),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: 287.w,
              height: 65.h,
              decoration: field_decoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 150,
                  maxLines: 8,
                  controller: controller,
                  decoration:
                      const InputDecoration.collapsed(hintText: "Description"),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            InkWell(
              child: isLoadingNow
                  ? const CircleProgress()
                  : ButtonForDialogue(
                      text: "Request",
                    ),
              onTap: () async {
                sendRequest();
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style:
                      TextStyle(color: Styling.primaryColor, fontSize: 20.sp),
                ))
          ],
        ),
      ),
    );
  }

  BoxDecoration field_decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(7.r),
      border: Border.all(
        color: Styling.primaryColor,
        width: 1.0,
      ),
    );
  }

  Future<void> sendRequest() async {
    if (quantityController.text.isEmpty && controller.text.isEmpty) {
      utils.flushBarErrorMessage("Enter Information", context);
    } else {
      RequestModel request = RequestModel(
          documentId: '',
          serviceId: utils.getRandomid(),
          senderUid: utils.currentUserUid,
          senderName: ngo!.name,
          senderPhone: ngo!.phone,
          description: controller.text,
          quantity: int.tryParse(quantityController.text),
          donationType: _selectedService,
          status: 'pending',
          // senderLat: user.lat,
          // senderLong: user.long,
          senderAddress: ngo!.address,
          senderDeviceToken: ngo!.deviceToken,
          sentDate: utils.getCurrentDate(),
          sentTime: utils.getCurrentTime(),
          senderProfileImage: ngo!.profileImage);

      await FirebaseUserRepository.sendRequestToAdminForDonation(
          request, context);

      Navigator.pop(context);
      utils.openRequestSentDialogue(context);
    }
  }
}
