import 'dart:developer';

import 'package:get/get.dart';

import '../../screens/audio_workout/controllers/audio_controller.dart';
import '../../screens/buy_course/controllers/buy_course_controller.dart';
import '../../screens/buy_course/repo/buy_course_repo.dart';
import '../../screens/home_screens/controller/home_screen_controller.dart';
import '../../screens/my_workout/controllers/workout_homework_controller.dart';
import '../../screens/subject_screen/controllers/subject_screen_controller.dart';
import '../../screens/tutor_portal/controllers/tutor_portal_controller.dart';
import '../../screens/tutor_portal/repo/tutor_portal_repo.dart';
import '../../screens/video_workout/controllers/video_controller.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';
import '../controllers/course_controller.dart';
import '../controllers/homework_controller.dart';
import '../controllers/phone_auth_controller.dart';
import '../controllers/sessions_controller.dart';
import '../controllers/tutor_controller.dart';
import '../controllers/workout_controller.dart';
import '../repo/course_repo.dart';
import '../repo/homework_repo.dart';
import '../repo/phone_auth_repo.dart';
import '../repo/sessions_repo.dart';
import '../repo/tutor_repo.dart';

Future<void> init() async {

  log('inside the inti method');
  //API Client Initialization
  Get.lazyPut(()=> ApiClient(appBaseUrl: ApiUrl.baseUrl));

  //Repo Initialization

  log('inside the repo initialization method');
  Get..lazyPut(() => TutorRepo(apiClient: Get.find()))
  ..lazyPut(() => HomeworkRepo(apiClient: Get.find()))
  ..lazyPut(() => SessionRepo(apiClient: Get.find()))
  ..lazyPut(() => CourseRepo(apiClient: Get.find()))
  ..lazyPut(() => PhoneAuthRepo(apiClient: Get.find()))
  ..lazyPut(() => BuyCourseRepo(apiClient: Get.find()))
  ..lazyPut(() => TutorPortalRepo(apiClient: Get.find()));

  //Controllers Initialization

  log('inside the controller initialization method');
  Get..lazyPut(() => CourseController(courseRepo: Get.find()))
  ..lazyPut(() => TutorController(tutorRepo: Get.find()))
  ..lazyPut(() => SessionController(sessionRepo: Get.find()))
  ..lazyPut(() => HomeworkController(homeworkRepo: Get.find()))
  ..lazyPut(() => PhoneAuthController(phoneAuthRepo: Get.find()))
  ..lazyPut(() => BuyCourseController(buyCourseRepo: Get.find()))
  ..lazyPut<AudioController>(AudioController.new)
  ..lazyPut<VideoController>(VideoController.new)
  ..lazyPut(() => TutorPortalController(tutorPortalRepo: Get.find()))
  ..lazyPut<WorkoutController>(WorkoutController.new)
    ..lazyPut(WorkOutHomeworkController.new)
  ..lazyPut<SubjectScreenController>(SubjectScreenController.new)
  ..lazyPut<HomeScreenController>(HomeScreenController.new);

}