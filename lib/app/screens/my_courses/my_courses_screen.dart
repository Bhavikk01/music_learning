import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/controllers/course_controller.dart';
import '../../models/course.dart';
import 'my_course_card.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  List<Course> courses = [];

  void getCourses() async {
    courses = await Get.find<CourseController>().getAllCourse();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: Text(
            Constants.myCourses,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 28.sp,
                ),
          ),
          bottom: PreferredSize(
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3.h,
              indicatorColor: ThemeColors.textPrimaryColor,
              tabs: [
                Text(
                  Constants.active,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: 18.sp,
                      ),
                ),
                Text(
                  Constants.inactive,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: 18.sp,
                      ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(40.h),
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: courses.map((e) => MyCourseCard(course: e)).toList(),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
