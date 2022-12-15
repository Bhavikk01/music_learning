import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';

class EarTrainingSuccess extends StatelessWidget {
  final int correct, total;
  const EarTrainingSuccess({
    Key? key,
    required this.correct,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //TODO: Have to write a function for post workout to api

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 48.h,
          ),
          Text(
            Constants.congratulations,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: ThemeColors.white,
                ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'You\'ve passed this quiz with a score of $correct/$total',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: ThemeColors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
                size: 40.h,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Exceptional Performance',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: ThemeColors.white),
              ),
            ],
          ),
          SizedBox(height: 48.h),
          ElevatedButton(
            onPressed: () => Navigator.popUntil(
              context,
              ModalRoute.withName(RoutePaths.workoutScreen),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              primary: ThemeColors.milkyWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
              ),
              minimumSize: Size(120.w, 30.h),
            ),
            child: Text(
              'Back To Workouts',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: ThemeColors.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
