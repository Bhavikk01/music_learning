import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../models/enums/homework_status.dart';
import '../../../models/homework.dart';


class HomeworkScreen extends StatefulWidget {
  final List<HomeWork> homeworks;
  const HomeworkScreen({
    Key? key,
    required this.homeworks,
  }) : super(key: key);

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  List<HomeWork> homeworks = [];
  List<HomeWork> submittedHomeworks = [];
  List<HomeWork> inProgressHomeworks = [];
  List<HomeWork> pendingHomeworks = [];

  @override
  void initState() {
    homeworks = widget.homeworks;
    submittedHomeworks = homeworks
        .where((element) => (element.state == HomeworkStatus.passed ||
            element.state == HomeworkStatus.failed))
        .toList();

    inProgressHomeworks = homeworks
        .where(
          (element) => element.state == HomeworkStatus.inProgress,
        )
        .toList();

    pendingHomeworks = homeworks
        .where((element) => element.state == HomeworkStatus.assigned)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(
          Constants.myWorkouts,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontSize: 28.sp,
              ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 36.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ThemeColors.brightGreen,
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
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Total Workouts Assigned: ${homeworks.length}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Total Workouts Submitted: ${submittedHomeworks.length}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Submit 2 more workouts to get',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.trophy,
                              color: ThemeColors.black,
                              size: 30.h,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              'Rockstar Badge',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: ThemeColors.textPrimaryColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.coins,
                              color: ThemeColors.black,
                              size: 30.h,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '50 Pickit Coins',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: ThemeColors.textPrimaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
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
                  children: [
                    Text(
                      'In Progress: ${inProgressHomeworks.length} Workouts',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.buttonDarkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        minimumSize: Size(120.w, 30.h),
                      ),
                      onPressed: () => Get.toNamed(
                        RoutePaths.inProgressWorkoutScreen,
                        arguments: inProgressHomeworks,
                      ),
                      child: Text(
                        Constants.viewInProgress,
                        style: Theme.of(context).textTheme.button?.copyWith(
                              color: ThemeColors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
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
                  children: [
                    Text(
                      'Pending: ${pendingHomeworks.length} Workouts',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.buttonDarkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        minimumSize: Size(120.w, 30.h),
                      ),
                      onPressed: () => Get.toNamed(
                        RoutePaths.inProgressWorkoutScreen,
                        arguments: pendingHomeworks,
                      ),
                      child: Text(
                        Constants.viewPending,
                        style: Theme.of(context).textTheme.button?.copyWith(
                              color: ThemeColors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
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
                  children: [
                    Text(
                      'Completed: ${submittedHomeworks.length} Workouts',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.buttonDarkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        minimumSize: Size(120.w, 30.h),
                      ),
                      onPressed: () => Get.toNamed(
                        RoutePaths.completedWorkoutScreen,
                        arguments: submittedHomeworks,
                      ),
                      child: Text(
                        Constants.viewSubmissions,
                        style: Theme.of(context).textTheme.button?.copyWith(
                              color: ThemeColors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
