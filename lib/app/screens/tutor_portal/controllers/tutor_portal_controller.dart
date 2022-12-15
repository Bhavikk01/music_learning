
import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/homework.dart';
import '../../../models/tutor_metrics.dart';
import '../../../models/workout.dart';
import '../repo/tutor_portal_repo.dart';

class TutorPortalController extends GetxController{

  final TutorPortalRepo tutorPortalRepo;
  TutorPortalController({required this.tutorPortalRepo});

  bool isLoading = true;
  late TutorMetrics tutorMetrics;
  late List<HomeWork> homeworks;
  late List<dynamic> studentsWorkout;
  late List<Workout> workoutBank;
  late List<dynamic> myStudents;
  late List<dynamic> myCourse;

  getAllAttribute(
      {required bool isLoading,
      required TutorMetrics tutorMetrics,
      required List<HomeWork> homeworks,
      required List<dynamic> studentsWorkout,
      required List<Workout> workoutBank,
      required List<dynamic> myStudents,
      required List<dynamic> myCourse}) {
    this.isLoading = isLoading;
    this.tutorMetrics = tutorMetrics;
    this.homeworks = homeworks;
    this.studentsWorkout = studentsWorkout;
    this.myStudents = myStudents;
    this.myCourse = myCourse;
    this.workoutBank = workoutBank;
  }

  getAllTutorPortalData() async {
    try{
      final tutorMetrics = await tutorPortalRepo.getQuickTutorMetrics();
      final homeworks = <HomeWork>[];
      final workoutBank = await tutorPortalRepo.getWorkoutBankOfTutor();
      final myCourse = await tutorPortalRepo.getAllCourseOfTutor();
      final studentsWorkout = await tutorPortalRepo.getAllStudentsOfTutor();
      final myStudents = await tutorPortalRepo.getAllStudentsOfTutor();
      getAllAttribute(
          isLoading: false,
          tutorMetrics: tutorMetrics,
          homeworks: homeworks,
          studentsWorkout: studentsWorkout,
          workoutBank: workoutBank,
          myStudents: myStudents,
          myCourse: myCourse);
      update();
    }catch(e){
      log(e.toString());
    }
  }

}