// import 'dart:typed_data';
import 'dart:typed_data';
import 'package:donation_app/presentation/NGO%20screens/ngo_navigation_page.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/firebase_user_repository.dart';
import '../../data/notification_services.dart';
import '../../domain/models/user_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../utils/storage_services.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/circle_progress.dart';
import '../widgets/input_field.dart';
import 'admin_navigation.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({Key? key}) : super(key: key);

  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  final _formKey = GlobalKey<FormState>();
  NotificationServices notificationServices = NotificationServices();

  // Uint8List? _profileImage;
  bool? obsecureText = true;
  bool isLoadingNow = false;
  bool _obsecureText = true;

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
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform signup logic here
      _signup();
      // Perform signup logic
      // ...
    }
  }

  void _signup() {
    // utils.showLoading(context);
    isLoading(true);
    _firebaseUserRepository
        // .signUpUser(_emailController.text, _passwordController.text, context)
        .signUpUser("admin@gmail.com", "111111", context)
        .then((User? user) async {
      final value =
          await _firebaseUserRepository.getUserCurrentLocation(context);

      //  final Position sellerLocation = await Geolocator.getCurrentPosition();
      final String address =
          await utils.getAddressFromLatLng(value!.latitude, value.longitude);
      if (user != null) {
        UserModel userModel = UserModel(
            uid: user.uid,
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            address: address,
            lat: value.latitude,
            long: value.longitude,
            deviceToken: await notificationServices.getDeviceToken());
        _saveAdmin(user, userModel);
      } else {
        isLoading(false);
        // utils.hideLoading();
        utils.flushBarErrorMessage('Failed to Signup', context);
      }
    }).catchError((error) {
      isLoading(false);
      utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  void _saveAdmin(User firebaseUser, UserModel userModel) {
    _firebaseUserRepository
        .saveAdminDataToFirestore(userModel)
        .then((value) async {
      await StorageService.saveUser(userModel).then((value) async {
        await Provider.of<AdminProvider>(context, listen: false)
            .getAdminFromServer(context);
        await StorageService.initUser();

        isLoading(false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AdminNavigation()));
      }).catchError((error) {
        isLoading(false);
        utils.flushBarErrorMessage(error.message.toString(), context);
      });
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
                    height: 200.h,
                    text: null,
                    style: CustomTextStyle.font_32_white,
                  ),
                  SizedBox(
                    height: 12.h,
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
                  // k,
                  SizedBox(
                    height: 38.h,
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
}
