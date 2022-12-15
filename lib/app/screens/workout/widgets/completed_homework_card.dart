import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../data/controllers/tutor_controller.dart';
import '../../../models/enums/homework_status.dart';
import '../../../models/enums/subject.dart';
import '../../../models/homework.dart';

class CompletedHomeworkCard extends StatefulWidget {
  final HomeWork homeWork;
  const CompletedHomeworkCard({Key? key, required this.homeWork})
      : super(key: key);

  @override
  State<CompletedHomeworkCard> createState() => _CompletedHomeworkCardState();
}

class _CompletedHomeworkCardState extends State<CompletedHomeworkCard> {
  String tutorName = '';
  Subject sub = Subject.guitar;

  getData() async {
    var tutor = Get.find<TutorController>().getTutor(widget.homeWork.tutorId!);
    tutorName = tutor.name!;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      margin: EdgeInsets.only(top: 24.h),
      decoration: BoxDecoration(
        color: ThemeColors.milkyWhite,
        border: Border.all(
          width: 1,
          color: ThemeColors.transparent,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.shadowColor.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.homeWork.name ?? Constants.workout,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Assigned by $tutorName',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: ThemeColors.textPrimaryColor),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'You\'ve completed 4/4 submissions on',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: ThemeColors.textPrimaryColor),
          ),
          SizedBox(
            height: 12.h,
          ),
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    'Assigned On  ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    ' : ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    DateFormat('dd MMM yy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.homeWork.createdAt!)),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Deadline  ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    ' : ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    DateFormat('dd MMM yy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                                widget.homeWork.createdAt!)
                            .add(const Duration(days: 10))),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Completed On  ',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: widget.homeWork.state == HomeworkStatus.passed
                            ? Colors.green
                            : Colors.red),
                  ),
                  Text(
                    ' : ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    DateFormat('dd MMM yy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.homeWork.attempedTime!)),
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: widget.homeWork.state == HomeworkStatus.passed
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Status  ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    ' : ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
                  ),
                  Text(
                    'Completed',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textPrimaryColor),
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
