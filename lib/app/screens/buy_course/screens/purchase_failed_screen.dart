import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../widgets/large_book_button.dart';

class PurchaseFailedScreen extends StatelessWidget {
  const PurchaseFailedScreen({Key? key}) : super(key: key);

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
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              SvgPicture.asset(
                Constants.failureImagePath,
                height: 300,
              ),
              Text(
                Constants.failed,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                // width: 250.w,
                alignment: Alignment.center,
                child: Text(
                  Constants.purchaseFailedNote,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              LargeBookButton(
                title: Constants.continueText,
                onTap: () => Get.toNamed(RoutePaths.homePage),
              )
            ],
          ),
        ),
      ),
    );
  }
}
