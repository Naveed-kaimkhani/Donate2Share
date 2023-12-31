import 'dart:typed_data';
import 'package:donation_app/presentation/donar%20screens/donar_navigation.dart';
import 'package:donation_app/presentation/rider/rider_homepage.dart';
import 'package:donation_app/providers/rider_provider.dart';
import 'package:donation_app/utils/dialogues/donar_added_dialogue.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../data/notification_services.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/donars_list_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../utils/storage_services.dart';
import '../../providers/seller_provider.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/circle_progress.dart';
import '../widgets/input_field.dart';

class RiderSignUp extends StatefulWidget {
  const RiderSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<RiderSignUp> createState() => _RiderSignUpState();
}

class _RiderSignUpState extends State<RiderSignUp> {
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  final _formKey = GlobalKey<FormState>();

  // Uint8List? _profileImage;
  bool? obsecureText = true;
  bool isLoadingNow = false;
  bool _obsecureText = true;
  Uint8List? _profileImage;

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  NotificationServices _notificationServices = NotificationServices();
  // final TextEditingController _addressController = TextEditingController();
  Widget k = SizedBox(
    height: 16.h,
  );
  void isLoading(bool value) {
    setState(() {
      isLoadingNow = value;
    });
  }

  void _submitForm() {
    if (_profileImage == null) {
      utils.flushBarErrorMessage("Please upload profile", context);
    } else if (_formKey.currentState!.validate()) {
      // Form is valid, perform signup logic here
      _signup();
      // Perform signup logic
      // ...
    }
    // _signup();
  }

  Future<void> _signup() async {
    isLoading(true);
    _firebaseUserRepository
        .signUpUser(
      // "donar@gmail.com",
      // "111111",

      _emailController.text,
      _passwordController.text,
      context,
    )
        .then((User? user) async {
      if (user != null) {
        final value =
            await _firebaseUserRepository.getUserCurrentLocation(context);

        //  final Position sellerLocation = await Geolocator.getCurrentPosition();
        final String address =
            await utils.getAddressFromLatLng(value!.latitude, value.longitude);
        // print(address);
        SellerModel sellerModel = SellerModel(
            uid: utils.currentUserUid,
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            address: address,
            lat: value.latitude,
            long: value.longitude,
            profileImage: await _firebaseUserRepository.uploadProfileImage(
                imageFile: _profileImage!, uid: user.uid),
            deviceToken: await _notificationServices.getDeviceToken());
        _saveRider(user, sellerModel);
      } else {
        isLoading(false);
      }
    }).catchError((error) {
      isLoading(false);
      utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  void _saveRider(User firebaseUser, SellerModel sellerModel) {
    _firebaseUserRepository
        .saveRiderDataToFirestore(sellerModel)
        .then((value) async {
      await Provider.of<RiderProvider>(context, listen: false)
          .getRiderFromServer(context);

      isLoading(false);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const RiderHomePage()));
    }).catchError((error) {
      isLoading(false);
      utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    utils.checkConnectivity(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(
                    height: 180.h,
                    text: null,
                    style: CustomTextStyle.font_32_white,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 140.w),
                    child: uploadProfile(_profileImage),
                  ),
                  InputField(
                    hint_text: "Full name",
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: emailFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    hint_text: "Email address",
                    currentNode: emailFocusNode,
                    focusNode: emailFocusNode,
                    nextNode: phoneFocusNode,
                    controller: _emailController,
                    obsecureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter email address";
                      } else if (!EmailValidator.validate(value)) {
                        return "Invalid email address";
                      }
                    },
                  ),
                  InputField(
                    hint_text: "Phone",
                    currentNode: phoneFocusNode,
                    focusNode: phoneFocusNode,
                    nextNode: passwordFocusNode,
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter phone number";
                      } else if (value.length != 11) {
                        return "Invalid phone number";
                      }
                    },
                  ),
                  InputField(
                    hint_text: "Set password",
                    currentNode: passwordFocusNode,
                    focusNode: passwordFocusNode,
                    nextNode: confirmFocusNode,
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    icon: obsecureText!
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    obsecureText: obsecureText,
                    onIconPress: () {
                      setState(() {
                        obsecureText = !obsecureText!;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter password";
                      } else if (value.length < 6) {
                        return "password must be of 6 characters";
                      }
                    },
                  ),
                  InputField(
                    hint_text: "Confirm password",
                    currentNode: confirmFocusNode,
                    focusNode: confirmFocusNode,
                    nextNode: confirmFocusNode,
                    controller: _confirmpasswordController,
                    obsecureText: _obsecureText,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter password to confirm";
                      } else if (value != _passwordController.text) {
                        return "Password not match";
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: isLoadingNow
                        ? const CircleProgress()
                        : AuthButton(
                            text: "Signup",
                            func: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              _submitForm();
                            },
                            color: Styling.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onIconPress() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Widget uploadProfile(Uint8List? image) {
    return image == null
        ? Stack(
            children: [
              Image.asset(
                "assets/avatar.png",
                height: 60.h,
                width: 60.w,
              ),
              Positioned(
                left: 25.w,
                bottom: 0.h,
                child: IconButton(
                  onPressed: () async {
                    Uint8List? _image = await utils.pickImage();
                    if (_image != null) {
                      setState(() {
                        _profileImage = _image;
                      });
                    } else {
                      debugPrint("Image not loaded");
                    }
                  },
                  icon: Container(
                    width: 25.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Styling.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset('assets/gallery.png'),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              CircleAvatar(
                minRadius: 40.r,
                maxRadius: 40.r,
                child: ClipOval(
                    child: Image.memory(
                  image,
                  height: 145.h,
                  width: 145.w,
                  fit: BoxFit.cover,
                )),
                // child: ,
              ),
              Positioned(
                left: 45.w,
                bottom: 0.h,
                child: IconButton(
                  onPressed: () async {
                    Uint8List? _image = await utils.pickImage();

                    if (_image != null) {
                      setState(() {
                        image = _image;
                      });
                    }
                    debugPrint("Image not loaded");
                  },
                  icon: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Styling.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.asset('assets/gallery.png'),
                    ),
                  ),
                ),
              ),
            ],
          );
  } // for 1st image
}
