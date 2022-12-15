import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/controllers/tutor_controller.dart';
import '../../models/course.dart';
import '../../utils/utils.dart';
import '../../widgets/multi_color_progress_bar.dart';

class MyCourseCard extends StatefulWidget {
  final Course course;
  const MyCourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<MyCourseCard> createState() => _MyCourseCardState();
}

class _MyCourseCardState extends State<MyCourseCard> {
  String tutorName = '';

  getTutorName() async {
    tutorName = (await Get.find<TutorController>().getAllTutors())
            .firstWhere((element) => element.id == widget.course.currentTutorId)
            .name ??
        Constants.tutor;

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getTutorName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 24.w,
      ),
      decoration: BoxDecoration(
        color: ThemeColors.lightPurple,
        borderRadius: BorderRadius.circular(14.w),
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(
          left: 48.w,
          right: 48.w,
          bottom: 24.h,
        ),
        title: Text(
          capitalize(widget.course.subject?.name ?? 'Guitar'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Constants.tutor,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
              ),
              Text(
                tutorName,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Start date',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
              ),
              SizedBox(
                height: 48.h,
              ),
              Text(
                DateFormat('dd/M/yy').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        widget.course.createdAt!)),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
              ),
            ],
          ),
          if (widget.course.sessionsTaken != null &&
              widget.course.slotsLeft != null)
            MultiColorProgressBar(
              total: widget.course.sessionsTaken! + widget.course.slotsLeft!,
              completed: widget.course.sessionsTaken!,
              text:
                  '${widget.course.sessionsTaken} of ${widget.course.sessionsTaken! + widget.course.slotsLeft!} sessions completed',
            ),
          SizedBox(
            height: 24.h,
          ),
          MultiColorProgressBar(
            total: 8,
            completed: 4,
            text: '4 of 8 workouts completed',
          ),
        ],
      ),
    );
  }
}

class SessionProgressBar extends StatelessWidget {
  final int totalSessions;
  final int completedSessions;
  const SessionProgressBar(
      {Key? key, required this.totalSessions, required this.completedSessions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        12.w,
      ),
      child: LinearProgressIndicator(
        value: completedSessions / totalSessions,
        minHeight: 12.h,
        valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.buttonDarkColor),
        backgroundColor: ThemeColors.milkyWhite,
      ),
    );
  }
}

class WorkoutProgressBar extends StatelessWidget {
  final int totalWorkouts;
  final int completedWorkoutss;
  const WorkoutProgressBar(
      {Key? key, required this.totalWorkouts, required this.completedWorkoutss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        12.w,
      ),
      child: LinearProgressIndicator(
        value: completedWorkoutss / totalWorkouts,
        minHeight: 12.h,
        valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.buttonDarkColor),
        backgroundColor: ThemeColors.milkyWhite,
      ),
    );
  }
}
