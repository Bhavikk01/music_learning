import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';


class MultiColorProgressBar extends StatelessWidget {
  final int total;
  final int completed;
  final String text;
  late final int noOfSections;

  MultiColorProgressBar({
    Key? key,
    required this.total,
    required this.completed,
    required this.text,
  }) : super(key: key) {
    noOfSections = (total >= 4) ? 4 : (total / 2).ceil();
  }

  getProgressList(double width) {
    var list = <Widget>[];
    var activeSections = min(noOfSections, completed);
    var maxWidth = (completed / total) * width;

    for (var i = activeSections - 1; i >= 0; i--) {
      list.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: (maxWidth / activeSections) * (i + 1),
          height: 12.h,
          decoration: BoxDecoration(
            color: ThemeColors.multiProgressBarColors[i],
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: boxConstraints.maxWidth,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.milkyWhite,
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                ...getProgressList(boxConstraints.maxWidth),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ThemeColors.textPrimaryColor,
                  ),
            ),
          ],
        );
      },
    );
  }
}
