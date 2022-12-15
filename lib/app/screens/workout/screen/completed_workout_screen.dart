import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../../models/enums/subject.dart';
import '../../../models/homework.dart';
import '../../../widgets/custom_drop_down.dart';
import '../widgets/completed_homework_card.dart';

class CompletedHomeworkScreen extends StatefulWidget {
  final List<HomeWork> homeworks;
  const CompletedHomeworkScreen({
    Key? key,
    required this.homeworks,
  }) : super(key: key);

  @override
  State<CompletedHomeworkScreen> createState() =>
      _CompletedHomeworkScreenState();
}

class _CompletedHomeworkScreenState extends State<CompletedHomeworkScreen> {
  Subject subject = Subject.guitar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.completedWorkouts),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomDropDown(
              data: Subject.values,
              text: Constants.selectCourse,
              updateCallback: (sub) {
                setState(() {
                  subject = sub;
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
                .map((e) => CompletedHomeworkCard(homeWork: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
