
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/phone_auth_controller.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String phoneNumber = '';
  String email = '';
  String password = '';
  bool isTutor = false;


  addTutorLoginToSF() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isTutor', isTutor);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 45.h),
              Image.asset(
                'assets/images/app_logo.png',
              ),
              SizedBox(
                height: 110.h,
              ),
              Text(
                Constants.signIn,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: ThemeColors.textLightColor),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: CustomTextField(
                  hintText: Constants.phone,
                  inputType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      phoneNumber = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isTutor,
                    onChanged: (val) => setState(
                          () {
                        isTutor = val ?? false;
                      },
                    ),
                  ),
                  Text(
                    'Sign In as Tutor?',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ThemeColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              GetBuilder<PhoneAuthController>(builder: (controller) {

                return ElevatedButton(
                  child: Text(
                    Constants.signIn,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ThemeColors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    minimumSize: Size(
                      308.w,
                      50.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.h),
                    ),
                  ),
                  onPressed: () async {

                    if (Phone.validate(phoneNumber)) {
                      log('Hello');
                      controller.takePhoneNumber(phoneNumber, isTutor);
                      await controller.verifyTutorPhoneNumber();
                      if(await controller.authorizeUser(phoneNumber)){
                        await Get.toNamed(RoutePaths.verificationScreen);
                      }
                      // if(controller.tutorAvailable){
                      //   addTutorLoginToSF();
                      //   await Get.toNamed(RoutePaths.verificationScreen);
                      // } else if(!isTutor){
                      //   addTutorLoginToSF();
                      //   await controller.verifyPhoneNumber();
                      //   await Get.toNamed(RoutePaths.verificationScreen);
                      // } else if(!controller.tutorAvailable){
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text(
                      //           Constants.invalidTutorPhoneNumber,
                      //         ),
                      //       )
                      //   );
                      // }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            Constants.invalidPhoneNumber,
                          ),
                        ),
                      );
                    }

                    // } else if (Email.validate(email) &&
                    //     Password.validate(password)) {
                    //   context
                    //       .read<AuthBloc>()
                    //       .add(AuthLoginEmailEvent(email, password));
                    // } else {
                    //   if (Email.validate(email)) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text(
                    //           Constants.invalidPassword,
                    //         ),
                    //       ),
                    //     );
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text(
                    //           Constants.invalidPassword,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                  },
                );
              })

              // Text(
              //   Constants.orWithEmail,
              //   style: Theme.of(context).textTheme.bodyText2?.copyWith(
              //         color: ThemeColors.textLightColor,
              //         fontWeight: FontWeight.w400,
              //       ),
              // ),
              // SizedBox(
              //   height: 28.h,
              // ),
              // Center(
              //   child: CustomTextField(
              //     hintText: Constants.email,
              //     inputType: TextInputType.emailAddress,
              //     onChanged: (val) {
              //       setState(() {
              //         email = val;
              //       });
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              // Center(
              //   child: CustomTextField(
              //     hintText: Constants.password,
              //     inputType: TextInputType.visiblePassword,
              //     onChanged: (val) {
              //       setState(() {
              //         password = val;
              //       });
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              // SizedBox(
              //   height: 50.h,
              // ),
              // Text(
              //   Constants.hintForSignUp,
              //   style: Theme.of(context).textTheme.bodyText2?.copyWith(
              //         color: ThemeColors.textLightColor,
              //       ),
              // ),
              // SizedBox(
              //   height: 26.h,
              // ),
              // TextButton(
              //   child: Text(
              //     '${Constants.signUp}!',
              //     style: TextStyle(
              //       shadows: [
              //         Shadow(
              //           color: ThemeColors.textPrimaryColor,
              //           offset: Offset(0.h, -7.w),
              //         ),
              //       ],
              //       color: ThemeColors.transparent,
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w400,
              //       decoration: TextDecoration.underline,
              //       decorationColor: ThemeColors.textModerateColor,
              //       decorationThickness: 1.25.h,
              //     ),
              //   ),
              //   onPressed: () =>
              //       Get.toNamed(RoutePaths.signUpScreen),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
