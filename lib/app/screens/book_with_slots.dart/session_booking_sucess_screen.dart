import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../widgets/large_book_button.dart';

class SessionBookingSuccessScreen extends StatelessWidget {
  const SessionBookingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(
          context,
          ModalRoute.withName(RoutePaths.homePage),
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              SvgPicture.asset(
                Constants.successImagePath,
                height: 300,
              ),
              Text(
                Constants.success,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              LargeBookButton(
                title: Constants.continueText,
                onTap: () => Navigator.popUntil(
                  context,
                  ModalRoute.withName(RoutePaths.homePage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
