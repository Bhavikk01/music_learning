import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import 'custom_account_text_field.dart';


class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {

  @override
  void initState(){

    if (FirebaseAuth.instance.currentUser == null) {
    super.initState();
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePaths.signInScreen, (route) => false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          const CustomAccountTextField(
            hintText: Constants.name,
          ),
          SizedBox(
            height: 20.h,
          ),
          const CustomAccountTextField(
            hintText: Constants.email,
          ),
          SizedBox(
            height: 20.h,
          ),
          const CustomAccountTextField(
            hintText: Constants.phoneNumber,
          ),
          SizedBox(
            height: 20.h,
          ),
          const CustomAccountTextField(
            hintText: Constants.password,
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.toNamed(RoutePaths.signInScreen);
                  },
                  child: Text(
                    Constants.signOut,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(Constants.save),
                  style: ElevatedButton.styleFrom(
                    primary: ThemeColors.textPrimaryColor,
                    minimumSize: Size(156.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
