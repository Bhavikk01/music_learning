import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../../models/enums/homework_status.dart';
import '../../../models/enums/subject.dart';
import '../../../models/enums/workout_type.dart';
import '../../../models/homework.dart';
import '../../../widgets/custom_drop_down.dart';
import '../widgets/in_progress_card.dart';

class InProgressScreen extends StatefulWidget {
  final List<HomeWork> homeworks;
  const InProgressScreen({
    Key? key,
    required this.homeworks,
  }) : super(key: key);

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  WorkoutType workoutType = WorkoutType.values[0];
  Subject subject = Subject.guitar;
  @override
  Widget build(BuildContext context) {

    var homeworksPending = <HomeWork>[];
    for(var element in widget.homeworks){
      if(element.workoutSkeletonType == workoutType){
        homeworksPending.add(element);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: (widget.homeworks.isNotEmpty)
            ? (widget.homeworks.first.state == HomeworkStatus.assigned)
                ? const Text(Constants.pendingWorkouts)
                : const Text(Constants.inProgressWorkouts)
            : const Text(Constants.inProgressWorkouts),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomDropDown(
              data: Subject.values,
              text: Constants.selectCourse,
              updateCallback: (subjectType) {
                setState(() {
                  subject = subjectType;
                });
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: widget.homeworks
                .map((e) => InProgressCard(homeWork: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
