
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../models/enums/session_status.dart';
import '../../models/enums/session_type.dart';
import '../../models/enums/subject.dart';
import '../../models/session.dart';
import '../repo/sessions_repo.dart';
import 'course_controller.dart';

class SessionController extends GetxController{
  final SessionRepo sessionRepo;
  SessionController({required this.sessionRepo});

  List<Session>sessionList = [];

  getAllSession() async {
    sessionList = [];
    var response = await sessionRepo.getAllSessions();
    var sessions = response.body;

    for(var element in sessions){
      sessionList.add(Session.fromMap(element));
    }

    sessionList.sort(((a, b) => a.startTime!.compareTo(b.startTime!)));
    update();
    return sessionList;
  }

  Future<void> bookSession(String tutorId, Subject subject, DateTime startTime) async{
    await Get.find<CourseController>().getCourseBetweenUserAndTutor(tutorId);
    var courses = Get.find<CourseController>().courses;
    var course = courses
        .firstWhere((course) => course.subject == subject);

    final session = Session(
      createUserId: Constants.appName,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: startTime.add(const Duration(hours: 1)).millisecondsSinceEpoch,
      sessionStatus: SessionStatus.scheduled,
      tutorId: tutorId,
      userId: course.userId,
      sessionType: SessionType.musicDirect,
      courseId: course.id,
      subject: subject,
    );

    await sessionRepo.bookSession(session);

  }

}