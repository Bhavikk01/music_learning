import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/colors.dart';

import '../../constants/constants.dart';

class PaymentTab extends StatelessWidget {
  const PaymentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            Text(
              Constants.notification,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Center(
                child: Text(
                  'Your payment of ₹2000 has been received.',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.sp,
                      ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.w),
                color: ThemeColors.blue,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Center(
                child: Text(
                  'Your payment of ₹2000 has been received.',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.sp,
                      ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.w),
                color: ThemeColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
