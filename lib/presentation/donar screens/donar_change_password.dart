import 'package:donation_app/presentation/NGO%20screens/ngo_navigation_page.dart';
import 'package:donation_app/presentation/widgets/circle_progress.dart';
import 'package:donation_app/presentation/widgets/update_profile_field.dart';
import 'package:donation_app/style/styling.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../domain/models/seller_model.dart';
import '../../domain/models/user_model.dart';
import '../../providers/seller_provider.dart';
import '../../providers/user_provider.dart';
import '../widgets/all_donars_screen_header.dart';
import '../widgets/auth_button.dart';
import '../widgets/input_field.dart';
import '../widgets/profile_pic.dart';
import 'donar_navigation.dart';

class DonarChangePassword extends StatefulWidget {
  const DonarChangePassword({Key? key}) : super(key: key);

  @override
  State<DonarChangePassword> createState() => _DonarChangePasswordState();
}

class _DonarChangePasswordState extends State<DonarChangePassword> {
  TextEditingController _passController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool _obsecureText = true;
  bool _obsecureText1 = true;
  bool isLoading = false;
  FocusNode passwordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  void _validateFields() {
    if (_passController.text.trim().isEmpty &&
        _newPasswordController.text.trim().isEmpty) {
      utils.flushBarErrorMessage("please Enter your Password fields", context);
    } else if (_passController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Please Enter Current password', context);
    } else if (_newPasswordController.text.trim().isEmpty) {
      utils.flushBarErrorMessage('Please Enter New Password', context);
    } else {
      _changePassword();
    }
  }

  void isLoadingg(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _changePassword() async {
    User? user = utils.getCurrentUser();
    try {
      isLoadingg(true);
      final userr = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: user!.email!, password: _passController.text))
          .user;
      user
          .reauthenticateWithCredential(EmailAuthProvider.credential(
              email: user.email.toString(),
              password: _passController.text.toString()))
          .then((value) {
        user.updatePassword(_newPasswordController.text).then((value) {
          isLoadingg(false);
          utils.toastMessage("Password updated Successfully");

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DonarNavigation()));
        }).onError((error, stackTrace) {
          isLoadingg(false);
          String errorMessage = utils.getFriendlyErrorMessage(
              error); // Get a user-friendly error message
          utils.flushBarErrorMessage(errorMessage, context); // Handle the erro
        });
      }).onError((error, stackTrace) {
        isLoadingg(false);
        // String errorMessage = utils.getFriendlyErrorMessage(
        //     error); // Get a user-friendly error message

        utils.flushBarErrorMessage(
            error.toString(), context); // Handle the erro
      });
    } catch (e) {
      isLoadingg(false);
      utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  @override
  void dispose() {
    _passController.dispose();
    _newPasswordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SellerModel? user = Provider.of<SellerProvider>(context, listen: false).seller;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AllDonarsScreenHeader(
                header: "Change Password",
                subHeader: "",
                backButton: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26.r,
                      child: ProfilePic(
                        url: user!.profileImage,
                        height: 50.h,
                        width: 50.w,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style: TextStyle(
                              fontSize: 26.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 14.h,
              // ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Current Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              UpdateProfileField(
                  hint_text: "Current Password",
                  currentNode: null,
                  focusNode: null,
                  nextNode: null,
                  controller: _passController,
                  icon: _obsecureText
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  obsecureText: _obsecureText,
                  onIconPress: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  }),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              UpdateProfileField(
                  hint_text: "New Password",
                  currentNode: null,
                  focusNode: null,
                  nextNode: null,
                  controller: _newPasswordController,
                  icon: _obsecureText1
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  obsecureText: _obsecureText1,
                  onIconPress: () {
                    setState(() {
                      _obsecureText1 = !_obsecureText1;
                    });
                  }),
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.center,
                child: isLoading
                    ? const CircleProgress()
                    : AuthButton(
                        text: 'Change Password',
                        color: Styling.primaryColor,
                        func: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          _validateFields();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
