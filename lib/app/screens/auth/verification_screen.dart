import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/phone_auth_controller.dart';
import '../../models/enums/phone_auth_model.dart';
import '../../models/enums/phone_auth_user_state.dart';
import '../../models/phone_auth_model.dart';
import '../../widgets/custom_textfield.dart';



class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late int seconds;
  String? verificationCode;
  String otpCode = '';
  PhoneAuthModel phoneAuthModel = const PhoneAuthModel(
    phoneAuthModelState: PhoneAuthModelState.error,
    userState: PhoneAuthUserState.newUser,
    uid: '',
  );

  @override
  void initState() {
    seconds = 30;
    decrementSeconds();
    super.initState();
  }

  void decrementSeconds() async {
    while (seconds != 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          seconds--;
        });
      } else {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(phoneAuthModel.phoneAuthModelState != PhoneAuthModelState.error){
      if(phoneAuthModel.userState ==  PhoneAuthUserState.existingUser){
        Get.toNamed(RoutePaths.homePage);

      }else if(phoneAuthModel.userState ==  PhoneAuthUserState.newUser){
        Get.toNamed(RoutePaths.coursePreferenceScreen);
      }
    }
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back,
          icon: Icon(
            Icons.arrow_back_ios,
            color: ThemeColors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Text(
              Constants.verificationCode,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                fontWeight: FontWeight.w700,
                color: ThemeColors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Resend after $seconds seconds',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 48.h),
            Center(
              child: CustomTextField(
                hintText: Constants.verificationCodeInput,
                inputType: TextInputType.number,
                onChanged: (otp) {
                  setState(() {
                    otpCode = otp;
                  });
                },
              ),
            ),
            SizedBox(height: 30.h),
            GetBuilder<PhoneAuthController>(builder: (controller) {

              if(phoneAuthModel.phoneAuthModelState != PhoneAuthModelState.error){
                if(phoneAuthModel.userState ==  PhoneAuthUserState.existingUser){
                  Get.toNamed(RoutePaths.homePage);

                }else if(phoneAuthModel.userState ==  PhoneAuthUserState.newUser){
                  Get.toNamed(RoutePaths.coursePreferenceScreen);
                }
              }

              return ElevatedButton(
                child: Text(
                  Constants.verify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: ThemeColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  minimumSize: Size(
                    308.w,
                    50.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                ),
                onPressed: () async {

                  // controller.takeOtp(otpCode);
                  // phoneAuthModel = await controller.verifySMSCode();
                  //
                  // if(phoneAuthModel.phoneAuthModelState != PhoneAuthModelState.error){
                  //   if(phoneAuthModel.userState ==  PhoneAuthUserState.existingUser){
                  await Get.toNamed(RoutePaths.homePage);
                  //
                  //   }else if(phoneAuthModel.userState ==  PhoneAuthUserState.newUser){
                  //     await Get.toNamed(RoutePaths.coursePreferenceScreen);
                  //   }
                  // }else{
                  //  log('Error occurred');
                  // }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
