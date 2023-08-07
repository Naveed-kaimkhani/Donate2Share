import 'package:donation_app/presentation/donar%20screens/donar_homepage.dart';
import 'package:donation_app/presentation/donar%20screens/donar_navigation.dart';
import 'package:donation_app/presentation/donar%20screens/donate_clothes.dart';
import 'package:donation_app/presentation/donar%20screens/donate_food.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/firebase_user_repository.dart';
import '../../../style/styling.dart';
import '../../../utils/storage_services.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/rider_provider.dart';
import '../../providers/seller_provider.dart';
import '../../style/custom_text_style.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/circle_progress.dart';
import '../widgets/input_field.dart';

class RiderLogin extends StatefulWidget {
  const RiderLogin({Key? key}) : super(key: key);

  @override
  State<RiderLogin> createState() => _RiderLoginState();
}

class _RiderLoginState extends State<RiderLogin> {
  final FirebaseUserRepository _firebaseRepository = FirebaseUserRepository();
  final _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? obsecureText = true;
  bool isLoadingNow = false;
  bool _obsecureText = true;
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
      _login();
    }
  }

  void _login() {
    isLoading(true);
    _firebaseRepository
        // .login(_emailController.text, _passwordController.text, context)
        .login("rider@gmail.com", "111111", context)
        .then((User? user) async {
      if (user != null) {
        //  final   currentLocation = await Geolocator.getCurrentPosition();
        _getSellerDetails();
      } else {
        isLoading(false);
        utils.flushBarErrorMessage("Failed to login", context);
      }
    });
  }

  void _getSellerDetails() async{
    _firebaseRepository.getRiderDetails().then((SellerModel? sellerModel) async{
      if (sellerModel != null){
          // await _firebaseRepository.loadDonarDataOnAppInit(context);

    await Provider.of<RiderProvider>(context, listen: false)
          .getRiderFromServer(context);

          isLoading(false);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DonarNavigation()));
        
      } else {
        isLoading(false);
        utils.flushBarErrorMessage("User is null", context);
      }
    }).catchError((error) {
      isLoading(false);
      utils.flushBarErrorMessage(error.message.toString(), context);
    });
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
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
                    height: 230.h,
                    text: "WellCome Back",
                  style: CustomTextStyle.font_32_white,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InputField(
                    hint_text: "Email",
                    currentNode: emailFocusNode,
                    focusNode: emailFocusNode,
                    nextNode: passwordFocusNode,
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
                  // k,
                  InputField(
                    hint_text: "Password",
                    currentNode: passwordFocusNode,
                    focusNode: passwordFocusNode,
                    nextNode: passwordFocusNode,
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
                  Padding(
                    padding: EdgeInsets.only(left: 230.w),
                    child: TextButton(
                        onPressed: () {}, child: const Text("Forget Password")),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: isLoadingNow
                        ? const CircleProgress()
                        : AuthButton(
                            text: "Login",
                            func: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // _submitForm();
                              _login();
                            },
                            color: Styling.primaryColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 48.w),
                    child: TextButton(
                      onPressed: () {},
                      child: Text.rich(TextSpan(
                          text: 'Dont have a account? ',
                          style: CustomTextStyle.font_15,
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Create Now',
                              style: CustomTextStyle.font_15_primaryColor,
                            )
                          ])),
                    ),
                  ),
                  // Pa
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
