import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../widgets/large_book_button.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  const PurchaseSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.toNamed(RoutePaths.homePage);
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 50.h,
              ),
              SvgPicture.asset(
                Constants.successImagePath,
                height: 300,
              ),
              Text(
                Constants.success,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                Constants.purchaseSuccessNote,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: 150.h,
              ),
              LargeBookButton(
                title: Constants.bookSession,
                onTap: () => Get.toNamed(
                  RoutePaths.bookSessionScreen,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              TextButton(
                onPressed: () => Get.toNamed(RoutePaths.homePage),
                child: Text(
                  Constants.skipForNow,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: ThemeColors.textGreyColor,
                        offset: Offset(0.h, -5.w),
                      ),
                    ],
                    color: ThemeColors.transparent,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationColor: ThemeColors.textModerateColor,
                    decorationThickness: 2.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
