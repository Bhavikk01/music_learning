
import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/controllers/course_controller.dart';
import '../../../data/controllers/sessions_controller.dart';
import '../../../data/controllers/tutor_controller.dart';
import '../../../models/enums/session_type.dart';
import '../../../models/enums/subject.dart';
import '../../../models/tutors.dart';

class SubjectScreenController extends GetxController implements GetxService{

  late Subject subject;
  List<Tutor> tutors = [];
  List<String> alreadyBookedTutor = [];
  List<String> demoNotAvailable = [];

  getSubjects(Subject subject){
    this.subject = subject;
  }

  Future<void> getAllTutorsEvent() async {

    try {
      var demoNotAvailable = <String>[];
      var alreadyBookedTutor = <String>[];
      var tutors = <Tutor>[];

      var sessions = await SessionController(sessionRepo: Get.find())
          .getAllSession();
      for (var session in sessions) {
        if (session.sessionType == SessionType.musicDemo) {
          demoNotAvailable.add(session.tutorId ?? '');
        }
      }

      var course = await CourseController(courseRepo: Get.find())
          .getAllCourse();
      for (var course in course) {
        if (subject == course.subject) {
          alreadyBookedTutor.add(course.currentTutorId!);
        }
      }

      var tutor = await TutorController(tutorRepo: Get.find())
          .getAllTutors();
      for(var tutor in tutor){
        if(tutor.subjectsTaught?.contains(subject) ?? false){
          tutors.add(tutor);
        }
      }

      tutors.sort((a, b) {
        if (alreadyBookedTutor.contains(b.id)) {
          return 1;
        } else {
          return 0;
        }
      });

      this.demoNotAvailable = demoNotAvailable;
      this.alreadyBookedTutor = alreadyBookedTutor;
      this.tutors = tutors;
      update();

    } catch (e) {
      log('error occurred here: $e');
    }
  }
}