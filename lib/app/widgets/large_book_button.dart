import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/colors.dart';

class LargeBookButton extends StatelessWidget {
  final void Function() onTap;
  final String title;

  const LargeBookButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: ThemeColors.buttonDarkColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ThemeColors.white,
                  ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ThemeColors.white,
              size: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}
