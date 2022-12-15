import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';

class PrivacyPolicyTab extends StatelessWidget {
  const PrivacyPolicyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.privacyPolicy,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontSize: 22.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur  urna adipiscing elit, sed do eiusmod tempor eget commodo viverra maecenas accumsan lacus vel facilisis posuere. Vestibulum imperdiet nibh vel magna lacinia ultrices. Sed id interdum urna. Nam ac elit a ante commodo tristique. ',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Text('•  Sed id interdum urna'),
            const Text('•  Nam ac elit a ante commodo'),
            const Text('•  Euismod lorem tincidunt'),
          ],
        ),
      ),
    );
  }
}
