import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';


class TutorFeaturePill extends StatelessWidget {
  final String text;
  final Color color;
  const TutorFeaturePill({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: color),
        ),
      ),
    );
  }
}

class TutorFeatureBar extends StatelessWidget {
  const TutorFeatureBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Hindi, English',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: ThemeColors.white,
                    fontSize: 12.sp,
                  ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Exp: 4 yrs',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: ThemeColors.white,
                    fontSize: 12.sp,
                  ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Students: 30',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: ThemeColors.white,
                    fontSize: 12.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
