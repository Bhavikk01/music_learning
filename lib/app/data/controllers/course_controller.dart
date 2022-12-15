import 'dart:developer';

import 'package:get/get.dart';

import '../../models/course.dart';
import '../repo/course_repo.dart';

class CourseController extends GetxController{
  final CourseRepo courseRepo;

  CourseController({required this.courseRepo});


  List<Course>courseList = [];
  List<Course>courses = [];

  getAllCourse() async {
    courseList = [];
    var response = await courseRepo.getAllCourse();
    var courses = response.body;
    log(courses.toString());
    for(var element in courses){
      courseList.add(Course.fromMap(element));
    }

    courseList.sort(((a, b) => a.createdAt!.compareTo(b.createdAt!)));
    update();
    return courseList;
  }

  getCourseBetweenUserAndTutor(String tutorId) async {
    courses = [];
    var response = await courseRepo.getCourseBetweenUserAndTutor(tutorId);
    final List sessions = response.body;

    for(var element in sessions){
      courses.add(Course.fromMap(element));
    }
    courses.sort(((a, b) => a.createdAt!.compareTo(b.createdAt!)));
    // return courses;
  }
}