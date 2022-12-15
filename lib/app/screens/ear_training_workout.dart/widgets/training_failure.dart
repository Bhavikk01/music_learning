import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';

class EarTrainingFailure extends StatelessWidget {
  final int correct, total;
  const EarTrainingFailure(
      {Key? key, required this.correct, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 48.h,
          ),
          Text(
            Constants.tryAgain,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: ThemeColors.white,
                ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'You\'ve failed this quiz with a score of $correct/$total',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: ThemeColors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Text(
            'You need to score atleast 3/5 in order to complete your submission',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: ThemeColors.white),
          ),
          SizedBox(height: 48.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(RoutePaths.earTrainingScreen);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: ThemeColors.white,
                      size: 48.h,
                    ),
                  ),
                  Text(
                    '   ${Constants.replay}',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ThemeColors.white,
                        ),
                  ),
                ],
              ),
              SizedBox(
                width: 48.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Navigator.popUntil(
                      context,
                      ModalRoute.withName(
                        RoutePaths.workoutScreen,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward,
                      color: ThemeColors.white,
                      size: 48.h,
                    ),
                  ),
                  Text(
                    Constants.exit,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ThemeColors.white,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
