import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';

class EmptyLearningWidget extends StatelessWidget {
  const EmptyLearningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        Text(
          Constants.muchEmpty,
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: 250.w,
          alignment: Alignment.center,
          child: const Text(
            Constants.emptyLearningNote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        const Placeholder(
          fallbackHeight: 200,
        )
      ],
    );
  }
}
